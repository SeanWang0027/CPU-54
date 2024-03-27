`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:53:44
// Design Name: 
// Module Name: cpu
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module CPU_54(
    input CPU_clk,
    input CPU_rst,
    input [31:0] IM_instr,
    input [31:0] DM_rdata,
    output DM_CS,
    output DM_W,
    output DM_R,
    output [31:0] Rt_to_DM,
    output [31:0] ALUR_to_DM,
    output [31:0] PC_to_IM,
    output [1:0] Bit_S
);

    wire [31:0] Rs;
    wire addi_, addiu_, andi_, ori_, xori_, lw_, sw_, beq_, bne_;
    wire slti_, sltiu_, lui_;

    assign addi_ = (IM_instr[31:26] == 6'b001_000);

    assign addiu_ = (IM_instr[31:26] == 6'b001_001);

    assign andi_ = (IM_instr[31:26] == 6'b001_100);

    assign ori_ = (IM_instr[31:26] == 6'b001_101);

    assign xori_ = (IM_instr[31:26] == 6'b001_110);

    assign lw_ = (IM_instr[31:26] == 6'b100_011);

    assign sw_ = (IM_instr[31:26] == 6'b101_011);

    assign beq_ = (IM_instr[31:26] == 6'b000_100);

    assign bne_ = (IM_instr[31:26] == 6'b000_101);

    assign slti_ = (IM_instr[31:26] == 6'b001_010);

    assign sltiu_ = (IM_instr[31:26] == 6'b001_011);
    
    assign lui_ = (IM_instr[31:26] == 6'b001_111);

    wire _slt, _sltu, _sll, _srl, _sra, _sllv, _srlv, _srav, _jr;
    wire _add, _addu, _sub, _subu, _and, _or, _xor, _nor;
    
    assign _add = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_000);

    assign _addu = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_001);

    assign _sub = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_010);

    assign _subu = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_011);

    assign _and = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_100);

    assign _or = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_101);

    assign _xor = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_110);

    assign _nor = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b100_111);

    assign _slt = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b101_010);

    assign _sltu = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b101_011);

    assign _sll = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_000);

    assign _srl = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_010);

    assign _sra = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_011);

    assign _sllv = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_100);

    assign _srlv = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_110);

    assign _srav = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b000_111);

    assign _jr = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_000);

    wire clz_, divu_, div_, multu_, mul_;
    wire lb_, lbu_, lh_, lhu_;
    wire sb_, sh_;
    wire mfhi_, mflo_;
    wire mthi_, mtlo_;
    wire bgez_, jalr_;
    wire break_, syscall_, teq_, eret_, mfc0_, mtc0_;

    assign clz_ = (IM_instr[31:26] == 6'b011_100 && IM_instr[5:0] == 6'b100_000);

    assign divu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_011);

    assign div_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_010);

    assign multu_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b011_001);

    assign mul_ = (IM_instr[31:26] == 6'b011_100 && IM_instr[5:0] == 6'b000_010);

    assign lb_ = (IM_instr[31:26] == 6'b100_000);

    assign lbu_ = (IM_instr[31:26] == 6'b100_100);

    assign lh_ = (IM_instr[31:26] == 6'b100_001);

    assign lhu_ = (IM_instr[31:26] == 6'b100_101);

    assign sb_ = (IM_instr[31:26] == 6'b101_000);

    assign sh_ = (IM_instr[31:26] == 6'b101_001);

    assign mfhi_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_000);

    assign mflo_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_010);

    assign mthi_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_001);

    assign mtlo_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b010_011);

    assign bgez_ = (IM_instr[31:26] == 6'b000_001);

    assign jalr_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_001);

    assign break_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_101);

    assign syscall_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b001_100);

    assign teq_ = (IM_instr[31:26] == 6'b000_000 && IM_instr[5:0] == 6'b110_100);

    assign eret_ = (IM_instr[31:26] == 6'b010_000 && IM_instr[5:0] == 6'b011_000);

    assign mfc0_ = (IM_instr[31:26] == 6'b010_000 && IM_instr[25:21] == 5'b00000);

    assign mtc0_ = (IM_instr[31:26] == 6'b010_000 && IM_instr[25:21] == 5'b00100);

    wire j_, jal_;

    assign j_ = (IM_instr[31:26] == 6'b000_010);

    assign jal_ = (IM_instr[31:26] == 6'b000_011);

   
    wire [31:0] CLZ_tmp;
    assign CLZ_tmp = (Rs[31]==1? 32'h00000000:Rs[30]==1? 32'h00000001:Rs[29]==1? 32'h00000002:Rs[28]==1? 32'h00000003:Rs[27]==1? 32'h00000004:
                     Rs[26]==1? 32'h00000005:Rs[25]==1? 32'h00000006:Rs[24]==1? 32'h00000007:Rs[23]==1? 32'h00000008:Rs[22]==1? 32'h00000009:
                     Rs[21]==1? 32'h0000000a:Rs[20]==1? 32'h0000000b:Rs[19]==1? 32'h0000000c:Rs[18]==1? 32'h0000000d:Rs[17]==1? 32'h0000000e:
                     Rs[16]==1? 32'h0000000f:Rs[15]==1? 32'h00000010:Rs[14]==1? 32'h00000011:Rs[13]==1? 32'h00000012:Rs[12]==1? 32'h00000013:
                     Rs[11]==1? 32'h00000014:Rs[10]==1? 32'h00000015:Rs[9]==1? 32'h00000016:Rs[8]==1? 32'h00000017:Rs[7]==1? 32'h00000018:
                     Rs[6]==1? 32'h00000019:Rs[5]==1? 32'h0000001a:Rs[4]==1? 32'h0000001b:Rs[3]==1? 32'h0000001c:Rs[2]==1? 32'h0000001d:
                     Rs[1]==1? 32'h0000001e:Rs[0]==1? 32'h0000001f:32'h00000020);

    wire [4:0] Rdc;
    wire [4:0] Rsc;
    wire [4:0] Rtc;
    wire [4:0] ALUC;
    wire RF_W;

    wire M1_1;
    wire M1_2;
    wire M2;

    wire M3_1;
    wire M3_2;
    wire M3_3;
    wire M3_4;
    wire M3_5;
    wire M3_6;
    wire M3_7;

    wire M4_1;
    wire M4_2;
    wire M5_1;
    wire M5_2;
    wire M6_1;
    wire M6_2;

    wire M7_1;
    wire M7_2;
    wire M7_3;
    wire M7_4;

    wire M8_1;
    wire M8_2;
    wire M8_3;
    wire M8_4;

    wire [31:0] DM_DATA;

    wire exception;
    wire [4:0] cause;
    wire [31:0] CP0_wdata;
    wire [31:0] CP0_rdata;
    wire [31:0] status;
    wire [31:0] exc_addr;

    wire HI_ctrl;
    wire LO_ctrl;
    wire [31:0] HI_out;
    wire [31:0] HI_in;
    wire [31:0] LO_out;
    wire [31:0] LO_in;


    wire busy = 0;

    wire [31:0] divu_q;
    wire [31:0] divu_r;
    wire divu_busy;
    wire [31:0] divu_q_tmp;
    wire [31:0] divu_r_tmp;

    wire [31:0] div_q;
    wire [31:0] div_r;
    wire div_busy;
    wire [31:0] div_q_tmp;
    wire [31:0] div_r_tmp;


    wire [63:0] multu_r;

    wire [63:0] mul_r;

    wire [31:0] ALU_out;
    wire [31:0] NPC;
    wire [31:0] Rt;
    wire [31:0] PC_form_PCReg;

    wire [31:0] Ext5_out;
    wire [31:0] Ext18_out;
    wire [31:0] Ext16_out;
    wire [31:0] Ext16_sign;
    wire [31:0] Ext16_unsign;
    wire Ext16_sign_Judge;

    wire [31:0] MUX1_out;
    wire [31:0] MUX2_out;
    wire [31:0] MUX3_out;

    wire [31:0] MUX5_out;

    wire [31:0] MUX6_out;

    wire Zero;
    wire Carry;
    wire Negative;
    wire OverFlow;

    assign PC_to_IM = PC_form_PCReg;
    assign CP0_wdata = Rt;
    assign exception = (break_ || syscall_ || (teq_ && Zero));
    assign cause = break_ ? 5'b01001 : (syscall_ ? 5'b01000 : (teq_ ? 5'b01101 : 5'b00000));

    assign busy = (divu_busy || div_busy);

    assign ALUR_to_DM = ALU_out;
    assign Rsc = IM_instr[25:21];
    assign Rtc = IM_instr[20:16];
    assign RF_W = !(sw_ || sb_ || sh_ || _jr || j_ || beq_ || bne_ || bgez_ || mtc0_ || eret_ || syscall_ || teq_ || break_ || divu_ || div_ || multu_ || mthi_ || mtlo_);

    assign DM_CS = (lw_ || lb_ || lbu_ || lh_ || lhu_ || sw_ || sb_ || sh_);
    assign DM_W = (sw_ || sb_ || sh_);
    assign DM_R = (lw_ || lb_ || lbu_ || lh_ || lhu_);

    assign Rt_to_DM = Rt;

    assign M3_1 = (lw_ || lb_ || lbu_ || lh_ || lhu_);
    assign M3_2 = mfc0_;
    assign M3_3 = mflo_;
    assign M3_4 = mfhi_;
    assign M3_5 = mul_;
    assign M3_6 = clz_;

    
    assign M1_1 = (!j_ && !jal_ && !jalr_);
    assign M1_2 = (_jr || jalr_);
    assign M2 = ((beq_ && Zero) || (bne_ && !Zero) || (bgez_ && (Rs[31]==1'b0)));


    assign M4_1 = (addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || slti_ || sltiu_ || lui_ || lb_ || lbu_ || lh_ || lhu_ || mfc0_);
    assign M4_2 = jal_;
    assign M5_1 = (_sll || _srl || _sra);
    assign M5_2 = (jal_ || jalr_);
    assign M6_1 = (addi_ || addiu_ || andi_ || ori_ || xori_ || lw_ || sw_ || slti_ || sltiu_ || lui_ || lb_ || lbu_ || lh_ || lhu_ || sb_ || sh_);
    assign M6_2 = (jal_ || jalr_);

    assign M7_1 = mtlo_;
    assign M7_2 = divu_;
    assign M7_3 = div_;
    assign M7_4 = multu_;

    assign M8_1 = mthi_;
    assign M8_2 = divu_;
    assign M8_3 = div_;
    assign M8_4 = multu_;

    assign Rdc = M4_2 ? 5'd31 : (M4_1 ? IM_instr[20:16] : IM_instr[15:11]);
    

    assign ALUC[4] = lui_;
    assign ALUC[3] = _slt || _sltu || slti_ || sltiu_ || _sll || _srl || _sra || _sllv || _srlv || _srav;
    assign ALUC[2] = _and || andi_ || _or || ori_ || _xor || xori_ || _nor || _sra || _sllv || _srlv || _srav;
    assign ALUC[1] = _sub || _subu || beq_ || bne_ || bgez_ || teq_ || _xor || xori_ || _nor || _sll || _srl || _srlv || _srav;
    assign ALUC[0] = _addu || addiu_ || _subu || beq_ || bne_ || bgez_ || teq_ || _or || ori_ || _nor || _sltu || sltiu_ || _srl || _sllv || _srav || jal_ || jalr_;

    assign DM_DATA = (lb_ ? {{24{DM_rdata[31]}},DM_rdata[31:24]} : (lbu_ ? {24'b0,DM_rdata[31:24]} : (lh_ ? {{16{DM_rdata[31]}},DM_rdata[31:16]} : (lhu_ ? {16'b0,DM_rdata[31:16]} : DM_rdata))));
    assign Bit_S = (sb_ ? 0 : (sh_ ? 1 : 2));
   
    assign NPC = PC_form_PCReg + 4;

    assign Ext5_out = {27'b0, IM_instr[10:6]};
    assign Ext18_out = {{14{IM_instr[15]}}, {IM_instr[15:0], 2'b0}};
    assign Ext16_sign_Judge = (sw_ || sb_ || sh_ || lw_ || lb_ || lbu_ || lh_ || lhu_ || addi_ || addiu_ || slti_ || sltiu_);
    assign Ext16_sign = {{16{IM_instr[15]}}, IM_instr[15:0]};
    assign Ext16_unsign = {16'b0, IM_instr[15:0]};
    assign Ext16_out = Ext16_sign_Judge ? Ext16_sign : Ext16_unsign;

    assign MUX2_out = M2 ? (NPC + Ext18_out) : NPC;
    assign MUX1_out = ((eret_ || exception) ? exc_addr :(M1_2 ? Rs : (M1_1 ? MUX2_out : {PC_form_PCReg[31:28], IM_instr[25:0], 2'b0})));

    assign MUX3_out = M3_1 ? DM_DATA : (M3_2 ? CP0_rdata : (M3_3 ? LO_out : (M3_4 ? HI_out : (M3_5 ? mul_r[31:0] : (M3_6 ? CLZ_tmp : ALU_out)))));

    assign MUX5_out = M5_2 ? PC_form_PCReg : (M5_1 ? Ext5_out : Rs);

    assign MUX6_out = M6_2 ? 32'd4 : (M6_1 ? Ext16_out : Rt);

    assign LO_ctrl = (divu_ || div_ || mtlo_ || multu_);
    assign HI_ctrl = (divu_ || div_ || mthi_ || multu_);

    assign LO_in = M7_1 ? Rs : (M7_2 ? divu_q : (M7_3 ? div_q : (M7_4 ? multu_r[31:0] : 0)));
    assign HI_in = M8_1 ? Rs : (M8_2 ? divu_r : (M8_3 ? div_r : (M8_4 ? multu_r[63:32] : 0)));

    DIV div(
        .dividend(Rs),
        .divisor(Rt),
        .start(div_),
        .clock(CPU_clk),
        .reset(CPU_rst),
        .q(div_q),
        .r(div_r),
        .busy(div_busy)
    );

    DIVU divu(
        .dividend(Rs),
        .divisor(Rt),
        .start(divu_),
        .clock(CPU_clk),
        .reset(CPU_rst),
        .q(divu_q),
        .r(divu_r),
        .busy(divu_busy)
    );



    MULTU multu(
        .clk(CPU_clk),
        .reset(CPU_rst),
        .start(multu_),
        .a(Rs),
        .b(Rt),
        .z(multu_r)
    );

    MUL mul(
        .clk(CPU_clk),
        .reset(CPU_rst),
        .start(mul_),
        .a(Rs),
        .b(Rt),
        .z(mul_r)
    );

    HILOreg HI(
        .clk(CPU_clk),
        .rst(CPU_rst),
        .wena(HI_ctrl),
        .data_in(HI_in),
        .data_out(HI_out)
    );

    HILOreg LO(
        .clk(CPU_clk),
        .rst(CPU_rst),
        .wena(LO_ctrl),
        .data_in(LO_in),
        .data_out(LO_out)
    );

    CP0 cp0(
        .clk(CPU_clk),
        .rst(CPU_rst),
        .mfc0(mfc0_),
        .mtc0(mtc0_),
        .pc(PC_form_PCReg),
        .addr(IM_instr[15:11]),
        .data(CP0_wdata),
        .exception(exception),
        .eret(eret_),
        .cause(cause),
        .rdata(CP0_rdata),
        .status(status),
        .exc_addr(exc_addr)
    );

    PCReg PCReg_uut(
        .PC_clk(CPU_clk),
        .PC_rst(CPU_rst),
        .PC_ena(1),
        .PC_wena(!busy),
        .PC_in(MUX1_out),
        .PC_out(PC_form_PCReg)
    );

    RegFile cpu_ref(
        .RF_clk(CPU_clk),
        .RF_rst(CPU_rst),
        .RF_ena(1),
        .RF_W(RF_W),
        .Rdc(Rdc),
        .Rsc(Rsc),
        .Rtc(Rtc),
        .Rd(MUX3_out),
        .Rs(Rs),
        .Rt(Rt)
    );

    ALU alu(
        .A(MUX5_out),
        .B(MUX6_out),
        .ALUC(ALUC),
        .Result(ALU_out),
        .Zero(Zero),
        .Carry(Carry),
        .Negative(Negative),
        .OverFlow(OverFlow)
    );

endmodule

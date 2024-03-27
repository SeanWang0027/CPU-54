`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 21:14:00
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,                 // 输入时钟
    input reset,                  // 复位信号
    output [31:0] inst,           // 指令输出（32位）
    output [31:0] pc              // 程序计数器输出（32位）
);
    wire [31:0] instr;            // 指令信号（32位）
    wire [31:0] rt;               // 寄存器信号（32位）
    wire [31:0] ALU_R;            // ALU结果信号（32位）
    wire CS;                      // 控制信号
    wire DM_W;                    // 数据内存写使能信号
    wire DM_R;                    // 数据内存读使能信号
    wire [31:0] DM_addr;          // 数据内存地址信号（32位）
    wire [31:0] IM_addr;          // 指令内存地址信号（32位）
    wire [31:0] DM_rdata;         // 数据内存读数据信号（32位）
	wire [1:0] Bit_S;             // 选择信号（2位）
    wire [10:0] addr;             // 地址信号（11位）

    assign inst=instr;            // 输出指令信号
    assign DM_addr = (ALU_R - 32'h10010000);    // 计算数据内存地址
    assign IM_addr = (pc- 32'h00400000);        // 计算指令内存地址
    assign addr = IM_addr[12:2];                 // 计算地址信号

    imem instr_mem(
        .addr(addr),
        .instr(instr)
    );

    CPU_54 sccpu(
        .CPU_clk(clk_in),
        .CPU_rst(reset),
        .IM_instr(instr),
        .DM_rdata(DM_rdata),
        .DM_CS(CS),
        .DM_W(DM_W),
        .DM_R(DM_R),
        .Rt_to_DM(rt),
        .ALUR_to_DM(ALU_R),
        .PC_to_IM(pc),
        .Bit_S(Bit_S)
    );

    DMEM DMEM_uut(
        .DM_clk(clk_in),
        .CS(CS),
        .DM_R(DM_R),
        .DM_W(DM_W),
        .Addr(DM_addr[10:0]),
        .Data_In(rt),
        .Bit_S(Bit_S),
        .Data_Out(DM_rdata)
     );   
    
endmodule

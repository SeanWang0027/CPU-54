`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:20:35
// Design Name: 
// Module Name: cp0
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


module CP0(
	input clk,                     // 输入时钟
	input rst,                     // 复位信号
	input mfc0,                    // CPU指令为Mfc0
	input mtc0,                    // CPU指令为Mtc0
	input [31:0] pc,               // 程序计数器信号（32位）
	input [4:0] addr,              // 指定的CP0寄存器
	input [31:0] data,             // 从GP寄存器传递的数据，用于替换CP0寄存器
	input exception,               // 异常信号
	input eret,                    // 指令为ERET（异常返回）
	input [4:0] cause,             // 异常原因
	output [31:0] rdata,           // 从CP0寄存器传递给GP寄存器的数据
	output [31:0] status,          // 状态寄存器
	output [31:0] exc_addr         // 异常时的程序计数器地址
);
reg [31:0] CP0_reg [0:31];        // CP0寄存器数组，共32个寄存器

assign status = CP0_reg[12];      // 状态寄存器的输出

always @(posedge clk or posedge rst)
begin
	if(rst)
	begin
		// 复位时，将所有寄存器清零
		CP0_reg[0] <= 32'b0;
		CP0_reg[1] <= 32'b0;
		CP0_reg[2] <= 32'b0;
		CP0_reg[3] <= 32'b0;
		CP0_reg[4] <= 32'b0;
		CP0_reg[5] <= 32'b0;
		CP0_reg[6] <= 32'b0;
		CP0_reg[7] <= 32'b0;
		CP0_reg[8] <= 32'b0;
		CP0_reg[9] <= 32'b0;
		CP0_reg[10] <= 32'b0;
		CP0_reg[11] <= 32'b0;
		CP0_reg[12] <= 32'b0;
		CP0_reg[13] <= 32'b0;
		CP0_reg[14] <= 32'b0;
		CP0_reg[15] <= 32'b0;
		CP0_reg[16] <= 32'b0;
		CP0_reg[17] <= 32'b0;
		CP0_reg[18] <= 32'b0;
		CP0_reg[19] <= 32'b0;
		CP0_reg[20] <= 32'b0;
		CP0_reg[21] <= 32'b0;
		CP0_reg[22] <= 32'b0;
		CP0_reg[23] <= 32'b0;
		CP0_reg[24] <= 32'b0;
		CP0_reg[25] <= 32'b0;
		CP0_reg[26] <= 32'b0;
		CP0_reg[27] <= 32'b0;
		CP0_reg[28] <= 32'b0;
		CP0_reg[29] <= 32'b0;
		CP0_reg[30] <= 32'b0;
		CP0_reg[31] <= 32'b0;
	end
	else
	begin
		if(mtc0)
		begin
			// 如果指令为Mtc0，将GP寄存器的数据写入对应的CP0寄存器
			CP0_reg[addr] <= data;
		end
		else if(exception) // SYSCALL, BREAK, TEQ
		begin
			// 如果发生异常，更新相关的CP0寄存器
			CP0_reg[12] <= (status << 5);            // 状态寄存器
			CP0_reg[13] <= {24'b0, cause, 2'b0};     // 异常原因寄存器
			CP0_reg[14] <= pc;                       // EPC寄存器
		end
		else if(eret)
		begin
			// 如果指令为ERET，恢复状态寄存器的值
			CP0_reg[12] <= (status >> 5);            // 状态寄存器
		end
	end
end

assign exc_addr = eret ? (CP0_reg[14] + 4) : 32'h00400004;   // 根据ERET指令判断异常时的程序计数器地址
assign rdata = mfc0 ? CP0_reg[addr] : 32'hzzzzzzzz;          // 根据Mfc0指令将CP0寄存器的值传递给GP寄存器
endmodule

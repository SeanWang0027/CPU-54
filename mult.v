`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:47:01
// Design Name: 
// Module Name: mult
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


module MUL(
	input clk,                  // 时钟输入
	input reset,                // 复位输入
	input start,                // 启动输入
	input [31:0] a,             // 输入a
	input [31:0] b,             // 输入b
	output [63:0] z             // 输出z
);
	wire signed [31:0] a_tmp;   // 带符号的临时变量a_tmp
	wire signed [31:0] b_tmp;   // 带符号的临时变量b_tmp
	assign a_tmp = $signed(a);  // 将输入a转换为带符号的临时变量a_tmp
	assign b_tmp = $signed(b);  // 将输入b转换为带符号的临时变量b_tmp
	assign z = a_tmp * b_tmp;   // 将a_tmp和b_tmp相乘，并将结果赋给输出z

endmodule


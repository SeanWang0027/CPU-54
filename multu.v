`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:48:13
// Design Name: 
// Module Name: multu
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


module MULTU(
	input clk,                  // 时钟输入
	input reset,                // 复位输入
	input start,                // 启动输入
	input [31:0] a,             // 输入a
	input [31:0] b,             // 输入b
	output [63:0] z             // 输出z
);

	wire [64:0] tmp;            // 临时变量tmp，用于存储无符号相乘结果
	assign tmp = {1'b0, a} * {1'b0, b};    // 将输入a和b进行无符号相乘，并赋值给临时变量tmp
	assign z = tmp[63:0];       // 将临时变量tmp的高63位赋值给输出z

endmodule


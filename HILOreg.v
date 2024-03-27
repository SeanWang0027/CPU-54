`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/02 13:48:45
// Design Name: 
// Module Name: HILOreg
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


module HILOreg(
	input clk,                  // 时钟输入
	input rst,                  // 复位输入
	input wena,                 // 写使能输入
	input [31:0] data_in,       // 数据输入
	output [31:0] data_out      // 数据输出
);
	reg [31:0] HILO_Reg;         // HILO寄存器

	always @(negedge clk or posedge rst)
	begin
		if(rst)                  // 如果复位信号有效
			HILO_Reg <= 32'h0;   // 将寄存器重置为0
		else if(wena)            // 如果写使能信号有效
			HILO_Reg <= data_in; // 将输入数据写入寄存器
	end
	assign data_out = HILO_Reg;  // 将寄存器的值赋给输出端口

endmodule


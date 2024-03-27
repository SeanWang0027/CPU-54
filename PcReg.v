`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:50:01
// Design Name: 
// Module Name: PcReg
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


module PCReg(
    input PC_clk,                  // PC时钟输入
    input PC_rst,                  // PC复位输入
    input PC_ena,                  // PC使能输入
    input PC_wena,                 // PC写使能输入
    input [31:0] PC_in,            // PC输入
    output [31:0] PC_out           // PC输出
);
    reg [31:0] PC_register;        // PC寄存器

    always @(negedge PC_clk or posedge PC_rst) begin
        if (PC_ena) begin
            if (PC_rst) begin
                PC_register <= 32'h00400000;     // 在复位时将PC寄存器初始化为0x00400000
            end
            else if (PC_wena) begin
                PC_register <= PC_in;            // 如果写使能信号有效，则将PC寄存器的值更新为输入的PC值
            end
        end
    end
    assign PC_out = !PC_ena ? 32'bz : PC_register;   // 当PC使能信号无效时，PC输出为高阻态(32'bz)，否则输出PC寄存器的值

endmodule


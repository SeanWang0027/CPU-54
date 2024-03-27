`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:41:10
// Design Name: 
// Module Name: IMEM
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


module imem(
    input [10:0] addr,         // 地址输入
    output [31:0] instr        // 指令输出
);
    dist_mem_gen_0 instr_mem(  // 使用dist_mem_gen_0模块生成指令存储器
    .a(addr),                  // 将地址连接到dist_mem_gen_0模块的a端口
    .spo(instr)                // 将指令输出连接到dist_mem_gen_0模块的spo端口
    );
endmodule


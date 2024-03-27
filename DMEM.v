`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:42:14
// Design Name: 
// Module Name: DMEM
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


module DMEM(
    input DM_clk,              // DMEM时钟输入
    input CS,                  // 片选信号输入
    input DM_R,                // 读使能信号输入
    input DM_W,                // 写使能信号输入
    input [10:0] Addr,         // 地址输入
    input [31:0] Data_In,      // 数据输入
    input [1:0] Bit_S,         // 字节选择输入
    output [31:0] Data_Out     // 数据输出
);


    reg [7:0] mem [0:2047];    // 内存存储数组
    assign Data_Out = CS ? (DM_R ? ({mem[Addr],mem[Addr+1],mem[Addr+2],mem[Addr+3]}) : 32'b0) : 32'bz;    // 数据输出选择
    always @ (negedge DM_clk or posedge CS)
    begin
        if(CS && DM_W)      // 如果片选信号和写使能信号均有效
        begin
            case(Bit_S)    // 根据字节选择输入进行写操作
            1'd0: 
                mem[Addr] <= Data_In[7:0];    // 写入低字节
            1'd1: 
            begin
                mem[Addr+1] <= Data_In[7:0];  // 写入第二低字节
                mem[Addr] <= Data_In[15:8];   // 写入低字节
            end
            2: 
            begin
                mem[Addr+3] <= Data_In[7:0];   // 写入最高字节
                mem[Addr+2] <= Data_In[15:8];  // 写入第二高字节
                mem[Addr+1] <= Data_In[23:16]; // 写入第三高字节
                mem[Addr] <= Data_In[31:24];   // 写入低字节
            end
            endcase
        end
    end

endmodule


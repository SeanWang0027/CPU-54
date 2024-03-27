`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 19:53:36
// Design Name: 
// Module Name: ALU
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

module ALU(
    input [31:0] A,         // 输入A（32位）
    input [31:0] B,         // 输入B（32位）
    input [4:0] ALUC,       // ALU控制信号（5位）
    output [31:0] Result,   // 结果输出（32位）
    output Zero,            // 零标志位输出
    output Carry,           // 进位标志位输出
    output Negative,        // 负数标志位输出
    output OverFlow);       // 溢出标志位输出

    wire signed [31:0] signed_A, signed_B;
    reg [32:0] R;
    assign signed_A = A;     // 将A转为有符号数
    assign signed_B = B;     // 将B转为有符号数
    
    always @ (*) begin
        case(ALUC)
            5'b00000:    R <= signed_A + signed_B;             // 加法：有符号
            5'b00001:    R <= A + B;                           // 加法：无符号
            5'b00010:    R <= signed_A - signed_B;             // 减法：有符号
            5'b00011:    R <= A - B;                           // 减法：无符号
            5'b00100:    R <= A & B;                           // 逻辑与
            5'b00101:    R <= A | B;                           // 逻辑或
            5'b00110:    R <= A ^ B;                           // 逻辑异或
            5'b00111:    R <= ~(A | B);                        // 逻辑或非

            5'b01000:    R <= (signed_A < signed_B) ? 1 : 0;   // 小于比较：有符号
            5'b01001:    R <= (A < B) ? 1 : 0;                 // 小于比较：无符号

            5'b01010:    R <= B << A;                          // 左移：无符号
            5'b01011:    R <= B >> A;                          // 右移：无符号
            5'b01100:    R <= signed_B >>> signed_A;           // 右移：有符号
            5'b01101:    R <= B << A[4:0];                     // 左移：无符号，移位数由A的低5位决定
            5'b01110:    R <= B >> A[4:0];                     // 右移：无符号，移位数由A的低5位决定
            5'b01111:    R <= signed_B >>> signed_A[4:0];      // 右移：有符号，移位数由A的低5位决定

            5'b10000:    R <= {B[15:0], 16'b0};                // 生成16位结果，低16位为B的低16位，高16位为0
        endcase
    end
    
    assign Result = R[31:0];                     // 将结果的低32位赋给Result
    assign Zero = (R == 32'b0) ? 1 : 0;           // 判断结果是否为零
    assign Carry = R[32];                         // 获取进位标志位
    assign Negative = (ALUC == 5'b01001 || ALUC == 5'b01000) ? R[0] : R[31];   // 获取负数标志位
    assign OverFlow = R[32];                      // 获取溢出标志位
endmodule

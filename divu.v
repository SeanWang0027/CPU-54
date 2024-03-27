`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/07/01 20:32:28
// Design Name: 
// Module Name: divu
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


module DIVU(
  input [31:0] dividend,      // 被除数输入
  input [31:0] divisor,       // 除数输入
  input start,                // 启动信号输入
  input clock,                // 时钟输入
  input reset,                // 复位输入
  output [31:0] q,            // 商输出
  output [31:0] r,            // 余数输出
  output busy                 // 忙碌信号输出
);
  reg R_Sign;
  reg Flag;
  reg FIRST;
  reg BUSY2;

  reg [31:0] Reg_Q; 
  reg [31:0] Reg_R; 
  reg [31:0] Reg_B; 
  reg [31:0] Tmp_Q;
  reg [31:0] Tmp_R;
  reg [7:0] Counter;
  wire [32:0] Sub_Add;

  // 将输出信号与中间信号相连
  assign Sub_Add = (!R_Sign ? ({Reg_R,Reg_Q[31]} - {1'b0,Reg_B}) : ({Reg_R,Reg_Q[31]} + {1'b0,Reg_B}));
  assign r = Tmp_R;
  assign q = Tmp_Q;
  assign busy = BUSY2;

  always @ (posedge clock or posedge reset) begin
    if (!reset) begin
      if (start) begin
        if (FIRST) begin
          Flag <= 0;
          Reg_Q <= dividend;
          Reg_B <= divisor;
          Reg_R <= 0;
          R_Sign <= 0;
          Counter <= 0;
          BUSY2 <= 1;
          FIRST <= 0;
        end
      end
      if (BUSY2) begin
        Reg_R <= Sub_Add[31:0];
        R_Sign <= Sub_Add[32];
        Reg_Q <= {Reg_Q[30:0], ~Sub_Add[32]};
        Counter <= Counter + 1;
        if (Counter == 31) begin
          BUSY2 <= 0;
          Flag <= 1;
        end
      end
    end
    else begin
      Flag <= 0;
      R_Sign <= 0;
      Tmp_Q <= 0;
      Tmp_R <= 0;
      BUSY2 <= 0;
      Reg_Q <= 0; 
      Reg_R <= 0; 
      Reg_B <= 0; 
      Counter <= 0;
      FIRST <= 1;
    end
  end
      
  always @ (Flag) begin
    if (Flag) begin
      Tmp_Q <= Reg_Q;
      Flag <= 0;
      FIRST <= 1;
      Tmp_R <= R_Sign ? (Reg_R + Reg_B) : Reg_R;
    end
  end
endmodule
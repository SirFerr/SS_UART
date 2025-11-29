`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 18:21:39
// Design Name: 
// Module Name: dff
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


module dff(
  input D,
  input CLK,
  input EN,
  input RST,
  output reg Q
);


always@(posedge CLK, posedge RST)
  if(RST) begin
    Q <= 1'b0;
  end
  else if(EN)
    Q <= D;


endmodule

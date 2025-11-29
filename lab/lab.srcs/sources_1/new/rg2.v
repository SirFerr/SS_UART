`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 18:53:04
// Design Name: 
// Module Name: rg2
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


module rg2 #(
  parameter WDT = 8
)(
  input [WDT-1 : 0] D,
  input CLK,
  input EN,
  input RST,
  output reg [WDT-1 : 0] Q
);


always@(posedge CLK, posedge RST)
  if(RST) begin
    Q <= 0;
  end
  else if(EN)
    Q <= D;


endmodule

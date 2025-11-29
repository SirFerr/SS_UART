`timescale 1ns / 1ps

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

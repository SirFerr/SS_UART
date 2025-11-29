`timescale 1ns / 1ps

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

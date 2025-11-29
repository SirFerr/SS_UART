`timescale 1ns / 1ps

module top(
  input [1:0] SW,
  output [8:0] LED
);
    
lab labtop(
  .A(SW[1]),
  .B(SW[0]),
  .Y(LED)
);
endmodule

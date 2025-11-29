`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 18:10:11
// Design Name: 
// Module Name: mux
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


module mux(
  input [2:0] d0,
  input [2:0] d1,
  input [2:0] d2,
  input [2:0] d3,
  input [1:0] a,  
  output reg [2:0] out
);

/*always@(*) begin
  if(a == 2'b00)
    out = d0;
  else if(a == 2'b01)
    out = d1;
  else if(a == 2'b10)
    out = d2;
  else 
    out = d3;
end*/

always@(*) begin
  case(a)
    2'b00: begin
      out = d0;
    end
    2'b01: out = d1;
    2'b10: out = d2;
    default: out = d3;
  endcase
end

endmodule

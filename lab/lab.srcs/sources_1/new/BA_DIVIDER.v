`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.10.2025 19:05:55
// Design Name: 
// Module Name: BA_DIVIDER
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


module BA_DIVIDER #(
  parameter DIV = 100000
)(
  input      CLK,
  input      RST,
  output reg CEO
);

reg [$clog2(DIV)-1:0] CNT;

always@(posedge CLK, posedge RST)
  if(RST) begin
    CNT <= 0;
    CEO <= 1'b0;
  end
  else if(CNT == (DIV-1)) begin
    CNT <= 0;
    CEO <= 1'b1;
  end
  else begin
    CNT <= CNT + 1'b1;
    CEO <= 1'b0;
  end



endmodule

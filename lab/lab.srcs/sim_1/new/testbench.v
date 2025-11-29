`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2025 18:43:04
// Design Name: 
// Module Name: testbench
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


module testbench;

reg Areg;
reg Breg;



lab uut(
  .A(Areg),
  .B(Breg),
  .Y()
);

initial begin
  Areg = 1'b0;
  Breg = 1'b0;
  #10;
  
  Areg = 1'b0;
  Breg = 1'b1;
  #10;
  
  Areg = 1'b1;
  Breg = 1'b0;
  #10;
  
  Areg = 1'b1;
  Breg = 1'b1;
  #10;
  
  $stop;
end

endmodule

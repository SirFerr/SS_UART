`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 19:10:35
// Design Name: 
// Module Name: BA_ROM
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


module BA_ROM(
  input  [6:0] ADDR,
  output [7:0] DATA
);

reg [7:0] ROM [0:127];

initial begin
  $readmemh("ROM1.mem", ROM);
end

assign DATA = ROM[ADDR];

endmodule

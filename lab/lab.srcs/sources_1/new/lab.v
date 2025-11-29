`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.09.2025 18:21:09
// Design Name: 
// Module Name: lab
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


module lab(
    input A,
    input B,
    output [8:0] Y
);

assign Y[0] = B;
assign Y[1] = ~B;
assign Y[2] = A & B;
assign Y[3] = ~(A & B);
assign Y[4] = A | B;
assign Y[5] = ~(A | B);
assign Y[6] = A ^ B;
assign Y[7] = ~(A ^ B);
assign Y[8] = A ? B : 1'b0;

endmodule

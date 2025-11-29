`timescale 1ns / 1ps

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

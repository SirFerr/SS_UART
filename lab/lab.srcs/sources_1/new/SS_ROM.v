`timescale 1ns / 1ps

module SS_ROM(
  input  [6:0] ADDR,
  output [7:0] DATA
);

reg [7:0] ROM [0:127];

initial begin
  $readmemh("ROM1.mem", ROM);
end

assign DATA = ROM[ADDR];

endmodule

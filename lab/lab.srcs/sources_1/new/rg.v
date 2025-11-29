`timescale 1ns / 1ps

module rg(
  input [2:0] D,
  input CLK,
  input CE,
  input RST,
  output [2:0] Q
);

wire net;

dff q2(
  .D(D[2]),
  .CLK(CLK),
  .EN(CE),
  .RST(RST),
  .Q(Q[2])
);

dff q1(
  .D(D[1]),
  .CLK(CLK),
  .EN(CE),
  .RST(RST),
  .Q(Q[1])
);

dff q0(
  .D(D[0]),
  .CLK(CLK),
  .EN(CE),
  .RST(RST),
  .Q(net)
);

dff sh(
  .D(Q[1]^net),
  .CLK(CLK),
  .EN(CE),
  .RST(RST),
  .Q(Q[0])
);

rg2 reg1(
  .D(),
  .CLK(),
  .EN(),
  .RST(),
  .Q()
);

rg2 #(.WDT(32)) reg2(
  .D(),
  .CLK(),
  .EN(),
  .RST(),
  .Q()
);

endmodule

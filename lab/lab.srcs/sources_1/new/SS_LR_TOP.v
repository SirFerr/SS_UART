`timescale 1ns / 1ps

module SS_LR_TOP(
  input  CLK,
  input  SYS_NRST,
  input  BTN_0,
  input  BTN_1,
  input  UART_RXD,
  output UART_TXD
);

reg [1:0] RST_SYNC;
wire RST;
wire CE_1KHZ;
wire GEN_FRT_ERR;
wire GEN_PAR_ERR;
//--------------------------------
//RST Sync
always@(posedge CLK, negedge SYS_NRST)
  if(~SYS_NRST)
    RST_SYNC <= 2'b11;
  else
    RST_SYNC <= {RST_SYNC[0],1'b0};

assign RST = RST_SYNC[1];
//--------------------------------
//Divider 1kHz
SS_DIVIDER div_1kHz(
  .CLK(CLK),
  .RST(RST),
  .CEO(CE_1KHZ)
);
//--------------------------------
//Filter-0
M_BTN_FILTER_V10 filt_btn0(
    .CLK(CLK),                     // System Clock
    .CE(CE_1KHZ),                      // CE (1-2kHz - optimal)
    .BTN_IN(BTN_0),                  // Asynch. Input From Button
    .RST(RST),                     // Asynch. Reset
    .BTN_OUT(GEN_FRT_ERR),                 // Filtered Output
    .BTN_CEO()                  // Clock Enable Pulse When L-H Transition
);
//--------------------------------
//Filter-0
M_BTN_FILTER_V10 filt_btn1(
    .CLK(CLK),                     // System Clock
    .CE(CE_1KHZ),                      // CE (1-2kHz - optimal)
    .BTN_IN(BTN_1),                  // Asynch. Input From Button
    .RST(RST),                     // Asynch. Reset
    .BTN_OUT(GEN_PAR_ERR),                 // Filtered Output
    .BTN_CEO()                  // Clock Enable Pulse When L-H Transition
);
//--------------------------------

endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.11.2025 18:09:43
// Design Name: 
// Module Name: BA_UART
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


module BA_UART(
  input            CLK,
  input            RST,
  input            RXD,
  output reg       TXD,
  output reg       RX_DATA_EN,
  output reg [9:0] RX_DATA_T,
  input            TX_RDY_T,
  input      [7:0] TX_DATA_R,
  output           TX_RDY_R
);

reg [1:0] SYNC;
reg [2:0] RX_STATE;
reg [2:0] TX_STATE;
reg [2:0] RX_DATA_CT;
reg       RXCT_R;
reg       TXCT_R;
reg [3:0] RX_SAMP_CT;
reg [3:0] TX_SAMP_CT;

wire      RXD_RG;
wire      UART_CE;
wire      RX_CE;
wire      TX_CE;
//--------------------------------
localparam IDLE  = 3'd0,
           RSTRB = 3'd1,
           RDT   = 3'd2,
           RPARB = 3'd3,
           RSTB1 = 3'd4,
           RSTB2 = 3'd5,
           WEND  = 3'd6,
           WCE   = 3'd1,
           TSTRB = 3'd2;
//--------------------------------
//RXD sync
always@(posedge CLK, posedge RST)
  if(RST)
    SYNC <= 2'b11;
  else
    SYNC <= {SYNC[0],RXD};

assign RXD_RG = SYNC[1];
//--------------------------------
//Divider UART_CE
BA_DIVIDER #(6944) div_uart_ce(
  .CLK(CLK),
  .RST(RST),
  .CEO(UART_CE)
);
//--------------------------------
//RX-FSM
always@(posedge CLK, posedge RST)
  if(RST) begin
    RX_STATE   <= IDLE;
    RX_DATA_EN <= 1'b0;
    RX_DATA_T  <= 0;
    RX_DATA_CT <= 0;
    RXCT_R     <= 1'b1;
  end
  else
    case(RX_STATE)
       IDLE: begin
         if(~RXD_RG) begin
           RX_STATE     <= RSTRB;
           RX_DATA_EN   <= 1'b0;
           RX_DATA_T[9] <= 1'b0;
           RXCT_R       <= 1'b0;
         end
         else
           RX_DATA_EN <= 1'b0;
       end
       
       RSTRB: begin
         if(RX_CE) begin
           if(RXD_RG) begin
             RX_STATE <= IDLE;
             RXCT_R   <= 1'b1;
           end
           else
             RX_STATE <= RDT;
         end
       end
       
       RDT: begin
         if(RX_CE) begin
           RX_DATA_T[7:0] <= {RXD_RG,RX_DATA_T[7:1]};
           RX_DATA_CT     <= RX_DATA_CT + 1'b1;
           if(RX_DATA_CT == 7)
             RX_STATE <= RPARB;
         end
       end
       
       RPARB: begin
         if(RX_CE) begin
           RX_STATE     <= RSTB1;
           RX_DATA_T[8] <= RXD_RG ^ (~^RX_DATA_T[7:0]);
         end
       end
    endcase
//--------------------------------
//TX-FSM
always@(posedge CLK, posedge RST)
  if(RST) begin 
    TX_STATE <= IDLE;
    TXD      <= 1'b1;
    TXCT_R   <= 1'b1;
  end
//--------------------------------
//RX-SAMP-CT
always@(posedge CLK, posedge RST) 
  if(RST)
    RX_SAMP_CT <= 0;
  else if(RXCT_R)
    RX_SAMP_CT <= 0;
  else if(UART_CE)
    RX_SAMP_CT <= RX_SAMP_CT + 1'b1;

assign RX_CE = UART_CE & (RX_SAMP_CT == 7);
//--------------------------------
//TX-SAMP-CT
always@(posedge CLK, posedge RST) 
  if(RST)
    TX_SAMP_CT <= 0;
  else if(TXCT_R)
    TX_SAMP_CT <= 0;
  else if(UART_CE)
    TX_SAMP_CT <= TX_SAMP_CT + 1'b1;

assign TX_CE = UART_CE & (TX_SAMP_CT == 15);  
//--------------------------------  
endmodule

`timescale 1ns / 1ps

module SS_UART(
  input            CLK,
  input            RST,
  input            RXD,
  output reg       TXD,

  output reg       RX_DATA_EN,
  output reg [53:0] RX_DATA_T, // 1 start + 52 data + 1 parity + 1 stop

  input            TX_RDY_T,
  input      [7:0] TX_DATA_R,
  output           TX_RDY_R
);

reg [2:0] SYNC;           // 3 триггера в синхронизаторе
reg [2:0] RX_STATE;
reg [5:0] RX_DATA_CT;

reg       RXCT_R;
reg [3:0] RX_SAMP_CT;

wire      RXD_RG;
wire      UART_CE;
wire      RX_CE;

// UART states
localparam IDLE  = 3'd0,
           START = 3'd1,
           DATA  = 3'd2,
           PAR   = 3'd3,
           STOP  = 3'd4,
           DONE  = 3'd5;

// RXD sync (3 триггера)
always @(posedge CLK or posedge RST)
  if (RST)
    SYNC <= 3'b111;
  else
    SYNC <= {SYNC[1:0], RXD};

assign RXD_RG = SYNC[2];

// ---- UART divider: 1800 baud, RATIO = 8 ----
// 100 MHz / (1800 * 8) ? 6944
SS_DIVIDER #(6944) div_uart_ce (
  .CLK(CLK),
  .RST(RST),
  .CEO(UART_CE)
);

// RX sample counter (RATIO = 8, выборка на 7)
always @(posedge CLK or posedge RST)
  if (RST)
    RX_SAMP_CT <= 0;
  else if (RXCT_R)
    RX_SAMP_CT <= 0;
  else if (UART_CE)
    RX_SAMP_CT <= RX_SAMP_CT + 1'b1;

assign RX_CE = UART_CE & (RX_SAMP_CT == 7);

// ---- RX FSM ----
always @(posedge CLK or posedge RST)
  if (RST) begin
    RX_STATE   <= IDLE;
    RX_DATA_CT <= 0;
    RX_DATA_T  <= 0;
    RX_DATA_EN <= 0;
    RXCT_R     <= 1'b1;
  end else begin
    case (RX_STATE)
      IDLE: begin
        RX_DATA_EN <= 0;
        if (~RXD_RG) begin
          RX_STATE   <= START;
          RXCT_R     <= 1'b0;
        end
      end

      START: if (RX_CE) begin
        if (RXD_RG)
          RX_STATE <= IDLE;      // ложный старт
        else begin
          RX_STATE   <= DATA;
          RX_DATA_CT <= 0;
        end
      end

      DATA: if (RX_CE) begin
        RX_DATA_T[RX_DATA_CT] <= RXD_RG;
        RX_DATA_CT <= RX_DATA_CT + 1'b1;
        if (RX_DATA_CT == 6'd51)
          RX_STATE <= PAR;
      end

      PAR: if (RX_CE) begin
        RX_DATA_T[52] <= RXD_RG; // parity bit -> должен быть 0 (SPACE)
        RX_STATE <= STOP;
      end

      STOP: if (RX_CE) begin
        RX_DATA_T[53] <= RXD_RG; // стоп-бит
        RX_STATE <= DONE;
      end

      DONE: begin
        RX_DATA_EN <= 1'b1;     // один такт сигнал готовности
        RX_STATE   <= IDLE;
        RXCT_R     <= 1'b1;
      end

    endcase
  end

endmodule

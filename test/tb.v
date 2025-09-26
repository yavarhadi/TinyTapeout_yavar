`timescale 1ns/1ps
`default_nettype none
`include "tt_um_counter.v"
module tb_counter;
  localparam integer BW =3;

  reg                   clk;
  reg                   rst;
  wire [BW-1:0]         q;

  // DUT
  counter #(BW) dut (
    .clk_i(clk),
    .rst_i(rst),
    .counter_val_o(q)
  );

  // 100 MHz clock: period = 10 ns
  initial clk = 1'b0;
  always  #5 clk = ~clk;

  integer i;
  initial begin
    // waves
    $dumpfile("tb_counter.vcd");
    $dumpvars(0, tb_counter);

    // reset 3 cycles
    rst = 1'b1;
    repeat (3) @(posedge clk);
    rst = 1'b0;

    // run 40 cycles
    for (i = 0; i < 40; i = i + 1) begin
      @(posedge clk);
      $display("[%0t] q = 0x%0h", $time, q);
    end
    $finish;
  end
endmodule

`default_nettype wire


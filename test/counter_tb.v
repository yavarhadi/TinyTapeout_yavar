`timescale 1ns/ps
`default_nettype none
<<<<<<< HEAD
`include "src/tt_um_counter.v"
=======
>>>>>>> d25bfd5 (tb.v update)
module counter_tb;
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





   // Replace tt_um_example with your module name:
  tt_um_counter user_project(

      // Include power ports for the Gate Level test:
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif

      .ui_in  (ui_in),    // Dedicated inputs
      .uo_out (uo_out),   // Dedicated outputs
      .uio_in (uio_in),   // IOs: Input path
      .uio_out(uio_out),  // IOs: Output path
      .uio_oe (uio_oe),   // IOs: Enable path (active high: 0=input, 1=output)
      .ena    (ena),      // enable - goes high when design is selected
      .clk    (clk),      // clock
      .rst_n  (rst_n)     // not reset
  );
endmodule

`default_nettype wire


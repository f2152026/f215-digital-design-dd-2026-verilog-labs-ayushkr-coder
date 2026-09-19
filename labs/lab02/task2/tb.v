// tb.v
// Testbench for parameterized lookup table (lut)

module tb;

  parameter WIDTH = 8;
  parameter DEPTH = 8;

  // sel needs $clog2(DEPTH) bits; with DEPTH=8, that is [2:0]
  reg  [$clog2(DEPTH)-1:0] t_sel;
  wire [WIDTH-1:0]         t_dout;

  // Instantiate DUT with parameter override
  lut #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
  ) DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  integer idx;

  initial begin
    // Loop through every valid address in the table
    for (idx = 0; idx < DEPTH; idx = idx + 1) begin
      t_sel = idx;
      #5;
    end
    $finish;
  end

  initial
    $monitor($time, " | sel=%0d | dout=%0d (expected %0d)", t_sel, t_dout, t_sel * t_sel);

endmodule
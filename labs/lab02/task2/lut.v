module lut #(
  parameter WIDTH = 8,
  parameter DEPTH = 4
)(
  input  [$clog2(DEPTH)-1:0] sel,
  output reg [WIDTH-1:0]     dout
);

  reg [WIDTH-1:0] mem [0:DEPTH-1];

  integer i;

  // Initial block to populate the ROM at time 0
  initial begin
    for (i = 0; i < DEPTH; i = i + 1) begin
      mem[i] = i * i;
    end
  end

  // Combinational read responding to sel
  always @(*) begin
    dout = mem[sel];
  end

endmodule
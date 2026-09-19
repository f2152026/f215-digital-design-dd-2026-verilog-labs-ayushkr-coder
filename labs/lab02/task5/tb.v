module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer    errors;
  integer    i, j, op_idx;

  alu DUT (
    .a(t_a),
    .b(t_b),
    .op(t_op),
    .result(t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;

    for (op_idx = 0; op_idx < 2; op_idx = op_idx + 1) begin
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          t_op = op_idx;
          t_a  = i;
          t_b  = j;
          #5;

          if (t_op == 1'b0)
            exp_result = (t_a + t_b) & 4'hF;
          else
            exp_result = (t_a - t_b) & 4'hF;

          if (t_result !== exp_result) begin
            $display("FAIL at time %0t: op=%b a=%d b=%d got=%d expected=%d",
                     $time, t_op, t_a, t_b, t_result, exp_result);
            errors = errors + 1;
          end
        end
      end
    end

    if (errors == 0) begin
      $display("ALL ALU TESTS PASSED");
    end else begin
      $display("%0d TESTS FAILED", errors);
    end

    $finish;
  end

endmodule
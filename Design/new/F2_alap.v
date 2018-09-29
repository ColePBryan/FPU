module F2_alap # (
        parameter WIDTH = 32
    ) (
        input  wire [1:0]       f,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        input  wire [WIDTH-1:0] in2,
        output wire [WIDTH-1:0] out
    );

    wire  [$clog2(WIDTH)-1:0] shift_amt;
    wire  [WIDTH-1:0] shift_in;

    mux2 # (
            .WIDTH      (WIDTH)
        ) SHIFT_IN_MUX (
            .sel        (f[1]),
            .in0        (in0),
            .in1        (in2),
            .out        (shift_in)
        );

    mux2 # (
            .WIDTH      ($clog2(WIDTH))
        ) SHIFT_AMT_MUX (
            .sel        (f[0]),
            .in0        ({{($clog2(WIDTH)-2){1'b0}}, 2'b11}),
            .in1        ({{($clog2(WIDTH)-1){1'b0}}, 1'b1}),
            .out        (shift_amt)
        );

    shifter # (
            .WIDTH      (WIDTH)
        ) SHIFTER (
            .dir        (1'b0),
            .shift_amt  (shift_amt),
            .in         (shift_in),
            .out        (out)
        );

endmodule

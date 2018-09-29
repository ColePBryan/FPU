module F2_asap # (
        parameter WIDTH = 32
    ) (
        input  wire [1:0]       f,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        input  wire [WIDTH-1:0] in2,
        output wire [WIDTH-1:0] out
    );

    wire [WIDTH-1:0] abs_out;
    wire [WIDTH-1:0] min_max_out;
    wire [WIDTH-1:0] shift_out;

    abs # (
            .WIDTH      (WIDTH)
        ) ABS (
            .in         (in1),
            .out        (abs_out)
        );

    min_max # (
            .WIDTH      (WIDTH)
        ) MIN_MAX (
            .c          (1'b0),
            .in0        (in0),
            .in1        (in1),
            .out        (min_max_out)
        );

    shifter # (
            .WIDTH      (WIDTH)
        ) SHIFTER (
            .dir        (1'b0),
            .shift_amt  ({{($clog2(WIDTH)-2){1'b0}}, 2'b11}),
            .in         (in0),
            .out        (shift_out)
        );
    
    mux4 # (
            .WIDTH      (WIDTH)
        ) OUT_MUX (
            .sel        (f[1:0]),
            .in0        (abs_out),
            .in1        (min_max_out),
            .in2        (shift_out),
            .in3        ({WIDTH{1'b0}}),
            .out        (out)
        );

endmodule

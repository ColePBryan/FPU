module F1_asap # (
        parameter WIDTH = 32
    ) (
        input  wire [3:0]       f,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        input  wire [WIDTH-1:0] in2,
        output wire [WIDTH-1:0] out
    );

    wire [WIDTH-1:0] abs_out;
    wire [WIDTH-1:0] min_max_out;
    wire [WIDTH-1:0] add_sub_in0;
    wire [WIDTH-1:0] add_sub_out;
    wire [WIDTH-1:0] shift_out;

    abs # (
            .WIDTH      (WIDTH)
        ) ABS (
            .in         (in0),
            .out        (abs_out)
        );

    min_max # (
            .WIDTH      (WIDTH)
        ) MIN_MAX (
            .c          (1'b1),
            .in0        (in0),
            .in1        (in1),
            .out        (min_max_out)
        );

    mux2 # (
            .WIDTH      (WIDTH)
        ) ADD_SUB_MUX (
            .sel        (f[3]),
            .in0        (in0),
            .in1        (in2),
            .out        (add_sub_in0)
        );

    adder_subtractor # (
            .WIDTH      (WIDTH)
        ) ADD_SUB (
            .c          (f[2]),
            .in0        (add_sub_in0),
            .in1        (in1),
            .out        (add_sub_out)
        );

    shifter # (
            .WIDTH      (WIDTH)
        ) SHIFTER (
            .dir        (1'b0),
            .shift_amt  ({{($clog2(WIDTH)-1){1'b0}}, 1'b1}),
            .in         (in1),
            .out        (shift_out)
        );

    mux4 # (
            .WIDTH      (WIDTH)
        ) OUT_MUX (
            .sel        (f[1:0]),
            .in0        (abs_out),
            .in1        (min_max_out),
            .in2        (shift_out),
            .in3        (add_sub_out),
            .out        (out)
        );

endmodule

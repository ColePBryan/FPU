module F1_alap # (
        parameter WIDTH = 32
    ) (
        input  wire [3:0]       f,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        input  wire [WIDTH-1:0] in2,
        output wire [WIDTH-1:0] out
    );

    wire [WIDTH-1:0] abs_in;
    wire [WIDTH-1:0] abs_out;
    wire [WIDTH-1:0] min_max_in;
    wire [WIDTH-1:0] min_max_out;
    wire [WIDTH-1:0] add_sub_in0;
    wire [WIDTH-1:0] add_sub_out;

    mux2 # (
            .WIDTH      (WIDTH)
        ) ABS_MUX (
            .sel        (f[3]),
            .in0        (in0),
            .in1        (in1),
            .out        (abs_in)
        );

    abs # (
            .WIDTH      (WIDTH)
        ) ABS (
            .in         (abs_in),
            .out        (abs_out)
        );

    mux2 # (
            .WIDTH      (WIDTH)
        ) MIN_MUX_MUX (
            .sel        (f[3]),
            .in0        (in1),
            .in1        (in2),
            .out        (min_max_in)
        );

    min_max # (
            .WIDTH      (WIDTH)
        ) MIN_MAX (
            .c          (f[2]),
            .in0        (in0),
            .in1        (min_max_in),
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

    mux4 # (
            .WIDTH      (WIDTH)
        ) OUT_MUX (
            .sel        (f[1:0]),
            .in0        (abs_out),
            .in1        (min_max_out),
            .in2        (add_sub_out),
            .in3        ({WIDTH{1'b0}}),
            .out        (out)
        );

endmodule

module asap_dp # (
        parameter WIDTH = 32
    ) (
        input  wire             clk,
        input  wire             rst,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        input  wire             in0_oe,
        input  wire             in1_oe,
        input  wire             f1_oe,
        input  wire             f2_oe,
        input  wire             out_oe,
        input  wire             r2_sel,
        input  wire             r1_en,
        input  wire             r2_en,
        input  wire             r3_en,
        input  wire [3:0]       f1_f,
        input  wire [1:0]       f2_f,
        output wire [WIDTH-1:0] out
    );

    wire [WIDTH-1:0] bus1;
    wire [WIDTH-1:0] bus2;
    
    wire [WIDTH-1:0] r1;
    wire [WIDTH-1:0] r2;
    wire [WIDTH-1:0] r3;

    wire [WIDTH-1:0] f1_out;
    wire [WIDTH-1:0] f2_out;

    wire [WIDTH-1:0] r2_in;
    
    tribuffer # (
        .WIDTH          (WIDTH)
    ) IN0_BUFFER (
        .oe             (in0_oe),
        .in             (in0),
        .out            (bus1)
    );

    tribuffer # (
        .WIDTH          (WIDTH)
    ) IN1_BUFFER (
        .oe             (in1_oe),
        .in             (in1),
        .out            (bus2)
    );

    mux2 # (
        .WIDTH      (WIDTH)
    ) R2_MUX (
        .sel        (r2_sel),
        .in0        (bus2),
        .in1        (bus1),
        .out        (r2_in)
    );

    dreg # (
        .WIDTH          (WIDTH)
    ) R1 (
        .clk            (clk),
        .rst            (rst),
        .en             (r1_en),
        .d              (bus1),
        .q              (r1)
    );

    dreg # (
        .WIDTH          (WIDTH)
    ) R2 (
        .clk            (clk),
        .rst            (rst),
        .en             (r2_en),
        .d              (r2_in),
        .q              (r2)
    );

    dreg # (
        .WIDTH          (WIDTH)
    ) R3 (
        .clk            (clk),
        .rst            (rst),
        .en             (r3_en),
        .d              (bus1),
        .q              (r3)
    );

    F1_asap # (
        .WIDTH          (WIDTH)
    ) F1 (
        .f              (f1_f),
        .in0            (r1),
        .in1            (r2),
        .in2            (r3),
        .out            (f1_out)
    );

    tribuffer # (
        .WIDTH          (WIDTH)
    ) F1_BUFFER (
        .oe             (f1_oe),
        .in             (f1_out),
        .out            (bus1)
    );

    F2_asap # (
        .WIDTH          (WIDTH)
    ) F2 (
        .f              (f2_f),
        .in0            (r1),
        .in1            (r2),
        .in2            (r3),
        .out            (f2_out)
    );

    tribuffer # (
        .WIDTH          (WIDTH)
    ) F2_BUFFER (
        .oe             (f2_oe),
        .in             (f2_out),
        .out            (bus2)
    );
    
    tribuffer # (
        .WIDTH          (WIDTH)
    ) OUT_BUFFER (
        .oe             (out_oe),
        .in             (r1),
        .out            (out)
    );

endmodule
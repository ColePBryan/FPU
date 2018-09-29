module asap #(
        parameter WIDTH = 32
    ) (
        input  wire             clk,
        input  wire             rst,
        input  wire             go,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        output wire [WIDTH-1:0] out,
        output wire [2:0]       CS,
        output wire             done
    );

    wire in0_oe;
    wire in1_oe;
    
    wire f1_oe;
    wire f2_oe;
    
    wire r2_sel;
    
    wire r1_en;
    wire r2_en;
    wire r3_en;

    wire [3:0] f1_f;
    wire [1:0] f2_f;

    asap_dp # (
            .WIDTH          (WIDTH)
        ) DP (
            .clk            (clk),
            .rst            (rst),
            .in0            (in0),
            .in1            (in1),
            .in0_oe         (in0_oe),
            .in1_oe         (in1_oe),
            .f1_oe          (f1_oe),
            .f2_oe          (f2_oe),
            .out_oe         (done),
            .r2_sel         (r2_sel),
            .r1_en          (r1_en),
            .r2_en          (r2_en),
            .r3_en          (r3_en),
            .f1_f           (f1_f),
            .f2_f           (f2_f),
            .out            (out)
        );

    asap_cu # (
            .WIDTH          (WIDTH)
        ) CU (
            .clk            (clk),
            .rst            (rst),
            .go             (go),
            .in0_oe         (in0_oe),
            .in1_oe         (in1_oe),
            .f1_oe          (f1_oe),
            .f2_oe          (f2_oe),
            .r2_sel         (r2_sel),
            .r1_en          (r1_en),
            .r2_en          (r2_en),
            .r3_en          (r3_en),
            .f1_f           (f1_f),
            .f2_f           (f2_f),
            .CS             (CS),
            .done           (done)
        );

endmodule
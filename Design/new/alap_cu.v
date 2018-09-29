module alap_cu # (
        parameter WIDTH = 32
    ) (
        input  wire             clk,
        input  wire             rst,
        input  wire             go,
        output wire             in0_oe,
        output wire             in1_oe,
        output wire             f1_oe,
        output wire             f2_oe,
        output wire             r2_sel,
        output wire             r1_en,
        output wire             r2_en,
        output wire             r3_en,
        output wire [3:0]       f1_f,
        output wire [1:0]       f2_f,
        output reg  [3:0]       CS,
        output wire             done
    );

    parameter S0 = 4'd0,
              S1 = 4'd1,
              S2 = 4'd2,
              S3 = 4'd3,
              S4 = 4'd4,
              S5 = 4'd5,
              S6 = 4'd6,
              S7 = 4'd7,
              S8 = 4'd8;

    parameter S0_control = 15'b1_1_0_0_0_1_1_0_0000_00_0,
              S1_control = 15'b0_0_1_0_0_1_0_0_0000_00_0,
              S2_control = 15'b0_0_1_0_1_0_1_0_1000_00_0,
              S3_control = 15'b0_0_1_0_0_0_0_1_0101_00_0,
              S4_control = 15'b0_0_1_1_0_1_1_0_0001_10_0,
              S5_control = 15'b0_0_1_1_0_1_1_0_1110_01_0,
              S6_control = 15'b0_0_1_0_0_1_0_0_0010_00_0,
              S7_control = 15'b0_0_1_0_0_1_0_0_1101_00_0,
              S8_control = 15'b0_0_1_0_0_0_0_0_0000_00_1;

    reg [3:0] NS;

    reg [14:0] control;

    always @ (posedge clk or posedge rst) begin
        if (rst) CS <= S0;
        else     CS <= NS;
    end

    always @ (*) begin
        case(CS)
            S0: NS = (go) ? S1 : S0;
            S1: NS = S2;
            S2: NS = S3;
            S3: NS = S4;
            S4: NS = S5;
            S5: NS = S6;
            S6: NS = S7;
            S7: NS = S8;
            S8: NS = S0;
            default: NS = S0;
        endcase
    end

    always @ (*) begin
        case(CS)
            S0: control = S0_control;
            S1: control = S1_control;
            S2: control = S2_control;
            S3: control = S3_control;
            S4: control = S4_control;
            S5: control = S5_control;
            S6: control = S6_control;
            S7: control = S7_control;
            S8: control = S8_control;
            default: control = S0_control;
        endcase
    end

    assign {in0_oe, in1_oe, f1_oe, f2_oe, r2_sel, r1_en, r2_en, r3_en, f1_f, f2_f, done} = control;

endmodule
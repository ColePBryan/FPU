module adder_subtractor #(
        parameter WIDTH = 32
    )(
        input  wire c,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        output wire [WIDTH-1:0] out
    );
    assign out = (c) ? ($signed(in0) - $signed(in1)) : ($signed(in0) + $signed(in1));

endmodule
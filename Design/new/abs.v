module abs # (
        parameter WIDTH = 32
    ) (
        input  wire [WIDTH-1:0] in,
        output wire [WIDTH-1:0] out
    );

    wire [WIDTH-1:0] difference;

    assign difference = $signed({WIDTH{1'b0}} - $signed(in));
    assign out = (in[WIDTH-1]) ? difference : in;

endmodule
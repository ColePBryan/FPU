module min_max #(
        parameter WIDTH = 32
    )(
        input  wire             c,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        output wire [WIDTH-1:0] out
    );
    
    wire [WIDTH-1:0] diff;
    
    assign diff = $signed(in0) - $signed(in1);
    assign out = (c ^ diff[WIDTH-1]) ? in0 : in1;

endmodule
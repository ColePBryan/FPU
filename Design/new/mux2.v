module mux2 # (
        parameter WIDTH = 32
    ) (
        input  wire             sel,
        input  wire [WIDTH-1:0] in0,
        input  wire [WIDTH-1:0] in1,
        output wire [WIDTH-1:0] out
    );

    assign out = (sel) ? in1 : in0;

endmodule
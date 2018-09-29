module tribuffer # (
        parameter WIDTH = 32
    ) (
        input  wire             oe,
        input  wire [WIDTH-1:0] in,
        output wire [WIDTH-1:0] out
    );

    assign out = (oe) ? in : {WIDTH{1'bZ}};

endmodule
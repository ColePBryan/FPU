module shifter # (
        parameter WIDTH = 32
    ) (
        input  wire             dir,
        input  wire [$clog2(WIDTH)-1:0]       shift_amt,
        input  wire [WIDTH-1:0] in,
        output wire [WIDTH-1:0] out
    );

    assign out = (dir) ? (in << shift_amt) : (in >> shift_amt);

endmodule
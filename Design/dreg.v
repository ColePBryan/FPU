module dreg # (
        parameter WIDTH = 32
    ) (
        input  wire             clk,
        input  wire             rst,
        input  wire             en,
        input  wire [WIDTH-1:0] d,
        output reg  [WIDTH-1:0] q
    );

    always @ (posedge clk or posedge rst) begin
        if (rst)     q <= {WIDTH{1'b0}};
        else if (en) q <= d;
        else         q <= q;
    end

endmodule
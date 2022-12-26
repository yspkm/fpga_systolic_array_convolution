module pe(clk, rst, u, d, l, r, out);
    input wire clk, rst;
    input wire[0:7] u, l;
    output reg[0:7] d, r;
    output reg [0:7] out;
    reg[0:7] weight, data;

    parameter[0:7] zero = 8'd0;

    always @(posedge rst) begin
        {weight, data, out} <= {zero, zero, zero};
    end

    always @(posedge clk) begin
        {d, r} <= {weight,data};
    end

    always @(u or l) begin
        {weight, data, out} = {u, l, out+u*l};
    end

endmodule

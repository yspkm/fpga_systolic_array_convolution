module pe(clk, rst, u, d, l, r, out);
    input wire clk, rst;
    input wire[0:7] u, l;
    output reg[0:7] d, r;
    output reg [0:7] out;
    reg[0:7] weight, data, tmp;

    parameter[0:7] zero = 8'd0;

    always @(posedge rst) begin
        {weight, data, out, tmp} <= {zero, zero, zero, zero};
    end

    always @(u, l) begin
        weight <= u;
        data <= l;
        tmp <= tmp + u * l;
    end

    always @(posedge clk)
    begin
        {r, d, out} <=  {data, weight, tmp};
    end

endmodule

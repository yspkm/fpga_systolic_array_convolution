module multu8(a, b, out);
    input [7:0] a, b;

    output [7:0] out;

    wire [15:0] outu16;

    vedic_multu8 mult(.a(a), .b(b), .out(outu16));

    assign out = outu16[7:0];
endmodule

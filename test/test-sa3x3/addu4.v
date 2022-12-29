module addu4(a, b, out);
    input wire [3:0] a, b;
    output wire [3:0] out;

    wire [4:1] carry;

    fadder fa0(carry[1],out[0],a[0],b[0], 1'b0);
    fadder fa1(carry[2],out[1],a[1],b[1],carry[1]);
    fadder fa2(carry[3],out[2],a[2],b[2],carry[2]);
    fadder fa3(carry[4],out[3],a[3],b[3],carry[3]);

endmodule
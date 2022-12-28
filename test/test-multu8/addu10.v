module addu10(a, b, out);
    input wire [9:0] a, b;
    output wire [9:0] out;

    wire [10:1] carry;

    fadder fa0(carry[1],out[0],a[0],b[0], 1'b0);
    fadder fa1(carry[2],out[1],a[1],b[1],carry[1]);
    fadder fa2(carry[3],out[2],a[2],b[2],carry[2]);
    fadder fa3(carry[4],out[3],a[3],b[3],carry[3]);
    fadder fa4(carry[5],out[4],a[4],b[4],carry[4]);
    fadder fa5(carry[6],out[5],a[5],b[5],carry[5]);
    fadder fa6(carry[7],out[6],a[6],b[6],carry[6]);
    fadder fa7(carry[8],out[7],a[7],b[7],carry[7]);
    fadder fa8(carry[9],out[8],a[8],b[8],carry[8]);
    fadder fa9(carry[10],out[9],a[9],b[9],carry[9]);

endmodule

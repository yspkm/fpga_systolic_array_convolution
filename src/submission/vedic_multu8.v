module vedic_multu8(a, b, out);

    input  [7:0] a,b;
    output wire [15:0] out;

    wire [7:0] multu4_00_ans, multu4_10_ans, multu4_01_ans;
    wire [9:0] tmp1, tmp2;
    wire [7:0] multu4_11_ans, tmp3;

    assign out[3:0] = multu4_00_ans[3:0];
    assign out[7:4] = tmp2[3:0];
    assign out[15:8] = tmp3;

    vedic_multu4 multu4_00(a[3:0], b[3:0], multu4_00_ans);
    vedic_multu4 multu4_10(a[7:4], b[3:0], multu4_10_ans);
    vedic_multu4 multu4_01(a[3:0], b[7:4], multu4_01_ans);
    vedic_multu4 multu4_11(a[7:4], b[7:4], multu4_11_ans);

    addu10 add1({2'b00, multu4_10_ans}, {2'b00,multu4_01_ans}, tmp1);
    addu10 add2(tmp1, {6'b000000, multu4_00_ans[7:4]}, tmp2);
    addu8 add3(multu4_11_ans, {2'b00,tmp2[9:4]}, tmp3);

endmodule

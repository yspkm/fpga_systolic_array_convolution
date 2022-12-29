module vedic_multu4(a, b, out);

    input  [3:0] a,b;
    output wire [7:0] out;

    wire [3:0] multu2_00_ans, multu2_10_ans, multu2_01_ans;

    wire [5:0] tmp1, tmp2, tmp3;
    wire [3:0] tmp4, multu2_11_ans;

    assign out[1:0] = multu2_00_ans[1:0];
    assign out[3:2] = tmp2[1:0];
    assign out[7:4] = tmp4;
    assign tmp3 = {4'b0000, multu2_00_ans[3:2]};

    addu6 add1({2'b00, multu2_01_ans}, {2'b00, multu2_10_ans}, tmp1);
    addu6 add2(tmp1, tmp3, tmp2);
    addu4 add3(multu2_11_ans, tmp2[5:2], tmp4);

    vedic_multu2 multu2_00(a[1:0], b[1:0], multu2_00_ans);
    vedic_multu2 multu2_10(a[3:2], b[1:0], multu2_10_ans);
    vedic_multu2 multu2_01(a[1:0], b[3:2], multu2_01_ans);
    vedic_multu2 multu2_11(a[3:2], b[3:2], multu2_11_ans);

endmodule

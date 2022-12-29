module vedic_multu2 (a, b, ans);
    input [1:0] a,b;
    output [3:0] ans;

    wire and_1_out, and_2_out, and_3_out, ha_0_c;

    and and0(ans[0], a[0], b[0]);
    and and1(and_1_out, a[1], b[0]);
    and and2(and_2_out, a[0], b[1]);
    and and3(and_3_out, a[1], b[1]);

    hadder ha0(.a(and_1_out), .b(and_2_out), .s(ans[1]), .c(ha_0_c));
    hadder ha1(.a(and_3_out), .b(ha_0_c), .s(ans[2]), .c(ans[3]));

endmodule

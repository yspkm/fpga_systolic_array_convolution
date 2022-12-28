module top(
        clk, rst, state, next_state
    );

    input clk, rst;

    output[6:0] state, next_state;

    wire[7:0] a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33;
    wire[7:0] b00, b01, b02,
        b10, b11, b12,
        b20, b21, b22;

    wire[7:0] pe_out, sa2x2_out, sa3x3_out;

    wire[7:0] pe_dout, pe_wout;

    wire[7:0] display_output;

    wire[7:0] pe_din, pe_win;
    wire[7:0] sa2x2_din0, sa2x2_din1,sa2x2_win0, sa2x2_win1;
    wire[7:0] sa3x3_din0, sa3x3_din1, sa3x3_din2, sa3x3_win0, sa3x3_win1, sa3x3_win2;

    wire pe_clear, sa2x2_clear, sa3x3_clear;
    wire pe_c00, pe_c01, pe_c10, pe_c11;
    wire sa2x2_c00, sa2x2_c01, sa2x2_c10, sa2x2_c11;
    wire sa3x3_c00, sa3x3_c01, sa3x3_c10, sa3x3_c11;

    wire done;

    tpu controller(.clk(clk), .en(1'b1), .rst(rst), .a00(a00), .a01(a01), .a02(a02), .a03(a03),
                   .a10(a10), .a11(a11), .a12(a12), .a13(a13), .a20(a20),
                   .a21(a21), .a22(a22), .a23(a23), .a30(a30), .a31(a31),
                   .a32(a32), .a33(a33), .b00(b00), .b01(b01), .b02(b02),
                   .b10(b10), .b11(b11), .b12(b12), .b20(b20), .b21(b21),
                   .b22(b22), .pe_c00(pe_c00), .pe_c01(pe_c01), .pe_c10(pe_c10), .pe_c11(pe_c11),
                   .sa2x2_c00(sa2x2_c00), .sa2x2_c01(sa2x2_c01), .sa2x2_c10(sa2x2_c10), .sa2x2_c11(sa2x2_c11),
                   .sa3x3_c00(sa3x3_c00), .sa3x3_c01(sa3x3_c01), .sa3x3_c10(sa3x3_c10), .sa3x3_c11(sa3x3_c11),
                   .pe_din(pe_din), .pe_win(pe_win), .sa2x2_din0(sa2x2_din0),  .sa2x2_din1(sa2x2_din1), .sa2x2_win0(sa2x2_win0),
                   .sa2x2_win1(sa2x2_win1), .sa3x3_din0(sa3x3_din0), .sa3x3_din1(sa3x3_din1), .sa3x3_din2(sa3x3_din2),
                   .sa3x3_win0(sa3x3_win0), .sa3x3_win1(sa3x3_win1), .sa3x3_win2(sa3x3_win2), .state(state), .next_state(next_state),
                   .pe_clear(pe_clear), .sa2x2_clear(sa2x2_clear), .sa3x3_clear(sa3x3_clear), .done(done));

    ram memory(.clk(clk), .rst(rst), .in(1'b0), .addr(5'b0), .en(1'b0),
               .a00(a00),.a01(a01),.a02(a02),.a03(a03),
               .a10(a10),.a11(a11),.a12(a12),.a13(a13),
               .a20(a20),.a21(a21),.a22(a22),.a23(a23),
               .a30(a30),.a31(a31),.a32(a32),.a33(a33),
               .b00(b00),.b01(b01),.b02(b02),
               .b10(b10),.b11(b11),.b12(b12),
               .b20(b20),.b21(b21),.b22(b22));

    //print display(clk, rst, done, pe_c00, pe_c01, pe_c10, pe_c11,sa2x2_c00, sa2x2_c01, sa2x2_c10, sa2x2_c11,
    //                sa3x3_c00, sa3x3_c01, sa3x3_c10, sa3x3_c11, PE_single_output, systolic_2X2_output, systolic_3X3_output, display_output);

    pe single_pe(.clk(clk), .rst(rst), .clear(pe_clear), .din(pe_din), .win(pe_win), .dout(pe_dout), .out(pe_out));
    sa2x2 systolic_2x2(.clk(clk), .rst(rst), .clear(sa2x2_clear), .din0(sa2x2_din0), .din1(sa2x2_din1), .win0(sa2x2_win0), .win1(sa2x2_win1), .out(sa2x2_out));
    sa3x3 systolic_3x3(.clk(clk), .rst(rst), .clear(sa3x3_clear), .din0(sa3x3_din0), .din1(sa3x3_din1), .din2(sa3x3_din2), .win0(sa3x3_win0), .win1(sa3x3_win1), .win2(sa3x3_win2), .out(sa3x3_out));

endmodule

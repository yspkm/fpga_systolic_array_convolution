module top(
        clk, rst, state, next_state
    );

    input wire clk, rst;

    output wire[6:0] state, next_state;

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

    wire[7:0]
        pe_out_00, pe_out_01,
        pe_out_10, pe_out_11,
        sa2x2_out_00, sa2x2_out_01,
        sa2x2_out_10, sa2x2_out_11,
        sa3x3_out_00, sa3x3_out_01,
        sa3x3_out_10, sa3x3_out_11;
    wire[31:0]
        cnt_clk_pe_start, cnt_clk_pe_end,
        cnt_clk_sa2x2_start, cnt_clk_sa2x2_end,
        cnt_clk_sa3x3_start, cnt_clk_sa3x3_end;


    wire done;

    tpu controller(
            .clk(clk), .rst(rst), .a00(a00), .a01(a01), .a02(a02), .a03(a03),
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

    ram memory(
            .clk(clk), .rst(rst),
            .a00(a00),.a01(a01),.a02(a02),.a03(a03),
            .a10(a10),.a11(a11),.a12(a12),.a13(a13),
            .a20(a20),.a21(a21),.a22(a22),.a23(a23),
            .a30(a30),.a31(a31),.a32(a32),.a33(a33),
            .b00(b00),.b01(b01),.b02(b02),
            .b10(b10),.b11(b11),.b12(b12),
            .b20(b20),.b21(b21),.b22(b22));

    lcd display(
            .clk(clk), .rst(rst), .done(done),
            .pe_out_00(pe_out_00),.pe_out_01(pe_out_01),
            .pe_out_10(pe_out_10),.pe_out_11(pe_out_11),
            .sa2x2_out_00(sa2x2_out_00),.sa2x2_out_01(sa2x2_out_01),
            .sa2x2_out_10(sa2x2_out_10),.sa2x2_out_11(sa2x2_out_11),
            .sa3x3_out_00(sa3x3_out_00), .sa3x3_out_01(sa3x3_out_01),
            .sa3x3_out_10(sa3x3_out_10), .sa3x3_out_11(sa3x3_out_11),
            .cnt_clk_pe_start(cnt_clk_pe_start),.cnt_clk_pe_end(cnt_clk_pe_end),
            .cnt_clk_sa2x2_start(cnt_clk_sa2x2_start),.cnt_clk_sa2x2_end(cnt_clk_sa2x2_end),
            .cnt_clk_sa3x3_start(cnt_clk_sa3x3_start), .cnt_clk_sa3x3_end(cnt_clk_sa3x3_end)
        );

    pe computation_single_pe(
           .clk(clk), .rst(rst), .clear(pe_clear),
           .din(pe_din), .win(pe_win),
           .dout(pe_dout), .out(pe_out));
    sa2x2 computation_sa2x2(
              .clk(clk), .rst(rst), .clear(sa2x2_clear),
              .din0(sa2x2_din0), .din1(sa2x2_din1),
              .win0(sa2x2_win0), .win1(sa2x2_win1),
              .out(sa2x2_out));
    sa3x3 computation_sa3x3(
              .clk(clk), .rst(rst), .clear(sa3x3_clear),
              .din0(sa3x3_din0), .din1(sa3x3_din1), .din2(sa3x3_din2),
              .win0(sa3x3_win0), .win1(sa3x3_win1), .win2(sa3x3_win2),
              .out(sa3x3_out));
    compio computation_buffer(
               .clk(clk), .rst(rst),
               .pe_c00(pe_c00), .pe_c01(pe_c01),
               .pe_c10(pe_c10), .pe_c11(pe_c11),
               .sa2x2_c00(sa2x2_c00), .sa2x2_c01(sa2x2_c01),
               .sa2x2_c10(sa2x2_c10), .sa2x2_c11(sa2x2_c11),
               .sa3x3_c00(sa3x3_c00), .sa3x3_c01(sa3x3_c01),
               .sa3x3_c10(sa3x3_c10), .sa3x3_c11(sa3x3_c11),
               .pe_out(pe_out), .sa2x2_out(sa2x2_out), .sa3x3_out(sa3x3_out),
               .cnt_clk_pe_start(cnt_clk_pe_start),.cnt_clk_pe_end(cnt_clk_pe_end),
               .cnt_clk_sa2x2_start(cnt_clk_sa2x2_start),.cnt_clk_sa2x2_end(cnt_clk_sa2x2_end),
               .cnt_clk_sa3x3_start(cnt_clk_sa3x3_start), .cnt_clk_sa3x3_end(cnt_clk_sa3x3_end),
               .pe_out_00(pe_out_00),.pe_out_01(pe_out_01),
               .pe_out_10(pe_out_10),.pe_out_11(pe_out_11),
               .sa2x2_out_00(sa2x2_out_00),.sa2x2_out_01(sa2x2_out_01),
               .sa2x2_out_10(sa2x2_out_10),.sa2x2_out_11(sa2x2_out_11),
               .sa3x3_out_00(sa3x3_out_00), .sa3x3_out_01(sa3x3_out_01),
               .sa3x3_out_10(sa3x3_out_10), .sa3x3_out_11(sa3x3_out_11));

endmodule

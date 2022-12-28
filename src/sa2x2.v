module sa2x2(din0, din1, win0, win1, clk, rst, clear, out);
    input wire clk, rst, clear;
    input wire [7:0] din0, din1, win0, win1;
    output wire [7:0] out;
    wire [7:0] DOUT_00,DOUT_01, DOUT_10,DOUT_11, WOUT_00,WOUT_01, WOUT_10,WOUT_11;
    wire [7:0] ACCUM_00, ACCUM_01, ACCUM_10, ACCUM_11;

    addu8 add0(ACCUM_00, ACCUM_11, out);
    pe pe00(.clk(clk), .rst(rst), .clear(clear), .din(din0), .win(win0),  .dout(DOUT_00), .wout(WOUT_00), .out(ACCUM_00));
    pe pe01(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_00), .win(win1),  .dout(DOUT_01), .wout(WOUT_01), .out(ACCUM_01));
    pe pe10(.clk(clk), .rst(rst), .clear(clear), .din(din1), .win(WOUT_00), .dout(DOUT_10), .wout(WOUT_10), .out(ACCUM_10));
    pe pe11(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_10), .win(WOUT_01), .dout(DOUT_11), .wout(WOUT_11), .out(ACCUM_11));

endmodule

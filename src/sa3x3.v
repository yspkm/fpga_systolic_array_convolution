
module sa3x3(din0, din1, din2, win0, win1, win2, clk, rst, clear, out);

    input wire clk, rst, clear;
    input wire [7:0] din0, din1, din2, win0, win1, win2;
    output wire [7:0] out;

    wire [7:0] DOUT_00, DOUT_01,DOUT_02,  DOUT_10, DOUT_11, DOUT_12, DOUT_20, DOUT_21, DOUT_22, WOUT_00, WOUT_01,WOUT_02,WOUT_10,WOUT_11, WOUT_12,WOUT_20,WOUT_21,WOUT_22;
    wire [7:0] ACCUM_00, ACCUM_01, ACCUM_02, ACCUM_10, ACCUM_11, ACCUM_12, ACCUM_20, ACCUM_21, ACCUM_22;
    wire [7:0] add1_out;

    addu8 add0(.a(ACCUM_00),.b(ACCUM_11),.out(add1_out));
    addu8 add1(.a(add1_out),.b(ACCUM_22),.out(out));

    pe pe00(.clk(clk), .rst(rst), .clear(clear), .din(din0), .win(win0),  .dout(DOUT_00), .wout(WOUT_00), .out(ACCUM_00));
    pe pe01(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_00), .win(win1), .dout(DOUT_01), .wout(WOUT_01), .out(ACCUM_01));
    pe pe02(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_01), .win(win2),  .dout(DOUT_02), .wout(WOUT_02), .out(ACCUM_02));
    pe pe10(.clk(clk), .rst(rst), .clear(clear), .din(din1), .win(WOUT_00), .dout(DOUT_10), .wout(WOUT_10), .out(ACCUM_10));
    pe pe11(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_10), .win(WOUT_01),  .dout(DOUT_11), .wout(WOUT_11), .out(ACCUM_11));
    pe pe12(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_11), .win(WOUT_02),  .dout(DOUT_12), .wout(WOUT_12), .out(ACCUM_12));
    pe pe20(.clk(clk), .rst(rst), .clear(clear), .din(din2), .win(WOUT_10),.dout(DOUT_20), .wout(WOUT_20), .out(ACCUM_20));
    pe pe21(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_20), .win(WOUT_11), .dout(DOUT_21), .wout(WOUT_21), .out(ACCUM_21));
    pe pe22(.clk(clk), .rst(rst), .clear(clear), .din(DOUT_21), .win(WOUT_12), .dout(DOUT_22), .wout(WOUT_22), .out(ACCUM_22));

endmodule

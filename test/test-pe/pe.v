module pe(
        clk, rst, clear,
        din, win,
        dout, wout,
        out);

    input clk, rst, clear;
    input wire [7:0] din,win;

    output wire [7:0] dout, wout, out;

    wire[7:0]  mult_out, add_out;

    multu8 mult_flow(.a(din), .b(win), .out(mult_out));
    addu8 add_flow(.a(out), .b(mult_out), .out(add_out));

    uint8 weight_flow(.clk(clk), .rst(rst), .clear(clear), .in(win), .out(wout));
    uint8 data_flow(.clk(clk), .rst(rst), .clear(clear), .in(din), .out(dout));
    uint8 accumulator(.clk(clk), .rst(rst), .clear(clear), .in(add_out), .out(out));

endmodule

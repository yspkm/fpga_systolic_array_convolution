module uint8(clk ,rst, clear, in, out);
    input wire clk,rst,clear;
    input wire [7:0] in;
    output wire [7:0] out;

    flipflop flipflop0(.clk(clk), .rst(rst), .clear(clear), .in(in[0]), .out(out[0]));
    flipflop flipflop1(.clk(clk), .rst(rst), .clear(clear), .in(in[1]), .out(out[1]));
    flipflop flipflop2(.clk(clk), .rst(rst), .clear(clear), .in(in[2]), .out(out[2]));
    flipflop flipflop3(.clk(clk), .rst(rst), .clear(clear), .in(in[3]), .out(out[3]));
    flipflop flipflop4(.clk(clk), .rst(rst), .clear(clear), .in(in[4]), .out(out[4]));
    flipflop flipflop5(.clk(clk), .rst(rst), .clear(clear), .in(in[5]), .out(out[5]));
    flipflop flipflop6(.clk(clk), .rst(rst), .clear(clear), .in(in[6]), .out(out[6]));
    flipflop flipflop7(.clk(clk), .rst(rst), .clear(clear), .in(in[7]), .out(out[7]));

endmodule

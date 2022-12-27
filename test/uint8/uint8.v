module uint8(clk, u8_in, u8_out);
    input wire clk;
    input wire [0:7] u8_in;

    output wire [0:7] u8_out;

    wire [0:7] dummy;

    dlatch bit0(.clk(clk), .d(u8_in[0]), .q(u8_out[0]), .q_bar(dummy[0]));
    dlatch bit1(.clk(clk), .d(u8_in[1]), .q(u8_out[1]), .q_bar(dummy[1]));
    dlatch bit2(.clk(clk), .d(u8_in[2]), .q(u8_out[2]), .q_bar(dummy[2]));
    dlatch bit3(.clk(clk), .d(u8_in[3]), .q(u8_out[3]), .q_bar(dummy[3]));
    dlatch bit4(.clk(clk), .d(u8_in[4]), .q(u8_out[4]), .q_bar(dummy[4]));
    dlatch bit5(.clk(clk), .d(u8_in[5]), .q(u8_out[5]), .q_bar(dummy[5]));
    dlatch bit6(.clk(clk), .d(u8_in[6]), .q(u8_out[6]), .q_bar(dummy[6]));
    dlatch bit7(.clk(clk), .d(u8_in[7]), .q(u8_out[7]), .q_bar(dummy[7]));

endmodule

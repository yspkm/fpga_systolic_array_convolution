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

module addu8(a, b, out);
    input wire [7:0] a, b;
    output wire [7:0] out;

    wire [8:1] carry;

    fadder fa0(carry[1],out[0],a[0],b[0], 1'b0);
    fadder fa1(carry[2],out[1],a[1],b[1],carry[1]);
    fadder fa2(carry[3],out[2],a[2],b[2],carry[2]);
    fadder fa3(carry[4],out[3],a[3],b[3],carry[3]);
    fadder fa4(carry[5],out[4],a[4],b[4],carry[4]);
    fadder fa5(carry[6],out[5],a[5],b[5],carry[5]);
    fadder fa6(carry[7],out[6],a[6],b[6],carry[6]);
    fadder fa7(carry[8],out[7],a[7],b[7],carry[7]);

endmodule

module addu10(a, b, out);
    input wire [9:0] a, b;
    output wire [9:0] out;

    wire [10:1] carry;

    fadder fa0(carry[1],out[0],a[0],b[0], 1'b0);
    fadder fa1(carry[2],out[1],a[1],b[1],carry[1]);
    fadder fa2(carry[3],out[2],a[2],b[2],carry[2]);
    fadder fa3(carry[4],out[3],a[3],b[3],carry[3]);
    fadder fa4(carry[5],out[4],a[4],b[4],carry[4]);
    fadder fa5(carry[6],out[5],a[5],b[5],carry[5]);
    fadder fa6(carry[7],out[6],a[6],b[6],carry[6]);
    fadder fa7(carry[8],out[7],a[7],b[7],carry[7]);
    fadder fa8(carry[9],out[8],a[8],b[8],carry[8]);
    fadder fa9(carry[10],out[9],a[9],b[9],carry[9]);

endmodule

module addu6(a, b, out);
    input wire [5:0] a, b;
    output wire [5:0] out;

    wire [6:1] carry;

    fadder fa0(carry[1],out[0],a[0],b[0], 1'b0);
    fadder fa1(carry[2],out[1],a[1],b[1],carry[1]);
    fadder fa2(carry[3],out[2],a[2],b[2],carry[2]);
    fadder fa3(carry[4],out[3],a[3],b[3],carry[3]);
    fadder fa4(carry[5],out[4],a[4],b[4],carry[4]);
    fadder fa5(carry[6],out[5],a[5],b[5],carry[5]);

endmodule

module addu4(a, b, out);
    input wire [3:0] a, b;
    output wire [3:0] out;

    wire [4:1] carry;

    fadder fa0(carry[1],out[0],a[0],b[0], 1'b0);
    fadder fa1(carry[2],out[1],a[1],b[1],carry[1]);
    fadder fa2(carry[3],out[2],a[2],b[2],carry[2]);
    fadder fa3(carry[4],out[3],a[3],b[3],carry[3]);

endmodule

module fadder(cout, sum, ain,bin,cin);
    input ain, bin, cin;
    output cout, sum;

    wire and_0_out, and_1_out, and_2_out;

    xor (sum, ain, bin, cin);
    and (and_0_out, ain, bin);
    and (and_1_out, ain, cin);
    and (and_2_out, bin, cin);
    or (cout, and_0_out, and_1_out, and_2_out);
endmodule

module hadder(a,b,s,c);
    input a,b;
    output s, c;

    xor(s, a, b);
    and(c, a, b);

endmodule

module flipflop(clk, rst, clear, in, out);
    input wire clk, rst, clear, in;
    output reg out;

    always @ (rst or clk or clear) begin
        if (rst || clear) begin
            out <= 1'b0;
        end
        else begin
            if (clk) begin

                out <= in;
            end
        end
    end
endmodule

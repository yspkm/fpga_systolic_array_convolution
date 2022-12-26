
module sa33(
        clk, rst,
        a11, a12, a13, a14,
        a21, a22, a23, a24,
        a31, a32, a33, a34,
        a41, a42, a43, a44,
        b11, b12, b13,
        b21, b22, b23,
        b31, b32, b33,
        c11, c12,
        c21, c22
    );

    input wire clk, rst;
    input wire [0:7]
          a11, a12, a13, a14,
          a21, a22, a23, a24,
          a31, a32, a33, a34,
          a41, a42, a43, a44,
          b11, b12, b13,
          b21, b22, b23,
          b31, b32, b33;
    output reg[0:7]
           c11, c12,
           c21, c22;
    reg [0:3] cnt;
    parameter S0=0, S1=1, S2=2, S3=3, S4=4, S5=5, S6=6, S7=7;
    always(posedge clk)
    begin

    end





endmodule

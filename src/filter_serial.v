//`include "pe.v"
module filter_serial(
        clk, rst,

        a11, a12, a13, a14,
        a21, a22, a23, a24,
        a31, a32, a33, a34,
        a41, a42, a43, a44,

        b11, b12, b13,
        b21, b22, b23,
        b31, b32, b33,

        c11, c12,
        c21, c22,

        done
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

    output wire[0:7]
           c11, c12,
           c21, c22;
    output reg done;

    reg [0:7] state;

    parameter[0:7] zero = 8'd0;
    parameter[0:7] SR=10,S0=0,S1=1,S2=2,S3=3,S4=4,S5=5,S6=6,S7=7,S8=8, S9=9;


    reg[0:7] CUR_WEIGHT, CUR_DATA, U1,U2,U3,U4,L1,L2,L3,L4;
    wire[0:7] D1,D2,D3,D4,R1,R2,R3,R4;

    pe pe1(.clk(clk), .rst(rst), .u(U1), .d(D1), .l(L1), .r(R1), .out(c11));
    pe pe2(.clk(clk), .rst(rst), .u(U2), .d(D2), .l(L2), .r(R2), .out(c12));
    pe pe3(.clk(clk), .rst(rst), .u(U3), .d(D3), .l(L3), .r(R3), .out(c21));
    pe pe4(.clk(clk), .rst(rst), .u(U4), .d(D4), .l(L4), .r(R4), .out(c22));

    always @ (posedge rst) begin
        //{c11, c12, c21, c22, state, done} <= {zero, zero, zero, zero, SR, 1'b0};
        {state, done} <= {SR, 1'b0};
    end



    always @ (posedge clk) begin
        case(state)
            S0: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a33, a34, a43, a44, b11, b11, b11, b11}; end
            S1: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a32, a33, a42, a43, b12, b12, b12, b12}; end
            S2: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a31, a32, a41, a42, b13, b13, b13, b13}; end
            S3: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a23, a24, a33, a34, b21, b21, b21, b21}; end
            S4: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a22, a23, a32, a33, b22, b22, b22, b22}; end
            S5: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a21, a22, a31, a32, b23, b23, b23, b23}; end
            S6: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a13, a14, a23, a24, b31, b31, b31, b31}; end
            S7: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a12, a13, a22, a23, b32, b32, b32, b32}; end
            S8: begin {L1, L2, L3, L4, U1, U2, U3, U4} <= {a11, a12, a21, a22, b33, b33, b33, b33}; end
            S9: begin done = 1'b1; end
        endcase
    end

    always @(state)
    begin
        case (state)
            SR:state<=S0;
            S0:state<=S1;
            S1:state<=S2;
            S2:state<=S3;
            S3:state<=S4;
            S4:state<=S5;
            S5:state<=S6;
            S6:state<=S7;
            S7:state<=S8;
            S8:state<=S9;
        endcase
    end

endmodule

`timescale 1ps/1ps

module tb_filter_serial;

    // Matrix A
    parameter[0:7] INPUT_A11 = 8'd3;
    parameter[0:7] INPUT_A12 = 8'd1;
    parameter[0:7] INPUT_A13 = 8'd2;
    parameter[0:7] INPUT_A14 = 8'd0;
    parameter[0:7] INPUT_A21 = 8'd3;
    parameter[0:7] INPUT_A22 = 8'd1;
    parameter[0:7] INPUT_A23 = 8'd2;
    parameter[0:7] INPUT_A24 = 8'd2;
    parameter[0:7] INPUT_A31 = 8'd0;
    parameter[0:7] INPUT_A32 = 8'd2;
    parameter[0:7] INPUT_A33 = 8'd3;
    parameter[0:7] INPUT_A34 = 8'd1;
    parameter[0:7] INPUT_A41 = 8'd1;
    parameter[0:7] INPUT_A42 = 8'd3;
    parameter[0:7] INPUT_A43 = 8'd3;
    parameter[0:7] INPUT_A44 = 8'd2;

    // Matrix B
    parameter[0:7] INPUT_B11 = 8'd3;
    parameter[0:7] INPUT_B12 = 8'd0;
    parameter[0:7] INPUT_B13 = 8'd3;
    parameter[0:7] INPUT_B21 = 8'd3;
    parameter[0:7] INPUT_B22 = 8'd1;
    parameter[0:7] INPUT_B23 = 8'd2;
    parameter[0:7] INPUT_B31 = 8'd1;
    parameter[0:7] INPUT_B32 = 8'd1;
    parameter[0:7] INPUT_B33 = 8'd1;

    // Matrix C
    parameter[0:7] ANS_C11 = 8'd28;
    parameter[0:7] ANS_C12 = 8'd22;
    parameter[0:7] ANS_C21 = 8'd29;
    parameter[0:7] ANS_C22 = 8'd30;


    reg CLK, RST;
    wire DONE;

    reg[0:7]
       A11, A12, A13, A14,
       A21, A22, A23, A24,
       A31, A32, A33, A34,
       A41, A42, A43, A44,

       B11, B12, B13,
       B21, B22, B23,
       B31, B32, B33,

       EXPECTED_C11, EXPECTED_C12,
       EXPECTED_C21, EXPECTED_C22;

    wire[0:7]
        C11, C12,
        C21, C22;

    filter_serial conv1(
                      .clk(CLK), .rst(RST),
                      .a11(A11), .a12(A12), .a13(A13), .a14(A14),
                      .a21(A12), .a22(A22), .a23(A23), .a24(A24),
                      .a31(A31), .a32(A32), .a33(A33), .a34(A34),
                      .a41(A41), .a42(A42), .a43(A43), .a44(A44),
                      .b11(B11), .b12(B12), .b13(B13),
                      .b21(B21), .b22(B22), .b23(B23),
                      .b31(B31), .b32(B32), .b33(B33),
                      .c11(C11), .c12(C12),
                      .c21(C21), .c22(C22),
                      .done(DONE));

    initial begin


        CLK = 1'b0;
        RST=1'b1;
        A11=INPUT_A11;
        A12=INPUT_A12;
        A13=INPUT_A13;
        A14=INPUT_A14;
        A21=INPUT_A21;
        A22=INPUT_A22;
        A23=INPUT_A23;
        A24=INPUT_A24;
        A31=INPUT_A31;
        A32=INPUT_A32;
        A33=INPUT_A33;
        A34=INPUT_A34;
        A41=INPUT_A41;
        A42=INPUT_A42;
        A43=INPUT_A43;
        A44=INPUT_A44;

        B11=INPUT_B11;
        B12=INPUT_B12;
        B13=INPUT_B13;
        B21=INPUT_B21;
        B22=INPUT_B22;
        B23=INPUT_B23;
        B31=INPUT_B31;
        B32=INPUT_B32;
        B33=INPUT_B33;

        EXPECTED_C11=ANS_C11;
        EXPECTED_C12=ANS_C12;
        EXPECTED_C21=ANS_C21;
        EXPECTED_C22=ANS_C22;

    end

    initial begin
        forever begin
            #10 CLK = ~CLK;
        end
    end

    initial begin
        #10 RST = 1'b0;
        $dumpfile("output.vcd");
        $dumpvars(2, tb_filter_serial);
        #250
         $finish;
    end




endmodule

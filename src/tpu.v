
module tpu(
        clk, rst, done,

        a00, a01, a02, a03,
        a10, a11, a12, a13,
        a20, a21, a22, a23,
        a30, a31, a32, a33,

        b00, b01, b02,
        b10, b11, b12,
        b20, b21, b22,

        pe_c00, pe_c01,
        pe_c10, pe_c11,

        sa2x2_c00, sa2x2_c01,
        sa2x2_c10, sa2x2_c11,

        sa3x3_c00, sa3x3_c01,
        sa3x3_c10, sa3x3_c11,

        pe_din, pe_win,
        sa2x2_din0, sa2x2_din1, sa2x2_win0, sa2x2_win1,
        sa3x3_din0, sa3x3_din1, sa3x3_din2, sa3x3_win0, sa3x3_win1, sa3x3_win2,

        state, next_state,
        pe_clear, sa2x2_clear, sa3x3_clear,
    );

    input wire clk, rst;

    input [7:0] a00, a01, a02, a03, a10, a11, a12, a13,
          a20, a21, a22, a23, a30, a31, a32, a33;

    input [7:0] b00, b01, b02, b10, b11, b12, b20, b21, b22;

    //output
    output reg pe_c00, pe_c01, pe_c10, pe_c11;
    output reg sa2x2_c00, sa2x2_c01,sa2x2_c10, sa2x2_c11;
    output reg sa3x3_c00, sa3x3_c01,sa3x3_c10, sa3x3_c11;

    output reg [7:0] pe_din, pe_win;
    output reg [7:0] sa2x2_din0, sa2x2_din1, sa2x2_win0, sa2x2_win1;
    output reg [7:0] sa3x3_din0, sa3x3_din1, sa3x3_din2, sa3x3_win0, sa3x3_win1, sa3x3_win2;

    output reg [6:0] state, next_state;

    output reg pe_clear, sa2x2_clear, sa3x3_clear;

    output reg done;


    //states
    parameter STATE_RESET = 0,
              STATE_PE_SINGLE_1_1 = 1, STATE_PE_SINGLE_1_2 = 2, STATE_PE_SINGLE_1_3 = 3, STATE_PE_SINGLE_1_4 = 4, STATE_PE_SINGLE_1_5 = 5, STATE_PE_SINGLE_1_6 = 6,
              STATE_PE_SINGLE_1_7 = 7, STATE_PE_SINGLE_1_8 = 8, STATE_PE_SINGLE_1_9 = 9, STATE_PE_SINGLE_1_10 = 10, STATE_PE_SINGLE_1_11 = 11,
              STATE_PE_SINGLE_2_1 = 12, STATE_PE_SINGLE_2_2 = 13, STATE_PE_SINGLE_2_3 = 14, STATE_PE_SINGLE_2_4 = 15, STATE_PE_SINGLE_2_5 = 16, STATE_PE_SINGLE_2_6 = 17,
              STATE_PE_SINGLE_2_7 = 18, STATE_PE_SINGLE_2_8 = 19, STATE_PE_SINGLE_2_9 = 20, STATE_PE_SINGLE_2_10 = 21, STATE_PE_SINGLE_2_11 = 22,
              STATE_PE_SINGLE_3_1 = 23, STATE_PE_SINGLE_3_2 = 24, STATE_PE_SINGLE_3_3 = 25, STATE_PE_SINGLE_3_4 = 26, STATE_PE_SINGLE_3_5 = 27, STATE_PE_SINGLE_3_6 = 28,
              STATE_PE_SINGLE_3_7 = 29, STATE_PE_SINGLE_3_8 = 30, STATE_PE_SINGLE_3_9 = 31, STATE_PE_SINGLE_3_10 = 32, STATE_PE_SINGLE_3_11 = 33,
              STATE_PE_SINGLE_4_1 = 34, STATE_PE_SINGLE_4_2 = 35, STATE_PE_SINGLE_4_3 = 36, STATE_PE_SINGLE_4_4 = 37, STATE_PE_SINGLE_4_5 = 38, STATE_PE_SINGLE_4_6 = 39,
              STATE_PE_SINGLE_4_7 = 40, STATE_PE_SINGLE_4_8 = 41, STATE_PE_SINGLE_4_9 = 42, STATE_PE_SINGLE_4_10 = 43, STATE_PE_SINGLE_4_11 = 44,

              STATE_SA_3X3_1_1 = 45, STATE_SA_3X3_1_2 = 46, STATE_SA_3X3_1_3 = 47, STATE_SA_3X3_1_4 = 48, STATE_SA_3X3_1_5 = 49,
              STATE_SA_3X3_1_6 = 50, STATE_SA_3X3_1_7 = 51, STATE_SA_3X3_1_8 = 52, STATE_SA_3X3_1_9 = 53,
              STATE_SA_3X3_2_1 = 54, STATE_SA_3X3_2_2 = 55, STATE_SA_3X3_2_3 = 56, STATE_SA_3X3_2_4 = 57, STATE_SA_3X3_2_5 = 58,
              STATE_SA_3X3_2_6 = 59, STATE_SA_3X3_2_7 = 60, STATE_SA_3X3_2_8 = 61, STATE_SA_3X3_2_9 = 62,
              STATE_SA_3X3_3_1 = 63, STATE_SA_3X3_3_2 = 64, STATE_SA_3X3_3_3 = 65, STATE_SA_3X3_3_4 = 66, STATE_SA_3X3_3_5 = 67,
              STATE_SA_3X3_3_6 = 68, STATE_SA_3X3_3_7 = 69, STATE_SA_3X3_3_8 = 70, STATE_SA_3X3_3_9 = 71,
              STATE_SA_3X3_4_1 = 72, STATE_SA_3X3_4_2 = 73, STATE_SA_3X3_4_3 = 74, STATE_SA_3X3_4_4 = 75, STATE_SA_3X3_4_5 = 76,
              STATE_SA_3X3_4_6 = 77, STATE_SA_3X3_4_7 = 78, STATE_SA_3X3_4_8 = 79, STATE_SA_3X3_4_9 = 80,

              STATE_SA_2X2_1_1 = 81, STATE_SA_2X2_1_2 = 82, STATE_SA_2X2_1_3 = 83, STATE_SA_2X2_1_4 = 84,
              STATE_SA_2X2_1_5 = 85, STATE_SA_2X2_1_6 = 86, STATE_SA_2X2_1_7 = 87, STATE_SA_2X2_1_8 = 88,
              STATE_SA_2X2_2_1 = 89, STATE_SA_2X2_2_2 = 90, STATE_SA_2X2_2_3 = 91, STATE_SA_2X2_2_4 = 92,
              STATE_SA_2X2_2_5 = 93, STATE_SA_2X2_2_6 = 94, STATE_SA_2X2_2_7 = 95, STATE_SA_2X2_2_8 = 96,
              STATE_SA_2X2_3_1 = 97, STATE_SA_2X2_3_2 = 98, STATE_SA_2X2_3_3 = 99, STATE_SA_2X2_3_4 = 100,
              STATE_SA_2X2_3_5 = 101, STATE_SA_2X2_3_6 = 102, STATE_SA_2X2_3_7 = 103, STATE_SA_2X2_3_8 = 104,
              STATE_SA_2X2_4_1 = 105, STATE_SA_2X2_4_2 = 106, STATE_SA_2X2_4_3 = 107, STATE_SA_2X2_4_4 = 108,
              STATE_SA_2X2_4_5 = 109, STATE_SA_2X2_4_6 = 110, STATE_SA_2X2_4_7 = 111, STATE_SA_2X2_4_8 = 112,

              STATE_DONE = 113;

    //update the current state => clk edge or rst
    always @ (clk or rst) begin
        if (rst)
            state = STATE_RESET;
        else if (clk)
            state = next_state;
    end


    //Determine the output depending on the current state only + Determine the next state
    always @ (state) begin
        case(state)
            STATE_RESET : begin
                next_state <= STATE_PE_SINGLE_1_1;

                pe_c00 = 1'b0;
                pe_c01 = 1'b0;
                pe_c10 = 1'b0;
                pe_c11 = 1'b0;

                sa2x2_c00 = 1'b0;
                sa2x2_c01 = 1'b0;
                sa2x2_c10 = 1'b0;
                sa2x2_c11 = 1'b0;

                sa3x3_c00 = 1'b0;
                sa3x3_c01 = 1'b0;
                sa3x3_c10 = 1'b0;
                sa3x3_c11 = 1'b0;

                pe_din = 0;
                pe_win = 0;

                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;

                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;

                done = 1'b0;
            end

            //calculation of single processing element(PE)
            //calculating C00
            STATE_PE_SINGLE_1_1: begin
                pe_din = a00;
                pe_win = b22;
                next_state = STATE_PE_SINGLE_1_2;
            end
            STATE_PE_SINGLE_1_2: begin
                pe_din = a01;
                pe_win = b21;
                next_state = STATE_PE_SINGLE_1_3;
            end
            STATE_PE_SINGLE_1_3: begin
                pe_din = a02;
                pe_win = b20;
                next_state = STATE_PE_SINGLE_1_4;
            end
            STATE_PE_SINGLE_1_4: begin
                pe_din = a10;
                pe_win = b12;
                next_state = STATE_PE_SINGLE_1_5;
            end
            STATE_PE_SINGLE_1_5: begin
                pe_din = a11;
                pe_win = b11;
                next_state = STATE_PE_SINGLE_1_6;
            end
            STATE_PE_SINGLE_1_6: begin
                pe_din = a12;
                pe_win = b10;
                next_state = STATE_PE_SINGLE_1_7;
            end
            STATE_PE_SINGLE_1_7: begin
                pe_din = a20;
                pe_win = b02;
                next_state = STATE_PE_SINGLE_1_8;
            end
            STATE_PE_SINGLE_1_8: begin
                pe_din = a21;
                pe_win = b01;
                next_state = STATE_PE_SINGLE_1_9;
            end
            STATE_PE_SINGLE_1_9: begin
                pe_din = a22;
                pe_win = b00;
                next_state = STATE_PE_SINGLE_1_10;
            end
            STATE_PE_SINGLE_1_10: begin
                pe_din = 0;
                pe_win = 0;
                next_state = STATE_PE_SINGLE_1_11;
            end
            STATE_PE_SINGLE_1_11: begin
                pe_c00 = 1'b1;
                pe_clear = 1'b1;
                next_state = STATE_PE_SINGLE_2_1;
            end

            //calculating C01
            STATE_PE_SINGLE_2_1: begin
                pe_clear = 1'b0;
                pe_c00 = 1'b0;
                pe_din = a01;
                pe_win = b22;
                next_state = STATE_PE_SINGLE_2_2;
            end
            STATE_PE_SINGLE_2_2: begin
                pe_din = a02;
                pe_win = b21;
                next_state = STATE_PE_SINGLE_2_3;
            end
            STATE_PE_SINGLE_2_3: begin
                pe_din = a03;
                pe_win = b20;
                next_state = STATE_PE_SINGLE_2_4;
            end
            STATE_PE_SINGLE_2_4: begin
                pe_din = a11;
                pe_win = b12;
                next_state = STATE_PE_SINGLE_2_5;
            end
            STATE_PE_SINGLE_2_5: begin
                pe_din = a12;
                pe_win = b11;
                next_state = STATE_PE_SINGLE_2_6;
            end
            STATE_PE_SINGLE_2_6: begin
                pe_din = a13;
                pe_win = b10;
                next_state = STATE_PE_SINGLE_2_7;
            end
            STATE_PE_SINGLE_2_7: begin
                pe_din = a21;
                pe_win = b02;
                next_state = STATE_PE_SINGLE_2_8;
            end
            STATE_PE_SINGLE_2_8: begin
                pe_din = a22;
                pe_win = b01;
                next_state = STATE_PE_SINGLE_2_9;
            end
            STATE_PE_SINGLE_2_9: begin
                pe_din = a23;
                pe_win = b00;
                next_state = STATE_PE_SINGLE_2_10;
            end
            STATE_PE_SINGLE_2_10: begin
                pe_din = 0;
                pe_win = 0;
                next_state = STATE_PE_SINGLE_2_11;
            end
            STATE_PE_SINGLE_2_11: begin
                pe_c01 = 1'b1;
                pe_clear = 1'b1;
                next_state = STATE_PE_SINGLE_3_1;
            end

            //calculating C10
            STATE_PE_SINGLE_3_1: begin
                pe_clear = 1'b0;
                pe_c01 = 1'b0;
                pe_din = a10;
                pe_win = b22;
                next_state = STATE_PE_SINGLE_3_2;
            end
            STATE_PE_SINGLE_3_2: begin
                pe_din = a11;
                pe_win = b21;
                next_state = STATE_PE_SINGLE_3_3;
            end
            STATE_PE_SINGLE_3_3: begin
                pe_din = a12;
                pe_win = b20;
                next_state = STATE_PE_SINGLE_3_4;
            end
            STATE_PE_SINGLE_3_4: begin
                pe_din = a20;
                pe_win = b12;
                next_state = STATE_PE_SINGLE_3_5;
            end
            STATE_PE_SINGLE_3_5: begin
                pe_din = a21;
                pe_win = b11;
                next_state = STATE_PE_SINGLE_3_6;
            end
            STATE_PE_SINGLE_3_6: begin
                pe_din = a22;
                pe_win = b10;
                next_state = STATE_PE_SINGLE_3_7;
            end
            STATE_PE_SINGLE_3_7: begin
                pe_din = a30;
                pe_win = b02;
                next_state = STATE_PE_SINGLE_3_8;
            end
            STATE_PE_SINGLE_3_8: begin
                pe_din = a31;
                pe_win = b01;
                next_state = STATE_PE_SINGLE_3_9;
            end
            STATE_PE_SINGLE_3_9: begin
                pe_din = a32;
                pe_win = b00;
                next_state = STATE_PE_SINGLE_3_10;
            end
            STATE_PE_SINGLE_3_10: begin
                pe_din = 0;
                pe_win = 0;
                next_state = STATE_PE_SINGLE_3_11;
            end
            STATE_PE_SINGLE_3_11: begin
                pe_c10 = 1'b1;
                pe_clear = 1'b1;
                next_state = STATE_PE_SINGLE_4_1;
            end

            //calculating C11
            STATE_PE_SINGLE_4_1: begin
                pe_clear = 1'b0;
                pe_c10 = 1'b0;
                pe_din = a11;
                pe_win = b22;
                next_state = STATE_PE_SINGLE_4_2;
            end
            STATE_PE_SINGLE_4_2: begin
                pe_din = a12;
                pe_win = b21;
                next_state = STATE_PE_SINGLE_4_3;
            end
            STATE_PE_SINGLE_4_3: begin
                pe_din = a13;
                pe_win = b20;
                next_state = STATE_PE_SINGLE_4_4;
            end
            STATE_PE_SINGLE_4_4: begin
                pe_din = a21;
                pe_win = b12;
                next_state = STATE_PE_SINGLE_4_5;
            end
            STATE_PE_SINGLE_4_5: begin
                pe_din = a22;
                pe_win = b11;
                next_state = STATE_PE_SINGLE_4_6;
            end
            STATE_PE_SINGLE_4_6: begin
                pe_din = a23;
                pe_win = b10;
                next_state = STATE_PE_SINGLE_4_7;
            end
            STATE_PE_SINGLE_4_7: begin
                pe_din = a31;
                pe_win = b02;
                next_state = STATE_PE_SINGLE_4_8;
            end
            STATE_PE_SINGLE_4_8: begin
                pe_din = a32;
                pe_win = b01;
                next_state = STATE_PE_SINGLE_4_9;
            end
            STATE_PE_SINGLE_4_9: begin
                pe_din = a33;
                pe_win = b00;
                next_state = STATE_PE_SINGLE_4_10;
            end
            STATE_PE_SINGLE_4_10: begin
                pe_din = 0;
                pe_win = 0;
                next_state = STATE_PE_SINGLE_4_11;
            end
            STATE_PE_SINGLE_4_11: begin
                pe_c11 = 1'b1;
                pe_clear = 1'b1;
                next_state = STATE_SA_3X3_1_1;
            end

            //calculation of 3X3 systolic array
            //calculating C00
            STATE_SA_3X3_1_1: begin
                pe_c11 = 1'b0;
                sa3x3_din0 = a00;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = b22;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_1_2;
            end

            STATE_SA_3X3_1_2: begin
                sa3x3_din0 = a01;
                sa3x3_din1 = a10;
                sa3x3_din2 = 0;
                sa3x3_win0 = b21;
                sa3x3_win1 = b12;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_1_3;
            end

            STATE_SA_3X3_1_3: begin
                sa3x3_din0 = a02;
                sa3x3_din1 = a11;
                sa3x3_din2 = a20;
                sa3x3_win0 = b20;
                sa3x3_win1 = b11;
                sa3x3_win2 = b02;
                next_state = STATE_SA_3X3_1_4;
            end

            STATE_SA_3X3_1_4: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = a12;
                sa3x3_din2 = a21;
                sa3x3_win0 = 0;
                sa3x3_win1 = b10;
                sa3x3_win2 = b01;
                next_state = STATE_SA_3X3_1_5;
            end

            STATE_SA_3X3_1_5: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = a22;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = b00;
                next_state = STATE_SA_3X3_1_6;
            end

            STATE_SA_3X3_1_6: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_1_7;
            end

            STATE_SA_3X3_1_7: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_1_8;
            end

            STATE_SA_3X3_1_8: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_1_9;
            end

            STATE_SA_3X3_1_9: begin
                sa3x3_clear = 1'b1;
                sa3x3_c00 = 1'b1;
                next_state = STATE_SA_3X3_2_1;
            end

            //calculating C01
            STATE_SA_3X3_2_1: begin
                sa3x3_clear = 1'b0;
                sa3x3_c00 = 1'b0;
                sa3x3_din0 = a01;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = b22;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_2_2;
            end

            STATE_SA_3X3_2_2: begin
                sa3x3_din0 = a02;
                sa3x3_din1 = a11;
                sa3x3_din2 = 0;
                sa3x3_win0 = b21;
                sa3x3_win1 = b12;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_2_3;
            end

            STATE_SA_3X3_2_3: begin
                sa3x3_din0 = a03;
                sa3x3_din1 = a12;
                sa3x3_din2 = a21;
                sa3x3_win0 = b20;
                sa3x3_win1 = b11;
                sa3x3_win2 = b02;
                next_state = STATE_SA_3X3_2_4;
            end

            STATE_SA_3X3_2_4: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = a13;
                sa3x3_din2 = a22;
                sa3x3_win0 = 0;
                sa3x3_win1 = b10;
                sa3x3_win2 = b01;
                next_state = STATE_SA_3X3_2_5;
            end

            STATE_SA_3X3_2_5: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = a23;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = b00;
                next_state = STATE_SA_3X3_2_6;
            end

            STATE_SA_3X3_2_6: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_2_7;
            end

            STATE_SA_3X3_2_7: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_2_8;
            end

            STATE_SA_3X3_2_8: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_2_9;
            end

            STATE_SA_3X3_2_9: begin
                sa3x3_clear = 1'b1;
                sa3x3_c01 = 1'b1;
                next_state = STATE_SA_3X3_3_1;
            end


            //calculating C10
            STATE_SA_3X3_3_1: begin
                sa3x3_clear = 1'b0;
                sa3x3_c01 = 1'b0;
                sa3x3_din0 = a10;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = b22;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_3_2;
            end

            STATE_SA_3X3_3_2: begin
                sa3x3_din0 = a11;
                sa3x3_din1 = a20;
                sa3x3_din2 = 0;
                sa3x3_win0 = b21;
                sa3x3_win1 = b12;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_3_3;
            end

            STATE_SA_3X3_3_3: begin
                sa3x3_din0 = a12;
                sa3x3_din1 = a21;
                sa3x3_din2 = a30;
                sa3x3_win0 = b20;
                sa3x3_win1 = b11;
                sa3x3_win2 = b02;
                next_state = STATE_SA_3X3_3_4;
            end

            STATE_SA_3X3_3_4: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = a22;
                sa3x3_din2 = a31;
                sa3x3_win0 = 0;
                sa3x3_win1 = b10;
                sa3x3_win2 = b01;
                next_state = STATE_SA_3X3_3_5;
            end

            STATE_SA_3X3_3_5: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = a32;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = b00;
                next_state = STATE_SA_3X3_3_6;
            end

            STATE_SA_3X3_3_6: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_3_7;
            end

            STATE_SA_3X3_3_7: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_3_8;
            end

            STATE_SA_3X3_3_8: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_3_9;
            end

            STATE_SA_3X3_3_9: begin
                sa3x3_clear = 1'b1;
                sa3x3_c10 = 1'b1;
                next_state = STATE_SA_3X3_4_1;
            end


            //calculating C11
            STATE_SA_3X3_4_1: begin
                sa3x3_clear = 1'b0;
                sa3x3_c10 = 1'b0;
                sa3x3_din0 = a11;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = b22;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_4_2;
            end

            STATE_SA_3X3_4_2: begin
                sa3x3_din0 = a12;
                sa3x3_din1 = a21;
                sa3x3_din2 = 0;
                sa3x3_win0 = b21;
                sa3x3_win1 = b12;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_4_3;
            end

            STATE_SA_3X3_4_3: begin
                sa3x3_din0 = a13;
                sa3x3_din1 = a22;
                sa3x3_din2 = a31;
                sa3x3_win0 = b20;
                sa3x3_win1 = b11;
                sa3x3_win2 = b02;
                next_state = STATE_SA_3X3_4_4;
            end

            STATE_SA_3X3_4_4: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = a23;
                sa3x3_din2 = a32;
                sa3x3_win0 = 0;
                sa3x3_win1 = b10;
                sa3x3_win2 = b01;
                next_state = STATE_SA_3X3_4_5;
            end

            STATE_SA_3X3_4_5: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = a33;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = b00;
                next_state = STATE_SA_3X3_4_6;
            end

            STATE_SA_3X3_4_6: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_4_7;
            end

            STATE_SA_3X3_4_7: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_4_8;
            end

            STATE_SA_3X3_4_8: begin
                sa3x3_din0 = 0;
                sa3x3_din1 = 0;
                sa3x3_din2 = 0;
                sa3x3_win0 = 0;
                sa3x3_win1 = 0;
                sa3x3_win2 = 0;
                next_state = STATE_SA_3X3_4_9;
            end

            STATE_SA_3X3_4_9: begin
                sa3x3_clear = 1'b1;
                sa3x3_c11 = 1'b1;
                next_state = STATE_SA_2X2_1_1;
            end

            //calculation of 2X2 systolic array
            //calculating C00
            STATE_SA_2X2_1_1: begin
                sa3x3_c11 = 1'b0;
                sa2x2_din0 = a00;
                sa2x2_din1 = 0;
                sa2x2_win0 = b22;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_1_2;
            end

            STATE_SA_2X2_1_2: begin
                sa2x2_din0 = a01;
                sa2x2_din1 = a10;
                sa2x2_win0 = b21;
                sa2x2_win1 = b12;
                next_state = STATE_SA_2X2_1_3;
            end

            STATE_SA_2X2_1_3: begin
                sa2x2_din0 = a02;
                sa2x2_din1 = a11;
                sa2x2_win0 = b20;
                sa2x2_win1 = b11;
                next_state = STATE_SA_2X2_1_4;
            end

            STATE_SA_2X2_1_4: begin
                sa2x2_din0 = a20;
                sa2x2_din1 = a12;
                sa2x2_win0 = b02;
                sa2x2_win1 = b10;
                next_state = STATE_SA_2X2_1_5;
            end

            STATE_SA_2X2_1_5: begin
                sa2x2_din0 = a22;
                sa2x2_din1 = a21;
                sa2x2_win0 = b00;
                sa2x2_win1 = b01;
                next_state = STATE_SA_2X2_1_6;
            end

            STATE_SA_2X2_1_6: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_1_7;
            end

            STATE_SA_2X2_1_7: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_1_8;
            end

            STATE_SA_2X2_1_8: begin
                sa2x2_clear = 1'b1;
                sa2x2_c00 = 1'b1;
                next_state = STATE_SA_2X2_2_1;
            end

            //calculating C01
            STATE_SA_2X2_2_1: begin
                sa2x2_c00 = 1'b0;
                sa2x2_clear = 1'b0;
                sa2x2_din0 = a01;
                sa2x2_din1 = 0;
                sa2x2_win0 = b22;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_2_2;
            end

            STATE_SA_2X2_2_2: begin
                sa2x2_din0 = a02;
                sa2x2_din1 = a11;
                sa2x2_win0 = b21;
                sa2x2_win1 = b12;
                next_state = STATE_SA_2X2_2_3;
            end

            STATE_SA_2X2_2_3: begin
                sa2x2_din0 = a03;
                sa2x2_din1 = a12;
                sa2x2_win0 = b20;
                sa2x2_win1 = b11;
                next_state = STATE_SA_2X2_2_4;
            end

            STATE_SA_2X2_2_4: begin
                sa2x2_din0 = a21;
                sa2x2_din1 = a13;
                sa2x2_win0 = b02;
                sa2x2_win1 = b10;
                next_state = STATE_SA_2X2_2_5;
            end

            STATE_SA_2X2_2_5: begin
                sa2x2_din0 = a23;
                sa2x2_din1 = a22;
                sa2x2_win0 = b00;
                sa2x2_win1 = b01;
                next_state = STATE_SA_2X2_2_6;
            end

            STATE_SA_2X2_2_6: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_2_7;
            end

            STATE_SA_2X2_2_7: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_2_8;
            end

            STATE_SA_2X2_2_8: begin
                sa2x2_clear = 1'b1;
                sa2x2_c01 = 1'b1;
                next_state = STATE_SA_2X2_3_1;
            end

            //calculating C10
            STATE_SA_2X2_3_1: begin
                sa2x2_c01 = 1'b0;
                sa2x2_clear = 1'b0;
                sa2x2_din0 = a10;
                sa2x2_din1 = 0;
                sa2x2_win0 = b22;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_3_2;
            end

            STATE_SA_2X2_3_2: begin
                sa2x2_din0 = a11;
                sa2x2_din1 = a20;
                sa2x2_win0 = b21;
                sa2x2_win1 = b12;
                next_state = STATE_SA_2X2_3_3;
            end

            STATE_SA_2X2_3_3: begin
                sa2x2_din0 = a12;
                sa2x2_din1 = a21;
                sa2x2_win0 = b20;
                sa2x2_win1 = b11;
                next_state = STATE_SA_2X2_3_4;
            end

            STATE_SA_2X2_3_4: begin
                sa2x2_din0 = a30;
                sa2x2_din1 = a22;
                sa2x2_win0 = b02;
                sa2x2_win1 = b10;
                next_state = STATE_SA_2X2_3_5;
            end

            STATE_SA_2X2_3_5: begin
                sa2x2_din0 = a32;
                sa2x2_din1 = a31;
                sa2x2_win0 = b00;
                sa2x2_win1 = b01;
                next_state = STATE_SA_2X2_3_6;
            end

            STATE_SA_2X2_3_6: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_3_7;
            end

            STATE_SA_2X2_3_7: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_3_8;
            end

            STATE_SA_2X2_3_8: begin
                sa2x2_clear = 1'b1;
                sa2x2_c10 = 1'b1;
                next_state = STATE_SA_2X2_4_1;
            end

            //calculating C11
            STATE_SA_2X2_4_1: begin
                sa2x2_c10 = 1'b0;
                sa2x2_clear = 1'b0;
                sa2x2_din0 = a11;
                sa2x2_din1 = 0;
                sa2x2_win0 = b22;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_4_2;
            end

            STATE_SA_2X2_4_2: begin
                sa2x2_din0 = a12;
                sa2x2_din1 = a21;
                sa2x2_win0 = b21;
                sa2x2_win1 = b12;
                next_state = STATE_SA_2X2_4_3;
            end

            STATE_SA_2X2_4_3: begin
                sa2x2_din0 = a13;
                sa2x2_din1 = a22;
                sa2x2_win0 = b20;
                sa2x2_win1 = b11;
                next_state = STATE_SA_2X2_4_4;
            end

            STATE_SA_2X2_4_4: begin
                sa2x2_din0 = a31;
                sa2x2_din1 = a23;
                sa2x2_win0 = b02;
                sa2x2_win1 = b10;
                next_state = STATE_SA_2X2_4_5;
            end

            STATE_SA_2X2_4_5: begin
                sa2x2_din0 = a33;
                sa2x2_din1 = a32;
                sa2x2_win0 = b00;
                sa2x2_win1 = b01;
                next_state = STATE_SA_2X2_4_6;
            end

            STATE_SA_2X2_4_6: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_4_7;
            end

            STATE_SA_2X2_4_7: begin
                sa2x2_din0 = 0;
                sa2x2_din1 = 0;
                sa2x2_win0 = 0;
                sa2x2_win1 = 0;
                next_state = STATE_SA_2X2_4_8;
            end

            STATE_SA_2X2_4_8: begin
                sa2x2_clear = 1'b1;
                sa2x2_c11 = 1'b1;
                next_state = STATE_DONE;
            end

            STATE_DONE: begin
                done = 1'b1;
            end

        endcase
    end



endmodule

`timescale 1ns / 1ps

module tb_sa2x2;

    reg CLK, RST;
    reg [7:0] DIN0, DIN1, WIN0, WIN1;
    wire [7:0]OUT;

    sa2x2 SA2X2(
              .clk(CLK), .rst(RST), .clear(1'b0),
              .din0(DIN0), .din1(DIN1),
              .win0(WIN0), .win1(WIN1),
              .out(OUT));
    reg[7:0] ANS_OUT;
    initial begin

        CLK = 1'b0;
        RST = 1'b0;
        DIN0  = 8'd0;
        DIN1 = 8'd0;
        WIN0 = 8'd0;
        WIN1 = 8'd0;
        ANS_OUT = 8'd202;
    end

    initial begin
        forever begin
            #10 CLK = !CLK;
        end
    end

    //>> A = [1, 2, 3; 4, 5, 6; 7, 8, 9];
    //>> B = [0, 9, 8; 1, 2, 3; 7, 8, 9];
    // ans = 202
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(2, tb_sa2x2);

        #10 RST = 1'b1;
        #10 RST = 1'b0;

        WIN0 = 8'd9;
        WIN1 = 8'd0;
        DIN0 = 8'd1;
        DIN1 = 8'd0;
        #20
         WIN0 = 8'd8;
        WIN1 = 8'd3;
        DIN0 = 8'd2;
        DIN1 = 8'd4;
        #20
         WIN0 = 8'd7;
        WIN1 = 8'd2;
        DIN0 = 8'd3;
        DIN1 = 8'd5;

        #20
         WIN0 = 8'd8;
        WIN1 = 8'd1;
        DIN0 = 8'd7;
        DIN1 = 8'd6;

        #20
         WIN0 = 8'd0;
        WIN1 = 8'd9;
        DIN0 = 8'd9;
        DIN1 = 8'd8;
        #20
         WIN0 = 8'd0;
        WIN1 = 8'd0;
        DIN0 = 8'd0;
        DIN1 = 8'd0;
        #20 $finish();
    end
endmodule

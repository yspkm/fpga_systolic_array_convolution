`timescale 1ns / 1ps

module tb_ram;

    reg CLK, RST;
    reg EN;
    reg [4:0]ADDR;
    reg [7:0]IN;

    wire [7:0]
         A00, A01, A02, A03,
         A10, A11, A12, A13,
         A20, A21, A22, A23,
         A30, A31, A32, A33,
         B00, B01, B02,
         B10, B11, B12,
         B20, B21, B22,
         C00, C01,
         C10, C11;

    parameter[4:0] 
        ADDR_A00=5'd0,ADDR_A01=5'd1,ADDR_A02=5'd2,ADDR_A03=5'd3,
        ADDR_A10=5'd4,ADDR_A11=5'd5,ADDR_A12=5'd6,ADDR_A13=5'd7,
        ADDR_A20=5'd8,ADDR_A21=5'd9,ADDR_A22=5'd10,ADDR_A23=5'd11,
        ADDR_A30=5'd12,ADDR_A31=5'd13,ADDR_A32=5'd14,ADDR_A33=5'd15,
        ADDR_B00=5'd16,ADDR_B01=5'd17,ADDR_B02=5'd18,
        ADDR_B10=5'd19,ADDR_B11=5'd20,ADDR_B12=5'd21,
        ADDR_B20=5'd22,ADDR_B21=5'd23,ADDR_B22=5'd24,
        ADDR_C00=5'd25,ADDR_C01=5'd26,
        ADDR_C10=5'd27,ADDR_C11=5'd28;
    parameter PERIOD = 20, HALF_PERIOD = 10;

    // Random Access Memory
    ram ram(.clk(CLK), .rst(RST), .in(IN), .addr(ADDR), .en(EN),
            .a00(A00),.a01(A01),.a02(A02),.a03(A03),
            .a10(A10),.a11(A11),.a12(A12),.a13(A13),
            .a20(A20),.a21(A21),.a22(A22),.a23(A23),
            .a30(A30),.a31(A31),.a32(A32),.a33(A33),
            .b00(B00),.b01(B01),.b02(B02),
            .b10(B10),.b11(B11),.b12(B12),
            .b20(B20),.b21(B21),.b22(B22),
            .c00(C00), .c01(C01),
            .c10(C10), .c11(C11));

    initial begin
        {CLK, RST, EN, ADDR, IN} = 16'd0;
    end


    initial begin
        forever begin
            #HALF_PERIOD CLK = ~CLK;
        end
    end

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(2, tb_ram);

        #10 RST = 1'b1;
        #10 RST = 1'b0;
        #20 EN = 1'b1;
        #20 ADDR = 5'd0;
        IN = 8'd0;
        #20 ADDR = 5'd1;
        IN = 8'd1;
        #20 ADDR = 5'd2;
        IN = 8'd2;
        #20 ADDR = 5'd3;
        IN = 8'd3;
        #20 ADDR = 5'd4;
        IN = 8'd4;
        #20 ADDR = 5'd5;
        IN = 8'd5;
        #20 ADDR = 5'd6;
        IN = 8'd6;
        #20 ADDR = 5'd7;
        IN = 8'd7;
        #20 ADDR = 5'd8;
        IN = 8'd8;
        #20 ADDR = 5'd9;
        IN = 8'd9;
        #20 ADDR = 5'd10;
        IN = 8'd10;
        #20 ADDR = 5'd11;
        IN = 8'd11;
        #20 ADDR = 5'd12;
        IN = 8'd12;
        #20 ADDR = 5'd13;
        IN = 8'd13;
        #20 ADDR = 5'd14;
        IN = 8'd14;
        #20 ADDR = 5'd15;
        IN = 8'd15;
        #20 ADDR = 5'd16;
        IN = 8'd16;
        #20 ADDR = 5'd17;
        IN = 8'd17;
        #20 ADDR = 5'd18;
        IN = 8'd18;
        #20 ADDR = 5'd19;
        IN = 8'd19;
        #20 ADDR = 5'd20;
        IN = 8'd20;
        #20 ADDR = 5'd21;
        IN = 8'd21;
        #20 ADDR = 5'd22;
        IN = 8'd22;
        #20 ADDR = 5'd23;
        IN = 8'd23;
        #20 ADDR = 5'd24;
        IN = 8'd24;
        #20 ADDR = 5'd24;
        IN = 8'd24;
        $finish();

    end


endmodule

`timescale 1ns / 1ps
module ram(clk, rst, in, addr, en,
               a00,a01,a02,a03,
               a10,a11,a12,a13,
               a20,a21,a22,a23,
               a30,a31,a32,a33,
               b00,b01,b02,
               b10,b11,b12,
               b20,b21,b22,
               c00, c01,
               c10, c11);


    input wire clk, rst, en;
    input [4:0]addr;
    input [7:0]in;

    output [7:0]
           a00,a01,a02,a03,
           a10,a11,a12,a13,
           a20,a21,a22,a23,
           a30,a31,a32,a33,
           b00,b01,b02,
           b10,b11,b12,
           b20,b21,b22,
           c00, c01,
           c10, c11;

    reg [7:0] mem[28:0];

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

    assign {a00, a01, a02, a03} = {mem[ADDR_A00], mem[ADDR_A01], mem[ADDR_A02], mem[ADDR_A03]};
    assign {a10, a11, a12, a13} = {mem[ADDR_A10], mem[ADDR_A11], mem[ADDR_A12], mem[ADDR_A13]};
    assign {a20, a21, a22, a23} = {mem[ADDR_A20], mem[ADDR_A21], mem[ADDR_A22], mem[ADDR_A23]};
    assign {a30, a31, a32, a33} = {mem[ADDR_A30], mem[ADDR_A31], mem[ADDR_A32], mem[ADDR_A33]};
    assign {b00, b01, b02} = {mem[ADDR_B00], mem[ADDR_B01], mem[ADDR_B02]};
    assign {b10, b11, b12} = {mem[ADDR_B10], mem[ADDR_B11], mem[ADDR_B12]};
    assign {b20, b21, b22} = {mem[ADDR_B20], mem[ADDR_B21], mem[ADDR_B22]};
    assign {c00, c01} = {mem[ADDR_C00], mem[ADDR_C01]};
    assign {c10, c11} = {mem[ADDR_C10], mem[ADDR_C11]};

    integer i;
    always @(rst or clk) begin
        if (rst) begin
            for (i = 0; i < 29; i = i + 1) begin
                mem[i] <= 8'd0;
            end

            // mem-a
            mem[ADDR_A00] <= 8'd4;
            mem[ADDR_A01] <= 8'd6;
            mem[ADDR_A02] <= 8'd5;
            mem[ADDR_A03] <= 8'd1;
            mem[ADDR_A10] <= 8'd1;
            mem[ADDR_A11] <= 8'd2;
            mem[ADDR_A12] <= 8'd3;
            mem[ADDR_A13] <= 8'd4;
            mem[ADDR_A20] <= 8'd7;
            mem[ADDR_A21] <= 8'd8;
            mem[ADDR_A22] <= 8'd9;
            mem[ADDR_A23] <= 8'd3;
            mem[ADDR_A30] <= 8'd5;
            mem[ADDR_A31] <= 8'd7;
            mem[ADDR_A32] <= 8'd2;
            mem[ADDR_A33] <= 8'd7;

            // mem-b
            mem[ADDR_B00] <= 8'd2;
            mem[ADDR_B01] <= 8'd3;
            mem[ADDR_B02] <= 8'd2;
            mem[ADDR_B10] <= 8'd4;
            mem[ADDR_B11] <= 8'd6;
            mem[ADDR_B12] <= 8'd5;
            mem[ADDR_B20] <= 8'd1;
            mem[ADDR_B21] <= 8'd7;
            mem[ADDR_B22] <= 8'd1;

        end
        else if (clk) begin
            if (en) begin      // write in
                mem[addr] <= in;
            end

        end
    end

endmodule

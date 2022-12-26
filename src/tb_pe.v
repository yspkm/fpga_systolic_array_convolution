`timescale 1ns / 1ps
module tb_pe;
    reg clk, rst;
    reg [0:7] U, L; 
    wire [0:7] D, R, OUT;

    pe pe1(.clk(clk), .rst(rst), .u(U), .l(L), .r(R), .d(D), .out(OUT));

    initial
    begin
        #0 clk = 1'b0;
        #0 rst = 1'b1;
    end

    initial 
    begin
        forever
            begin
                #10 clk = ~clk;
            end
    end

    initial 
    begin
        $dumpfile("output.vcd");
        $dumpvars(2, tb_pe);
        #20 rst = 1'b0; 
        #22 {U, L} = {8'd7, 8'd5};
        #23 $display("%d, %d, %d", R, D, OUT);
        #11 rst = 1'b1;
        #1 rst = 1'b0;
        #21 {U, L} = {8'd3, 8'd2};
        #28 $display("%d, %d, %d", R, D, OUT);
        #21 {U, L} = {8'd12, 8'd7};
        #20 $display("%d, %d, %d", R, D, OUT);
        #49$finish;
    end

endmodule
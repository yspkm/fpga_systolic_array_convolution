`timescale 1ns / 1ps

module tb_multu8;
    reg clk;
    reg [7:0] A, B, ANS;
    wire [7:0] OUT;

    multu8 mult(.a(A), .b(B), .out(OUT));

    initial begin
        clk = 1'b0;
    end

    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end
    integer i, j;
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(3, tb_multu8);
        for (i = 64; i < 69; i = i + 1) 
        begin
            for (j = 10; j < 15; j = j + 1)
            begin
                #20 A = i; B = j; ANS = i * j;
            end
        end
        #20 $finish();
    end

endmodule
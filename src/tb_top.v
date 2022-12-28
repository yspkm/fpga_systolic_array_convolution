`timescale  1ns/1ps
module tb_top;
    reg CLK, RST, START;
    wire [6:0] STATE, NEXT_STATE;

    top TOP(CLK, RST, STATE, NEXT_STATE);

    initial begin
        CLK = 1'b0;
        RST = 1'b0;
    end


    initial begin
        forever begin
            #10 CLK = !CLK;
        end

    end


    initial begin
        $dumpfile("output.vcd");
        $dumpvars(3, tb_top);
        #10 RST = 1'b1;
        #10 RST = 1'b0;
        START = 1'b1;
        #2500 $finish();

    end


endmodule

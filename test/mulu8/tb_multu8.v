module tb_multu8;

    reg clk;
    reg [7:0] A,B;
    wire [7:0] OUT;

    multu8 V0(.a(A), .b(B), .out(OUT));

    initial begin
        clk = 0;
    end

    initial begin
        forever begin
            #5 clk = ~clk  ;
        end

    end
    integer i, j;
    initial begin
        $dumpfile("output.vcd");
        $dumpvars(2, tb_multu8);
        for (i = 0; i < 10; i = i + 1)
        begin
            A = i; 
            for (j = 0; j < 10; j = j + 1)
            begin
                #22 B = j;
            end
        end
        #50 $finish;
    end


endmodule

module tb_pe;
    reg CLK, RST;
    reg[7:0] DIN, WIN;
    wire [7:0] DOUT, WOUT, OUT;
    reg[7:0] ANS;

    pe PE(.clk(CLK), .rst(RST),.win(WIN),.din(DIN), .wout(WOUT), .dout(DOUT), .out(OUT));

    initial begin
        CLK = 1'b0;
        RST = 1'b1;
        ANS = 8'b0;
    end

    initial begin
        forever begin
            #10 CLK = ~CLK;
        end
    end

    integer i, j;

    initial begin
        #10
         $dumpfile("output.vcd");
        $dumpvars(2, tb_pe);
        #10 RST = 1'b0;
        for (i = 0; i < 10 ;i=i+1) begin
            for (j = 0; j < 10 ;j=j+1) begin
                DIN = i;
                WIN = j;
                ANS = ANS + i * j;
                //#20 $display("iter: %d", i*10+j);
            end
        end
        $finish();
    end

endmodule

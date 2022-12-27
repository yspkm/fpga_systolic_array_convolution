module tb_uin8;
    reg CLK;
    reg[0:7] U8_IN;
    wire [0:7] U8_OUT;

    uint8 uin8_module(.clk(CLK), .u8_in(U8_IN), .u8_out(U8_OUT));

    initial begin
        CLK = 1'b0;
    end

    initial begin
        forever begin
            #10 CLK = ~CLK;
        end
    end

    integer i;

    initial begin
        $dumpfile("output.vcd");
        $dumpvars(2, tb_uin8);
        for (i = 0; i < 10 ;i= i+1) begin
            #15 U8_IN = i;
        end
        $finish();
    end

endmodule

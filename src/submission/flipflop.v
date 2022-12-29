module flipflop(clk, rst, clear, in, out);
    input wire clk, rst, clear, in;
    output reg out;

    always @ (rst or clk or clear) begin
        if (rst || clear) begin
            out <= 1'b0;
        end
        else begin
            if (clk) begin

                out <= in;
            end
        end
    end
endmodule

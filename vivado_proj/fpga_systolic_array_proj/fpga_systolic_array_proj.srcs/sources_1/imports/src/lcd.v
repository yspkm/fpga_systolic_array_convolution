module lcd (
        clk, rst, done,
        pe_out_00, pe_out_01,
        pe_out_10, pe_out_11,
        sa2x2_out_00, sa2x2_out_01,
        sa2x2_out_10, sa2x2_out_11,
        sa3x3_out_00, sa3x3_out_01,
        sa3x3_out_10, sa3x3_out_11,
        cnt_clk_pe_start, cnt_clk_pe_end,
        cnt_clk_sa2x2_start, cnt_clk_sa2x2_end,
        cnt_clk_sa3x3_start, cnt_clk_sa3x3_end
    );

    input wire clk, rst, done;
    input wire[7:0]
          pe_out_00, pe_out_01,
          pe_out_10, pe_out_11,
          sa2x2_out_00, sa2x2_out_01,
          sa2x2_out_10, sa2x2_out_11,
          sa3x3_out_00, sa3x3_out_01,
          sa3x3_out_10, sa3x3_out_11;
    input wire[31:0]
          cnt_clk_pe_start, cnt_clk_pe_end,
          cnt_clk_sa2x2_start, cnt_clk_sa2x2_end,
          cnt_clk_sa3x3_start, cnt_clk_sa3x3_end;
    reg display_out, display_done;
    initial begin
        display_out <= 1'b0;
        display_done <= 1'b0;
    end
    always @ (clk) begin
        if (!display_out) begin
            if (done) begin
                display_out <= 1'b1;
            end
        end
    end

    always @ (display_out) begin
        if (!display_done && display_out) begin

            display_done = 1'b1;
            $display("\ncur clock: %t", $time);
            $display("<OUTPUT (SINGLE PE)>");
            $display("Speedup: %d%%", (32'd100*(cnt_clk_pe_end-cnt_clk_pe_start))/(cnt_clk_pe_end-cnt_clk_pe_start));
            $display("c_{1,1}: %d", pe_out_00);
            $display("c_{1,2}: %d", pe_out_01);
            $display("c_{2,1}: %d", pe_out_10);
            $display("c_{2,2}: %d", pe_out_11);

            $display("\n<OUTPUT (3x3 SYSTOLIC ARRRAY)>");
            $display("Speedup: %d%%", (32'd100*(cnt_clk_pe_end-cnt_clk_pe_start))/(cnt_clk_sa3x3_end-cnt_clk_sa3x3_start));
            $display("c_{1,1}: %d", sa3x3_out_00);
            $display("c_{1,2}: %d", sa3x3_out_01);
            $display("c_{2,1}: %d", sa3x3_out_10);
            $display("c_{2,2}: %d", sa3x3_out_11);

            $display("\n<OUTPUT (2x2 SYSTOLIC ARRRAY)>");
            $display("Speedup: %d%%", (32'd100*(cnt_clk_pe_end-cnt_clk_pe_start))/(cnt_clk_sa2x2_end-cnt_clk_sa2x2_start));
            $display("c_{1,1}: %d", sa2x2_out_00);
            $display("c_{1,2}: %d", sa2x2_out_01);
            $display("c_{2,1}: %d", sa2x2_out_10);
            $display("c_{2,2}: %d", sa2x2_out_11);
        end
    end

endmodule

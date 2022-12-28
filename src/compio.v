module compio (
        clk, rst,
        pe_c00, pe_c01,
        pe_c10, pe_c11,
        sa2x2_c00, sa2x2_c01,
        sa2x2_c10, sa2x2_c11,
        sa3x3_c00, sa3x3_c01,
        sa3x3_c10, sa3x3_c11,
        pe_out, sa2x2_out, sa3x3_out,

        pe_out_00, pe_out_01,
        pe_out_10, pe_out_11,
        sa2x2_out_00, sa2x2_out_01,
        sa2x2_out_10, sa2x2_out_11,
        sa3x3_out_00, sa3x3_out_01,
        sa3x3_out_10, sa3x3_out_11,

        cnt_clk_pe_start, cnt_clk_pe_end,
        cnt_clk_pe_start, cnt_clk_pe_end,
        cnt_clk_sa2x2_start, cnt_clk_sa2x2_end,
        cnt_clk_sa3x3_start, cnt_clk_sa3x3_end
    );

    output wire [7:0] pe_out_00, pe_out_01,
           pe_out_10, pe_out_11,
           sa2x2_out_00, sa2x2_out_01,
           sa2x2_out_10, sa2x2_out_11,
           sa3x3_out_00, sa3x3_out_01,
           sa3x3_out_10, sa3x3_out_11;

    input wire clk, rst,
          pe_c00, pe_c01,
          pe_c10, pe_c11,
          sa2x2_c00, sa2x2_c01,
          sa2x2_c10, sa2x2_c11,
          sa3x3_c00, sa3x3_c01,
          sa3x3_c10, sa3x3_c11;
    input wire [7:0] pe_out, sa2x2_out, sa3x3_out;

    output reg [31:0]
           cnt_clk_pe_start, cnt_clk_pe_end,
           cnt_clk_sa2x2_start, cnt_clk_sa2x2_end,
           cnt_clk_sa3x3_start, cnt_clk_sa3x3_end;

    reg [31:0] cnt_clk_sys;

    reg [7:0]
        PE_IN_00, PE_IN_01,
        PE_IN_10, PE_IN_11,
        SA2X2_IN_00, SA2X2_IN_01,
        SA2X2_IN_10, SA2X2_IN_11,
        SA3X3_IN_00, SA3X3_IN_01,
        SA3X3_IN_10, SA3X3_IN_11;

    wire [7:0]
         PE_OUT_00, PE_OUT_01,
         PE_OUT_10, PE_OUT_11,
         SA2X2_OUT_00, SA2X2_OUT_01,
         SA2X2_OUT_10, SA2X2_OUT_11,
         SA3X3_OUT_00, SA3X3_OUT_01,
         SA3X3_OUT_10, SA3X3_OUT_11;

    uint8 addr_pe00(.clk(clk), .rst(rst), .in(PE_IN_00), .out(PE_OUT_00));
    uint8 addr_pe01(.clk(clk), .rst(rst), .in(PE_IN_01), .out(PE_OUT_01));
    uint8 addr_pe10(.clk(clk), .rst(rst), .in(PE_IN_10), .out(PE_OUT_10));
    uint8 addr_pe11(.clk(clk), .rst(rst), .in(PE_IN_11), .out(PE_OUT_11));

    uint8 addr_sa2x2_00(.clk(clk), .rst(rst), .in(SA2X2_IN_00), .out(SA2X2_OUT_00));
    uint8 addr_sa2x2_01(.clk(clk), .rst(rst), .in(SA2X2_IN_01), .out(SA2X2_OUT_01));
    uint8 addr_sa2x2_10(.clk(clk), .rst(rst), .in(SA2X2_IN_10), .out(SA2X2_OUT_10));
    uint8 addr_sa2x2_11(.clk(clk), .rst(rst), .in(SA2X2_IN_11), .out(SA2X2_OUT_11));

    uint8 addr_sa3x3_00(.clk(clk), .rst(rst), .in(SA3X3_IN_00), .out(SA3X3_OUT_00));
    uint8 addr_sa3x3_01(.clk(clk), .rst(rst), .in(SA3X3_IN_01), .out(SA3X3_OUT_01));
    uint8 addr_sa3x3_10(.clk(clk), .rst(rst), .in(SA3X3_IN_10), .out(SA3X3_OUT_10));
    uint8 addr_sa3x3_11(.clk(clk), .rst(rst), .in(SA3X3_IN_11), .out(SA3X3_OUT_11));

    assign pe_out_00 = PE_OUT_00;
    assign pe_out_01 = PE_OUT_01;
    assign pe_out_10 = PE_OUT_10;
    assign pe_out_11 = PE_OUT_11;

    assign sa2x2_out_00 = SA2X2_OUT_00;
    assign sa2x2_out_01 = SA2X2_OUT_01;
    assign sa2x2_out_10 = SA2X2_OUT_10;
    assign sa2x2_out_11 = SA2X2_OUT_11;

    assign sa3x3_out_00 = SA3X3_OUT_00;
    assign sa3x3_out_01 = SA3X3_OUT_01;
    assign sa3x3_out_10 = SA3X3_OUT_10;
    assign sa3x3_out_11 = SA3X3_OUT_11;


    initial begin
        cnt_clk_sys <= 32'd0;
        cnt_clk_pe_start<=32'd0;
        cnt_clk_pe_end<=32'd0;
        cnt_clk_sa2x2_start<=32'd0;
        cnt_clk_sa2x2_end <= 32'd0;
        cnt_clk_sa3x3_start <= 32'd0;
        cnt_clk_sa3x3_end <= 32'd0;
    end

    always @ (posedge clk) begin
        cnt_clk_sys <= cnt_clk_sys + 1;
    end

    always @ (posedge pe_c00) begin
        PE_IN_00 <= pe_out;
    end

    always @ (posedge pe_c01) begin
        PE_IN_01 <= pe_out;
    end

    always @ (posedge pe_c10) begin
        PE_IN_10 <= pe_out;
    end

    always @ (posedge pe_c11) begin
        PE_IN_11 <= pe_out;
        cnt_clk_pe_end <= cnt_clk_sys;
        cnt_clk_sa3x3_start <= cnt_clk_sys + 32'd1; 
    end

    always @ (posedge sa2x2_c00) begin
        SA2X2_IN_00 <= sa2x2_out;
    end

    always @ (posedge sa2x2_c01) begin
        SA2X2_IN_01 <= sa2x2_out;
    end

    always @ (posedge sa2x2_c10) begin
        SA2X2_IN_10 <= sa2x2_out;
    end

    always @ (posedge sa2x2_c11) begin
        SA2X2_IN_11 <= sa2x2_out;
        cnt_clk_sa2x2_end <= cnt_clk_sys;
    end

    always @ (posedge sa2x2_c00) begin
        SA2X2_IN_00 <= sa2x2_out;
    end

    always @ (posedge sa3x3_c00) begin
        SA3X3_IN_00 <= sa3x3_out;
    end

    always @ (posedge sa3x3_c01) begin
        SA3X3_IN_01 <= sa3x3_out;
    end

    always @ (posedge sa3x3_c10) begin
        SA3X3_IN_10 <= sa3x3_out;
    end

    always @ (posedge sa3x3_c11) begin
        SA3X3_IN_11 <= sa3x3_out;
        cnt_clk_sa3x3_end <= cnt_clk_sys; 
        cnt_clk_sa2x2_start <= cnt_clk_sys + 32'd1; 
    end

endmodule

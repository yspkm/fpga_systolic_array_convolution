module dlatch(clk, d, q, q_bar);

    input wire clk, d;
    output wire q, q_bar;

    wire r, s;

    nand nand0(s, d, clk);
    nand nand1(r, s, clk);
    nand nand2(q, q_bar, s);
    nand nand3(q_bar, q, r);

endmodule
module fadder(cout, sum, ain,bin,cin);
    input ain, bin, cin;
    output cout, sum;

    wire and_0_out, and_1_out, and_2_out;

    xor (sum, ain, bin, cin);
    and (and_0_out, ain, bin);
    and (and_1_out, ain, cin);
    and (and_2_out, bin, cin);
    or (cout, and_0_out, and_1_out, and_2_out);
endmodule

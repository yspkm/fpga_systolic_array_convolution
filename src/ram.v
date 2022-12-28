module ram(clk, rst,
               a00,a01,a02,a03,
               a10,a11,a12,a13,
               a20,a21,a22,a23,
               a30,a31,a32,a33,
               b00,b01,b02,
               b10,b11,b12,
               b20,b21,b22);

    input wire clk, rst;

    output [7:0]
           a00,a01,a02,a03,
           a10,a11,a12,a13,
           a20,a21,a22,a23,
           a30,a31,a32,a33,
           b00,b01,b02,
           b10,b11,b12,
           b20,b21,b22;

    reg[7:0]
       INIT_A00,INIT_A01,INIT_A02,INIT_A03,
       INIT_A10,INIT_A11,INIT_A12,INIT_A13,
       INIT_A20,INIT_A21,INIT_A22,INIT_A23,
       INIT_A30,INIT_A31,INIT_A32,INIT_A33;

    reg[7:0]
       INIT_B00,INIT_B01,INIT_B02,
       INIT_B10,INIT_B11,INIT_B12,
       INIT_B20,INIT_B21,INIT_B22;

    // storage entries
    uint8 addr_a00(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A00), .out(a00));
    uint8 addr_a01(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A01), .out(a01));
    uint8 addr_a02(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A02), .out(a02));
    uint8 addr_a03(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A03), .out(a03));
    uint8 addr_a10(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A10), .out(a10));
    uint8 addr_a11(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A11), .out(a11));
    uint8 addr_a12(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A12), .out(a12));
    uint8 addr_a13(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A13), .out(a13));
    uint8 addr_a20(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A20), .out(a20));
    uint8 addr_a21(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A21), .out(a21));
    uint8 addr_a22(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A22), .out(a22));
    uint8 addr_a23(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A23), .out(a23));
    uint8 addr_a30(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A30), .out(a30));
    uint8 addr_a31(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A31), .out(a31));
    uint8 addr_a32(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A32), .out(a32));
    uint8 addr_a33(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_A33), .out(a33));
    uint8 addr_b00(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B00), .out(b00));
    uint8 addr_b01(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B01), .out(b01));
    uint8 addr_b02(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B02), .out(b02));
    uint8 addr_b10(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B10), .out(b10));
    uint8 addr_b11(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B11), .out(b11));
    uint8 addr_b12(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B12), .out(b12));
    uint8 addr_b20(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B20), .out(b20));
    uint8 addr_b21(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B21), .out(b21));
    uint8 addr_b22(.clk(clk), .rst(1'b0), .clear(1'b0), .in(INIT_B22), .out(b22));

    parameter[7:0]
             INPUT_A00=8'd4,INPUT_A01=8'd6,INPUT_A02=8'd5,INPUT_A03=8'd1,
             INPUT_A10=8'd1,INPUT_A11=8'd2,INPUT_A12=8'd3,INPUT_A13=8'd4,
             INPUT_A20=8'd7,INPUT_A21=8'd8,INPUT_A22=8'd9,INPUT_A23=8'd3,
             INPUT_A30=8'd5,INPUT_A31=8'd7,INPUT_A32=8'd2,INPUT_A33=8'd7;

    parameter[7:0]
             INPUT_B00=8'd2,INPUT_B01=8'd3,INPUT_B02=8'd2,
             INPUT_B10=8'd4,INPUT_B11=8'd6,INPUT_B12=8'd5,
             INPUT_B20=8'd1,INPUT_B21=8'd7,INPUT_B22=8'd1;
    initial begin
        //for initial block in ram.v
        // init data
        INIT_A00<=INPUT_A00;
        INIT_A01<=INPUT_A01;
        INIT_A02<=INPUT_A02;
        INIT_A03<=INPUT_A03;
        INIT_A10<=INPUT_A10;
        INIT_A11<=INPUT_A11;
        INIT_A12<=INPUT_A12;
        INIT_A13<=INPUT_A13;
        INIT_A20<=INPUT_A20;
        INIT_A21<=INPUT_A21;
        INIT_A22<=INPUT_A22;
        INIT_A23<=INPUT_A23;
        INIT_A30<=INPUT_A30;
        INIT_A31<=INPUT_A31;
        INIT_A32<=INPUT_A32;
        INIT_A33<=INPUT_A33;

        // init filter
        INIT_B00<=INPUT_B00;
        INIT_B01<=INPUT_B01;
        INIT_B02<=INPUT_B02;
        INIT_B10<=INPUT_B10;
        INIT_B11<=INPUT_B11;
        INIT_B12<=INPUT_B12;
        INIT_B20<=INPUT_B20;
        INIT_B21<=INPUT_B21;
        INIT_B22<=INPUT_B22;
    end

endmodule

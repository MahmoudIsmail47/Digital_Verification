module RAM_tb_A1 ();

// parameters
parameter MEM_WIDTH = 8;
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = $clog2(MEM_DEPTH);

// input signals
logic [MEM_WIDTH-1:0] din;
logic [ADDR_SIZE-1:0] addr_wr, addr_rd;
logic wr_en, rd_en, clk, rst_n;

// output signals
logic [MEM_WIDTH-1:0] dout;

// tb signals
logic [MEM_WIDTH-1:0] dout_exp;
logic [MEM_WIDTH-1:0] din_rand;
logic [ADDR_SIZE-1:0] addr_rand;
integer correct, wrong;

// instantiation
RAM DUT (.*);

// clock generation
initial begin
	clk = 0;
	forever
	#10 clk = ~clk;
end

//**************************************************//
// only writing task
task writing (
    input [MEM_WIDTH-1:0] data,
    input [ADDR_SIZE-1:0] addr
);
    rst_n = 1'b1;
    wr_en = 1'b1;
    rd_en = 1'b0;
    din = data;
    adder_wr = adder;
    @(negedge clk);
endtask

// reading task
task reading (
    input [ADDR_SIZE-1:0] addr
);
    rst_n = 1'b1;
    wr_en = 1'b0;
    rd_en = 1'b1;
    addr_rd = adder;
    @(negedge clk);
endtask

// initialization task
task start ();
    rst_n = 1'b0;
    wr_en = 1'b0;
    rd_en = 1'b0;
    addr_wr = 1'd0;
    addr_rd = 1'd0;
    din = 1'd0;
    @(negedge clk);
endtask

// reset test
task reset_test (int counts);
    integer i;
    rst_n = 0;
    for (i = 0, i < counts, i = i + 1) begin
    wr_en = $random;
    rd_en = $random;
    addr_wr = $random;
    addr_rd = $random;
    din = $random;
    dout_exp = 1'd0;
    @(negedge clk);
    end
endtask

// writing & reading task
task writing_N_reading (
    input [MEM_WIDTH-1:0] data,
    input [ADDR_SIZE-1:0] addr_writng,
    input [ADDR_SIZE-1:0] addr_reading
);
    rst_n = 1'b1;
    wr_en = 1'b1;
    rd_en = 1'b1;
    din = data;
    addr_wr = addr_writng;
    addr_rd = addr_reading;
    @(negedge clk);
endtask

// checking task
task check (
    input [MEM_WIDTH-1:0] data,
    string message
)
    dout_exp = data;
    @(negedge clk);
    if (dout != dout_exp) begin
        wrong = wrong + 1;
        $display ("Error in: %s" , message);
    end
    else begin
        correct = correct + 1;
    end
    @(negedge clk);
endtask

//**************************************************//
// initial block
initial begin
    clk = 0;
    start ();
    // reset test
    reset_test (20);
    // writing in 00, 01, 02, ff -> 01, 02, 03, ee
    writing (1'd1, 2'h00);
    check (1'b0, "only writing");
    writing (1'd2, 2'h01);
    check (1'b0, "only writing");
    writing (1'd3, 2'h02);
    check (1'b0, "only writing");
    writing (2'hee, 2'hff);
    check (1'b0, "only writing");
    // reading data from 00, 01, 02, ff
    reading (2'h00);
    check (2'h01, "only reading");
    reading (2'h01);
    check (2'h02, "only reading");
    reading (2'h02);
    check (2'h03, "only reading");
    reading (2'hff);
    check (2'hee, "only reading");
    // writing & reading
    writing_N_reading (2'h0a, 2'h05, 2'h00);
    check (2'h01, "writing ad reading");
    writing_N_reading (2'h0b, 2'h06, 2'h05);
    check (2'h0a, "writing ad reading");
    writing_N_reading (2'h0c, 2'h07, 2'h06);
    check (2'h0b, "writing ad reading");

    rst_n = 0;
    @(negedge clk);
    @(negedge clk);
    rst_n = 1;
    @(negedge clk);

    // random data input
    for (i = 0, i < 10, i = i + 1) begin
        din_rand = $ramdom;
        writing (din_rand, 2'h00);
        reading (2'h00);
        check (din_rand, "random data in");
    end

    // random adder write
    for (i = 0, i < 10, i = i + 1) begin
        addr_rand = $ramdom;
        writing (2'haa, addr_rand);
        reading (addr_rand);
        check (2'haa, "random address in");
    end

    // random adder write
    for (i = 0, i < 10, i = i + 1) begin
        addr_rand = $ramdom;
        writing (2'haa, addr_rand);
        reading (addr_rand);
        check (2'haa, "random address in");
    end
end
endmodule
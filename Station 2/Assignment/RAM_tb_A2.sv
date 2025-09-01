import RAM_pkg ::*;

module RAM_tb_A2 ();

// parameters
parameter MEM_WIDTH = 8;
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = $clog2(MEM_DEPTH);

// logic signals
logic [MEM_WIDTH-1:0] din;
logic [ADDR_SIZE-1:0] addr_wr, addr_rd;
logic wr_en, rd_en, clk, rst_n;

// output signals
logic [MEM_WIDTH-1:0] dout;
logic [MEM_WIDTH-1:0] dout_exp;
// tb signals
integer correct, wrong;


// golden model signals
bit [MEM_WIDTH-1 : 0] arr [MEM_DEPTH-1 : 0];

// instantiation
RAM DUT (.*);

// clock generation
initial begin
	clk = 0;
	forever
	#10 clk = ~clk;
end

// class object.
RAM_class cls;

//**************************************************//
// checking task
task check (
    logic [MEM_WIDTH-1:0] data,
    string message
);
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

// golden model
task golden_model(
    logic [MEM_WIDTH-1:0] din_,
    logic [ADDR_SIZE-1:0] addr_wr_, addr_rd_,
    logic wr_en_, rd_en_, rst_n_,
    output [MEM_WIDTH-1:0] dout_
);
    if (rst_n == 0)
        dout_ = {MEM_WIDTH{1'b0}};
    else if (wr_en && rd_en) begin
        arr[addr_wr] = din_;
        dout_ = arr[addr_rd];
    end
    else if (wr_en)
        arr[addr_wr] = din_;
    else if (rd_en)
        dout_ = arr[addr_rd];
endtask

//**************************************************//
// initial block
initial begin
    cls = new;
    correct = 0;
    wrong = 0;
    rst_n = 0;
    wr_en = 0;
    rd_en = 0;
    @(negedge clk);
    rst_n = 1;
    @(negedge clk);
    repeat (250) begin
        assert (cls.randomize()) else $error("Assertion failed!");
        rst_n = cls.tb_rst_n;
        wr_en = cls.tb_wr_en;
        rd_en = cls.tb_rd_en;
        din = cls.tb_din;
        addr_wr = cls.tb_addr_wr;
        addr_rd = cls.tb_addr_rd;
        @(negedge clk);
        golden_model (
            .din_(din),
            .addr_wr_(addr_wr),
            .addr_rd_(addr_rd),
            .wr_en_(wr_en),
            .rd_en_(rd_en),
            .rst_n_(rst_n),
            .dout_(dout_exp)
        );
        @(negedge clk);
        check (dout_exp , "Error in dout");
        @(negedge clk);
    end
    $stop;
end
endmodule
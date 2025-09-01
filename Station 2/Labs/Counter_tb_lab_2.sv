import counter_pkg ::*;

module counter_tb ();

parameter WIDTH = 4;
logic clk;
logic rst_n;
logic load;
logic up_down;
logic [WIDTH-1:0] data_in;
logic [WIDTH-1:0] count;

up_down_counter DUT (.*);

initial begin
	clk = 0;
	forever
	#10 clk = ~clk;
end

counter_class cls;

initial begin
    cls = new;
    load = 0;
    data_in = 0;
    repeat (100) begin
        test_down : assert (cls.randomize()) else $error("Assertion label failed!");
        data_in = cls.data_in;
        rst_n = cls.rst_n;
        load = cls.load;
        up_down = cls.up_down;
        @(negedge clk);
    end
    $stop;
end
endmodule
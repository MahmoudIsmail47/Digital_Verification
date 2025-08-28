/*
Features:
Parameterized Bit-Width (MEM_WIDTH) → Supports configurable data width for flexibility.
Parameterized Memory Depth (MEM_DEPTH) → Allows defining different memory sizes as needed.
Parameterized Address Size (ADDR_SIZE) → Automatically computed using $clog2(MEM_DEPTH), ensuring efficient address representation.
Asynchronous Active-Low Reset (rst_n) → Resets dout immediately when rst_n is low.
Synchronous Read and Write Operations:
Write (wr_en = 1) → Stores din at memory location addr_wr.
Read (rd_en = 1) → Outputs data from memory location addr_rd to dout.
Clock (clk) Controlled Operations → Read and write happen on the positive edge of clk.
Efficient Memory Implementation (mem array) → Uses reg array for scalable storage.
Scalable Design → Works with any word size and memory depth by adjusting parameters.
*/
module RAM #(
    parameter MEM_WIDTH = 8,                   // Data width
    parameter MEM_DEPTH = 256,                 // Number of memory locations
    parameter ADDR_SIZE = $clog2(MEM_DEPTH)     // Address size based on depth
)(
    input [MEM_WIDTH-1:0] din,            // Data input
    input [ADDR_SIZE-1:0] addr_wr, addr_rd, // Write & Read addresses
    input                 wr_en,         // Write enable
    input                 rd_en,         // Read enable
    input                 clk,           // Clock signal
    input                 rst_n,         // Active-low reset
    output reg [MEM_WIDTH-1:0] dout      // Data output
);

// Memory declaration
reg [MEM_WIDTH-1:0] mem [0:MEM_DEPTH-1];

// Synchronous read and write with asynchronous reset
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        dout <= {MEM_WIDTH{1'b0}};  // Reset output to 0
    end
    else begin
        if (wr_en) 
            mem[addr_wr] <= din;  // Store input data at the given address

        if (rd_en) 
            dout <= mem[addr_rd];  // Retrieve data from the specified address
    end
end

endmodule

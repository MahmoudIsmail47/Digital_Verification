/* 
Features:
Parameterized bit-width (WIDTH) for flexibility.
Asynchronous active-low reset (rst_n) to reset the counter immediately.
Synchronous Load (load) allows loading an external value into the counter.
Up/Down Control (up_down):
1 → Up counting
0 → Down counting
Clock (clk) for synchronous operation.
*/

module up_down_counter #(
    parameter WIDTH = 4  // Default bit-width is 4
)(
    input  wire              clk,      // Clock signal
    input  wire              rst_n,    // Asynchronous active-low reset
    input  wire              load,     // Synchronous load
    input  wire              up_down,  // Up/Down control (1 = Up, 0 = Down)
    input  wire [WIDTH-1:0]  data_in,  // Data to be loaded
    output reg  [WIDTH-1:0]  count     // Counter Output
);

// Asynchronous Reset
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) 
        count <= {WIDTH{1'b0}};  // Reset counter to 0
    else if (load) 
        count <= data_in;  // Load data into counter
    else if (up_down) 
        count <= count + 1;  // Increment counter
    else 
        count <= count - 1;  // Decrement counter
end

endmodule

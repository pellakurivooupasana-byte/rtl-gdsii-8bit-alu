module alu_tb;  // Test Bench Module

// Input signals
reg [7:0] a, b;
reg [3:0] s;
reg clk, en;

// Output signals
wire [15:0] y;
wire carry, zero;

// Instantiate ALU (Unit Under Test)
alu uut (
    .a(a),
    .b(b),
    .s(s),
    .en(en),
    .clk(clk),
    .y(y),
    .carry(carry),
    .zero(zero)
);

// Initialize signals
initial begin
    a   = 0;
    b   = 0;
    s   = 0;
    en  = 1;
    clk = 0;
end

// Generate clock with period = 10 time units
always begin
    clk = ~clk;
    #5;
end

// Apply test vectors
initial begin

    $display("time\t clk\t en\t a\t\t b\t\t s\t\t y\t\t\t carry\t zero");

    $monitor("%g\t %b\t %b\t %b\t %b\t %b\t %b\t %b\t %b",
             $time, clk, en, a, b, s, y, carry, zero);

    #50;

    // Input values
    a = 8'b11101110;
    b = 8'b11101110;

    #29;

    // Test different ALU operations

    s = 4'b0001; #30;  // Subtraction
    s = 4'b0010; #30;  // Increment

    en = 0;            // Enable ALU

    s = 4'b0001; #30;  // Subtraction
    s = 4'b0010; #30;  // Increment
    s = 4'b0011; #30;  // Decrement
    s = 4'b0100; #30;  // Multiplication
    s = 4'b0101; #30;  // Division
    s = 4'b0110; #30;  // AND
    s = 4'b0111; #30;  // OR
    s = 4'b1000; #30;  // XOR
    s = 4'b1001; #30;  // NAND
    s = 4'b1010; #30;  // NOR
    s = 4'b1011; #30;  // XNOR
    s = 4'b1100; #30;  // Left Shift
    s = 4'b1101; #30;  // Right Shift
    s = 4'b1110; #30;  // Right Rotate
    s = 4'b1111; #30;  // Left Rotate

    #10;
    $finish;

end



endmodule

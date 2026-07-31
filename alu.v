module alu (
    input clk, en,             
    input [7:0] a, b,           // 8-bit inputs
    input [3:0] s,              // Select line
    output reg [15:0] y,        // 16-bit output
    output reg carry, zero      // Flags
);

reg [7:0] a_in, b_in;          // Internal input registers
reg [1:0] flags;               // flags[0]=carry, flags[1]=zero
reg [15:0] out_y;              // Internal output register

initial begin
    y = 0;
    carry = 0;
    zero = 0;
end

// Datapath Design
always @(posedge clk, posedge en) begin
    if (en) begin
        a_in <= 0;
        b_in <= 0;
        y <= 0;
        carry <= 0;
        zero <= 0;
    end
    else begin
        a_in <= a;
        b_in <= b;
        y <= out_y;
        carry <= flags[0];
        zero <= flags[1];
    end
end

// Controller Design
always @(a_in, b_in, s) begin
    flags = 2'b00;

    case (s)

        // Addition
        4'd0: begin
            out_y = {8'd0, (a_in + b_in)};
            flags[0] = out_y[8];
        end

        // Subtraction
        4'd1: begin
            out_y = {8'd0, (a_in - b_in)};
            flags[0] = out_y[8];
        end

        // Increment
        4'd2: begin
            out_y = {8'd0, (a_in + 1'b1)};
            flags[0] = out_y[8];
        end

        // Decrement
        4'd3: begin
            out_y = {8'd0, (a_in - 1'b1)};
            flags[0] = out_y[8];
        end

        // Multiplication
        4'd4: begin
            out_y = (a_in * b_in);
        end

        // Division
        4'd5: begin
            out_y = (a_in / b_in);
        end

        // AND
        4'd6: begin
            out_y = {8'd0, (a_in & b_in)};
        end

        // OR
        4'd7: begin
            out_y = {8'd0, (a_in | b_in)};
        end

        // XOR
        4'd8: begin
            out_y = {8'd0, (a_in ^ b_in)};
        end

        // NAND
        4'd9: begin
            out_y = {8'd0, ~(a_in & b_in)};
        end

        // NOR
        4'd10: begin
            out_y = {8'd0, ~(a_in | b_in)};
        end

        // XNOR
        4'd11: begin
            out_y = {8'd0, ~(a_in ^ b_in)};
        end

        // Left Shift
        4'd12: begin
            flags[0] = a_in[7];
            out_y = {8'd0, (a_in << 1)};
        end

        // Right Shift
        4'd13: begin
            flags[0] = a_in[0];
            out_y = {8'd0, (a_in >> 1)};
        end

        // Right Rotate
        4'd14: begin
            out_y = {8'd0, a_in[0], a_in[7:1]};
        end

        // Left Rotate
        4'd15: begin
            out_y = {8'd0, a_in[6:0], a_in[7]};
        end

        default: begin
            out_y = 16'd0;
        end

    endcase

    // Zero Flag
    if (!out_y)
        flags[1] = 1'b1;
end

endmodule

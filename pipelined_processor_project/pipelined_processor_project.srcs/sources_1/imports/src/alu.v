`timescale 1ns / 1ps

module alu (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [1:0] alu_ctrl,
    output reg  [7:0] result,
    output wire       zero
);

    always @(*) begin
        case (alu_ctrl)
            2'b00: result = a + b;        // ADD
            2'b01: result = a - b;        // SUB
            2'b10: result = a & b;        // AND
            2'b11: result = a << b[2:0];  // SLL (shift left)
            default: result = 8'b0;
        endcase
    end

    assign zero = (result == 8'b0);

endmodule

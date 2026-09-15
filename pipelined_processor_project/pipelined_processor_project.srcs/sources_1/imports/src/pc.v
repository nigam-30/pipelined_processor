`timescale 1ns / 1ps

module pc (
    input  wire       clk,
    input  wire       rst,
    input  wire       stall,
    input  wire       halt,
    output reg  [7:0] pc_out
);
    always @(posedge clk) begin
        if (rst)
            pc_out <= 8'b0;
        else if (halt)
            pc_out <= pc_out;        // freeze on halt
        else if (!stall)
            pc_out <= pc_out + 1;
    end
endmodule
`timescale 1ns / 1ps

module if_id_reg (
    input  wire       clk,
    input  wire       rst,
    input  wire       stall,     // hold current value
    input  wire       flush,     // insert bubble (NOP)
    input  wire [7:0] pc_in,
    input  wire [7:0] instr_in,
    output reg  [7:0] pc_out,
    output reg  [7:0] instr_out
);

    always @(posedge clk) begin
        if (rst || flush) begin
            pc_out    <= 8'b0;
            instr_out <= 8'b0;       // NOP = all zeros
        end
        else if (!stall) begin
            pc_out    <= pc_in;
            instr_out <= instr_in;
        end
        // else: hold (do nothing)
    end

endmodule

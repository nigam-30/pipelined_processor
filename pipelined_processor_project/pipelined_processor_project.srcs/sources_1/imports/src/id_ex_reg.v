`timescale 1ns / 1ps

module id_ex_reg (
    input  wire       clk,
    input  wire       rst,
    input  wire       flush,        // bubble insert
    // Data inputs
    input  wire [7:0] read_data1_in,
    input  wire [7:0] read_data2_in,
    input  wire [2:0] rd_in,
    input  wire [2:0] imm_in,
    // Control inputs
    input  wire       reg_write_in,
    input  wire       alu_src_in,
    input  wire [1:0] alu_ctrl_in,
    input  wire       halt_in,
    // Data outputs
    output reg  [7:0] read_data1_out,
    output reg  [7:0] read_data2_out,
    output reg  [2:0] rd_out,
    output reg  [2:0] imm_out,
    // Control outputs
    output reg        reg_write_out,
    output reg        alu_src_out,
    output reg  [1:0] alu_ctrl_out,
    output reg        halt_out
);

    always @(posedge clk) begin
        if (rst || flush) begin
            read_data1_out <= 8'b0;
            read_data2_out <= 8'b0;
            rd_out         <= 3'b0;
            imm_out        <= 3'b0;
            reg_write_out  <= 1'b0;
            alu_src_out    <= 1'b0;
            alu_ctrl_out   <= 2'b0;
            halt_out       <= 1'b0;
        end
        else begin
            read_data1_out <= read_data1_in;
            read_data2_out <= read_data2_in;
            rd_out         <= rd_in;
            imm_out        <= imm_in;
            reg_write_out  <= reg_write_in;
            alu_src_out    <= alu_src_in;
            alu_ctrl_out   <= alu_ctrl_in;
            halt_out       <= halt_in;
        end
    end

endmodule

`timescale 1ns / 1ps

module control (
    input  wire [7:0] instr,
    output reg        reg_write,
    output reg        alu_src,      // 0 = register, 1 = immediate
    output reg  [1:0] alu_ctrl,
    output reg        halt,
    output reg  [2:0] rd,
    output reg  [2:0] rs,
    output reg  [2:0] imm
);

    wire [1:0] opcode = instr[7:6];

    always @(*) begin
        // Default values
        reg_write = 1'b0;
        alu_src   = 1'b0;
        alu_ctrl  = 2'b00;
        halt      = 1'b0;
        rd        = instr[5:3];
        rs        = instr[2:0];
        imm       = instr[2:0];

        if (instr == 8'b11111111) begin
            halt = 1'b1;
        end
        else begin
            case (opcode)
                2'b00: begin  // ADD
                    reg_write = 1'b1;
                    alu_src   = 1'b0;
                    alu_ctrl  = 2'b00;
                end
                2'b01: begin  // ADDI
                    reg_write = 1'b1;
                    alu_src   = 1'b1;
                    alu_ctrl  = 2'b00;
                end
                2'b10: begin  // SUB
                    reg_write = 1'b1;
                    alu_src   = 1'b0;
                    alu_ctrl  = 2'b01;
                end
                2'b11: begin  // SLL
                    reg_write = 1'b1;
                    alu_src   = 1'b1;   // shift amount = immediate
                    alu_ctrl  = 2'b11;
                end
            endcase
        end
    end

endmodule

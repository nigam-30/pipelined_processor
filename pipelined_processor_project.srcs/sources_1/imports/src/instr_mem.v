`timescale 1ns / 1ps

module instr_mem (
    input  wire [7:0] addr,
    output wire [7:0] instr
);

    reg [7:0] memory [0:15];
    integer i;

    initial begin
        // Saare memory locations ko 0 se initialize karo (optional)
        for (i = 0; i < 16; i = i + 1)
            memory[i] = 8'b0;

        // Test program
        // Format: [7:6] opcode | [5:3] Rd | [2:0] Rs/Imm
        // Opcodes: 00=ADD, 01=ADDI, 10=SUB, 11=SLL, 11111111=HALT

        memory[0]  = 8'b01_001_011;  // ADDI R1, 3    -> R1 = 0 + 3 = 3
        memory[1]  = 8'b01_010_101;  // ADDI R2, 5    -> R2 = 0 + 5 = 5
        memory[2]  = 8'b00_001_010;  // ADD  R1, R2   -> R1 = 3 + 5 = 8
        memory[3]  = 8'b10_010_001;  // SUB  R2, R1   -> R2 = 5 - 8 = FD
        memory[4]  = 8'b11_011_010;  // SLL  R3, 2    -> R3 = 0 << 2 = 0
        memory[5]  = 8'b01_011_111;  // ADDI R3, 7    -> R3 = 0 + 7 = 7
        memory[6]  = 8'b11_011_001;  // SLL  R3, 1    -> R3 = 7 << 1 = 14
        memory[7]  = 8'b00_100_001;  // ADD  R4, R1   -> R4 = 0 + 8 = 8
        memory[8]  = 8'b01_100_010;  // ADDI R4, 2    -> R4 = 8 + 2 = 10
        memory[9]  = 8'b10_101_100;  // SUB  R5, R4   -> R5 = 0 - 10 = F6
        memory[10] = 8'b00_101_011;  // ADD  R5, R3   -> R5 = F6 + 14 = 04
        memory[11] = 8'b01_110_001;  // ADDI R6, 1    -> R6 = 0 + 1 = 1
        memory[12] = 8'b11_110_011;  // SLL  R6, 3    -> R6 = 1 << 3 = 8
        memory[13] = 8'b00_110_001;  // ADD  R6, R1   -> R6 = 8 + 8 = 10
        memory[14] = 8'b01_111_111;  // ADDI R7, 7    -> R7 = 0 + 7 = 7
        memory[15] = 8'b11111111;    // HALT
    end

    assign instr = memory[addr[3:0]];

endmodule
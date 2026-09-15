`timescale 1ns / 1ps

module reg_file (
    input  wire       clk,
    input  wire       rst,
    input  wire       reg_write,
    input  wire [2:0] rs1,       // read address 1
    input  wire [2:0] rs2,       // read address 2
    input  wire [2:0] rd,        // write address
    input  wire [7:0] write_data,
    output wire [7:0] read_data1,
    output wire [7:0] read_data2
);

    reg [7:0] registers [0:7];
    integer i;

    // Write operation (synchronous)
    always @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < 8; i = i + 1)
                registers[i] <= 8'b0;
        end
        else if (reg_write && rd != 3'b000) begin
            registers[rd] <= write_data;   // R0 is hardwired to 0
        end
    end

    // Read operation (asynchronous)
    assign read_data1 = (rs1 == 3'b000) ? 8'b0 : registers[rs1];
    assign read_data2 = (rs2 == 3'b000) ? 8'b0 : registers[rs2];

endmodule

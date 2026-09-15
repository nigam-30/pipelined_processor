`timescale 1ns / 1ps

module top (
    input  wire       clk,
    input  wire       rst,
    output wire [7:0] led,
    output wire       halt_flag
);

    // IF Stage Signals
    wire [7:0] pc_current;
    wire [7:0] if_instr;
    wire       stall;
    wire       halt_if;

    // IF/ID Pipeline Register Outputs
    wire [7:0] id_pc;
    wire [7:0] id_instr;

    // ID Stage Signals
    wire [7:0] id_read_data1;
    wire [7:0] id_read_data2;
    wire [2:0] id_rd;
    wire [2:0] id_rs;
    wire [2:0] id_imm;
    wire       id_reg_write;
    wire       id_alu_src;
    wire [1:0] id_alu_ctrl;
    wire       id_halt;

    // ID/EX Pipeline Register Outputs
    wire [7:0] ex_read_data1;
    wire [7:0] ex_read_data2;
    wire [2:0] ex_rd;
    wire [2:0] ex_imm;
    wire       ex_reg_write;
    wire       ex_alu_src;
    wire [1:0] ex_alu_ctrl;
    wire       ex_halt;

    // EX Stage Signals
    wire [7:0] ex_alu_a;
    wire [7:0] ex_alu_b;
    wire [7:0] ex_alu_result;
    wire       ex_zero;

    // Hazard + Halt logic
    wire flush_halt  = ex_halt;
    wire stall_raw   = ex_reg_write && (ex_rd != 3'b000) && (ex_rd == id_rs);
    wire stall_final = stall_raw & ~flush_halt;

    // IF Stage
    pc pc_inst (
        .clk    (clk),
        .rst    (rst),
        .stall  (stall_final),
        .halt   (halt_if),
        .pc_out (pc_current)
    );

    instr_mem imem_inst (
        .addr  (pc_current),
        .instr (if_instr)
    );

    // IF/ID Pipeline Register
    if_id_reg if_id_inst (
        .clk       (clk),
        .rst       (rst),
        .stall     (stall_final),
        .flush     (flush_halt),
        .pc_in     (pc_current),
        .instr_in  (if_instr),
        .pc_out    (id_pc),
        .instr_out (id_instr)
    );

    // ID Stage
    control ctrl_inst (
        .instr     (id_instr),
        .reg_write (id_reg_write),
        .alu_src   (id_alu_src),
        .alu_ctrl  (id_alu_ctrl),
        .halt      (id_halt),
        .rd        (id_rd),
        .rs        (id_rs),
        .imm       (id_imm)
    );

    reg_file rf_inst (
        .clk        (clk),
        .rst        (rst),
        .reg_write  (ex_reg_write),
        .rs1        (id_rd),          // FIXED: Rd is first operand
        .rs2        (id_rs),          // FIXED: Rs is second operand
        .rd         (ex_rd),
        .write_data (ex_alu_result),
        .read_data1 (id_read_data1),
        .read_data2 (id_read_data2)
    );

    // ID/EX Pipeline Register
    id_ex_reg id_ex_inst (
        .clk              (clk),
        .rst              (rst),
        .flush            (flush_halt),
        .read_data1_in    (id_read_data1),
        .read_data2_in    (id_read_data2),
        .rd_in            (id_rd),
        .imm_in           (id_imm),
        .reg_write_in     (id_reg_write),
        .alu_src_in       (id_alu_src),
        .alu_ctrl_in      (id_alu_ctrl),
        .halt_in          (id_halt),
        .read_data1_out   (ex_read_data1),
        .read_data2_out   (ex_read_data2),
        .rd_out           (ex_rd),
        .imm_out          (ex_imm),
        .reg_write_out    (ex_reg_write),
        .alu_src_out      (ex_alu_src),
        .alu_ctrl_out     (ex_alu_ctrl),
        .halt_out         (ex_halt)
    );

    // EX Stage
    assign ex_alu_a = ex_read_data1;
    assign ex_alu_b = (ex_alu_src) ? {5'b0, ex_imm} : ex_read_data2;

    alu alu_inst (
        .a        (ex_alu_a),
        .b        (ex_alu_b),
        .alu_ctrl (ex_alu_ctrl),
        .result   (ex_alu_result),
        .zero     (ex_zero)
    );

      // Outputs
    // LED output - last valid ALU result hold karo
    reg [7:0] led_reg;
    always @(posedge clk) begin
        if (rst)
            led_reg <= 8'b0;
        else if (ex_reg_write && ex_rd != 3'b000)
            led_reg <= ex_alu_result;
    end

    assign led = led_reg;

    // ============================================================
    // Halt flag - latch karo taaki stable rahe
    // ============================================================
    reg halt_latched;
    always @(posedge clk) begin
        if (rst)
            halt_latched <= 1'b0;
        else if (ex_halt)
            halt_latched <= 1'b1;
    end

    assign halt_flag = halt_latched;

    // Halt signal PC ko freeze karne ke liye
    assign halt_if = ex_halt;

endmodule
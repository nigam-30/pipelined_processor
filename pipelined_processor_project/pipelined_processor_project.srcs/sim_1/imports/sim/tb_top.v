`timescale 1ns / 1ps

module tb_top;

    reg        clk;
    reg        rst;
    wire [7:0] led;
    wire       halt_flag;

    // Instantiate top
    top uut (
        .clk       (clk),
        .rst       (rst),
        .led       (led),
        .halt_flag (halt_flag)
    );

    // Clock generation: 10ns period = 100 MHz
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin
        // Initialize
        rst = 1;
        #20;
        rst = 0;

        // Run for enough cycles to see pipeline
        #500;

        $display("========================================");
        $display("Simulation Complete");
        $display("Final LED output: %b", led);
        $display("Halt flag: %b", halt_flag);
        $display("========================================");

        $finish;
    end

    // Monitor pipeline activity
    initial begin
        $monitor("Time=%0t | PC=%d | ID_Instr=%b | EX_Result=%d | LED=%b | Halt=%b",
                 $time,
                 uut.pc_current,
                 uut.id_instr,
                 uut.ex_alu_result,
                 led,
                 halt_flag);
    end

endmodule

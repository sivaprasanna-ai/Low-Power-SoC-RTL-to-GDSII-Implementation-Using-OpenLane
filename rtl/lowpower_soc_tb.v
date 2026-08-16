`timescale 1ns/1ps

module lowpower_soc_tb;

    reg        clk;
    reg        reset;
    reg        sleep;

    wire [7:0] gpio_out;
    wire       timer_done;

    // DUT
    lowpower_soc dut (
        .clk       (clk),
        .reset     (reset),
        .sleep     (sleep),
        .gpio_out  (gpio_out),
        .timer_done(timer_done)
    );

    // 10 ns clock period = 100 MHz
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Test sequence
    initial begin

        // Initialize inputs
        reset = 1'b1;
        sleep = 1'b0;

        // Generate waveform
        $dumpfile("lowpower_soc.vcd");
        $dumpvars(0, lowpower_soc_tb);

        // Hold reset for 20 ns
        #20;
        reset = 1'b0;

        // Normal operation
        #500;

        // Enter sleep mode
        sleep = 1'b1;

        #200;

        // Wake up
        sleep = 1'b0;

        #500;

        // Reset once more
        reset = 1'b1;
        #20;
        reset = 1'b0;

        // Continue operation
        #300;

        $display("Simulation completed successfully.");
        $finish;
    end

endmodule

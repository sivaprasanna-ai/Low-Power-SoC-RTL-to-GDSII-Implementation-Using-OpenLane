module simple_cpu (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,

    input  wire [7:0] mem_rdata,

    output reg  [7:0] mem_address,
    output reg        mem_write,
    output reg  [7:0] mem_wdata,

    output reg  [7:0] gpio_data,
    output reg        gpio_write
);

    reg [7:0] program_counter;

    always @(posedge clk) begin

        if (reset) begin

            program_counter <= 8'h00;

            mem_address     <= 8'h00;
            mem_write       <= 1'b0;
            mem_wdata       <= 8'h00;

            gpio_data       <= 8'h00;
            gpio_write      <= 1'b0;

        end
        else if (enable) begin

            program_counter <= program_counter + 8'h01;

            /*
             * Generate deterministic memory activity.
             */
            mem_address <= program_counter;

            if (program_counter[3:0] == 4'h4) begin
                mem_write <= 1'b1;
                mem_wdata <= program_counter;
            end
            else begin
                mem_write <= 1'b0;
                mem_wdata <= 8'h00;
            end

            /*
             * Generate deterministic GPIO activity.
             */
            if (program_counter[2:0] == 3'b000) begin
                gpio_write <= 1'b1;
                gpio_data  <= program_counter;
            end
            else begin
                gpio_write <= 1'b0;
            end

        end
        else begin

            /*
             * Sleep mode:
             * CPU state remains unchanged.
             */
            mem_write  <= 1'b0;
            gpio_write <= 1'b0;

        end

    end

endmodule

module gpio_interface (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,

    input  wire       write_enable,
    input  wire [7:0] write_data,

    output reg  [7:0] gpio_out
);

    always @(posedge clk) begin

        if (reset) begin

            gpio_out <= 8'h00;

        end
        else if (enable) begin

            if (write_enable) begin
                gpio_out <= write_data;
            end

        end

    end

endmodule

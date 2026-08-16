module simple_ram (
    input  wire       clk,
    input  wire       reset,
    input  wire       enable,

    input  wire [7:0] address,
    input  wire       write_enable,
    input  wire [7:0] write_data,

    output reg  [7:0] read_data
);

    reg [7:0] memory [0:255];

    integer i;

    always @(posedge clk) begin

        if (reset) begin

            for (i = 0; i < 256; i = i + 1) begin
                memory[i] = 8'h00;
            end

            read_data <= 8'h00;

        end
        else if (enable) begin

            if (write_enable) begin
                memory[address] <= write_data;
            end

            read_data <= memory[address];

        end
        else begin

            /*
             * Hold RAM state during sleep.
             */
            read_data <= memory[address];

        end

    end

endmodule

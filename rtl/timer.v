module timer (
    input  wire clk,
    input  wire reset,
    input  wire enable,

    output reg  timer_done
);

    reg [4:0] counter;

    always @(posedge clk) begin

        if (reset) begin

            counter    <= 5'd0;
            timer_done <= 1'b0;

        end
        else if (enable) begin

            if (counter == 5'd31) begin

                counter    <= 5'd0;
                timer_done <= 1'b1;

            end
            else begin

                counter    <= counter + 5'd1;
                timer_done <= 1'b0;

            end

        end
        else begin

            /*
             * Sleep mode:
             * timer stops counting.
             */
            timer_done <= 1'b0;

        end

    end

endmodule

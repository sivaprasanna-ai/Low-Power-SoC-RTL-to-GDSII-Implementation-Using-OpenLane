module lowpower_soc (
    input  wire       clk,
    input  wire       reset,
    input  wire       sleep,

    output wire [7:0] gpio_out,
    output wire       timer_done
);

    wire system_enable;

    wire [7:0] cpu_address;
    wire       cpu_mem_write;
    wire [7:0] cpu_mem_wdata;
    wire [7:0] cpu_mem_rdata;

    wire [7:0] cpu_gpio_data;
    wire       cpu_gpio_write;

    assign system_enable = ~sleep;

    simple_cpu u_cpu (
        .clk          (clk),
        .reset        (reset),
        .enable       (system_enable),

        .mem_rdata    (cpu_mem_rdata),
        .mem_address  (cpu_address),
        .mem_write    (cpu_mem_write),
        .mem_wdata    (cpu_mem_wdata),

        .gpio_data    (cpu_gpio_data),
        .gpio_write   (cpu_gpio_write)
    );

    simple_ram u_ram (
        .clk          (clk),
        .reset        (reset),
        .enable       (system_enable),

        .address      (cpu_address),
        .write_enable (cpu_mem_write),
        .write_data   (cpu_mem_wdata),
        .read_data    (cpu_mem_rdata)
    );

    gpio_interface u_gpio (
        .clk          (clk),
        .reset        (reset),
        .enable       (system_enable),

        .write_enable (cpu_gpio_write),
        .write_data   (cpu_gpio_data),

        .gpio_out     (gpio_out)
    );

    timer u_timer (
        .clk          (clk),
        .reset        (reset),
        .enable       (system_enable),

        .timer_done   (timer_done)
    );

endmodule

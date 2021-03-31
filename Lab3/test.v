`timescale 1ns / 1ps

module test;

reg reset_reg, clk_reg;
wire clk, reset;
reg [7:0] a;
reg [7:0] b;
wire busy;
wire [7:0] y_bo;
reg [15:0] sw_i;

accelerator accelerator_1(
    .clk_i(clk_reg),
    .rst_i(reset),
    .sw_i(sw_i),
    // .start_i(start_reg),
    .busy_out(busy),
    .y_out(y_bo)
); // */

/* mult mult_1(
    .clk_i(clk_reg),
    .rst_i(reset),
    .a_bi(a),
    .b_bi(b),
    .busy_o(busy),
    .y_bo(y_bo)
); // */

assign reset = reset_reg;
assign clk = clk_reg;

initial begin
    clk_reg = 1;
    forever
        #10 clk_reg = ~clk_reg;
end

initial begin
    a <= 0;
    b <= 0;
    sw_i <= 0;
    reset_reg <= 1;
end

always @(posedge clk_reg) begin
    if (reset_reg) begin
        reset_reg = 0;
    end
    
    if (!busy) begin
        $display("floor sqrt ( %d + floor cbrt  %d ) = %d", a, b, y_bo);
        if (!reset_reg) begin
            a = a + 1;
            b = b + 15;
            sw_i[15:8] <= a;
            sw_i[7:0] <= b;
            reset_reg <= 1;
        end
    end
end

endmodule

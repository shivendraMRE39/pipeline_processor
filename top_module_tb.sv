`timescale 1ns / 1ps

module top_module_tb;

    logic clk, rst;

    top_module_pipeline dut (
        .clk(clk),
        .rst(rst)
    );

    // clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;

        // hold reset for some cycles
        #20;
        rst = 0;

        // run simulation
        #300;

        $finish;
    end



endmodule
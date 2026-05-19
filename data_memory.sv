
`timescale 1ns / 1ps

module data_memory #(
    parameter WIDTH = 32,
    parameter DEPTH = 1024
)(
    input  logic clk,
    input  logic WE,
    input  logic [31:0] A,
    input  logic [31:0] WD,
    output logic [31:0] RD
);

    // Memory declaration
    logic [WIDTH-1:0] datamem [0:DEPTH-1];

    // READ (combinational)
    assign RD = datamem[A[31:2]];

    // WRITE (synchronous)
    always_ff @(posedge clk) begin
        if (WE)
            datamem[A[31:2]] <= WD;
    end

    // INITIALIZATION (avoid X values)
    integer i;
    initial begin
        // Initialize all memory to 0
        for (i = 0; i < DEPTH; i = i + 1)
            datamem[i] = 32'd0;

        // Example data (word aligned)
        datamem[0] = 32'h00000011; // address 0
        datamem[1] = 32'h00000022; // address 4
        datamem[2] = 32'h00000033; // address 8
        datamem[3] = 32'h00000044; // address 12
        datamem[4] = 32'h030201FE; // address 16 (your case)
    end

endmodule
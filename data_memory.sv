
//`timescale 1ns / 1ps

//module data_memory #(
//    parameter WIDTH = 32,
//    parameter DEPTH = 1024
//)(
//    input  logic clk,
//    input  logic WE,
//    input  logic [31:0] A,
//    input  logic [31:0] WD,
//    output logic [31:0] RD
//);

//    // Memory declaration
//    logic [WIDTH-1:0] datamem [0:DEPTH-1];

//    // READ (combinational)
//    assign RD = datamem[A[31:2]];

//    // WRITE (synchronous)
//    always_ff @(posedge clk) begin
//        if (WE)
//            datamem[A[31:2]] <= WD;
//    end

//    // INITIALIZATION (avoid X values)
//    integer i;
//    initial begin
//        // Initialize all memory to 0
//        for (i = 0; i < DEPTH; i = i + 1)
//            datamem[i] = 32'd0;

       
//        datamem[50] = 32'd100; 
//    end

//endmodule


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

    
    assign RD = datamem[A[31:2]];

    always_ff @(posedge clk) begin
        if (WE)
            datamem[A[31:2]] <= WD;
    end

   
    integer i;

    initial begin

        // Default all memory to zero
        for (i = 0; i < DEPTH; i = i + 1)
            datamem[i] = 32'd0;

//        datamem[0]  = 32'd10;
//        datamem[1]  = 32'd20;
//        datamem[2]  = 32'd30;
//        datamem[3]  = 32'd40;
//        datamem[4]  = 32'd50;
//        datamem[5]  = 32'd60;
//        datamem[6]  = 32'd70;
//        datamem[7]  = 32'd80;
//        datamem[8]  = 32'd90;
//        datamem[9]  = 32'd100;

//        datamem[10] = 32'hAAAAAAAA;
//        datamem[11] = 32'hBBBBBBBB;
//        datamem[12] = 32'hCCCCCCCC;
//        datamem[13] = 32'hDDDDDDDD;

//        datamem[14] = 32'h12345678;
//        datamem[15] = 32'h87654321;

//        datamem[16] = 32'd1111;
//        datamem[17] = 32'd2222;
//        datamem[18] = 32'd3333;
//        datamem[19] = 32'd4444;

//        datamem[20] = 32'h0000FFFF;
//        datamem[21] = 32'hFFFF0000;

//        datamem[22] = 32'd5555;
//        datamem[23] = 32'd6666;
//        datamem[24] = 32'd7777;
//        datamem[25] = 32'd8888;

        
//        datamem[30] = 32'd7;    
//        datamem[31] = 32'd15;   
//        datamem[32] = 32'd12;   

        
//        datamem[40] = 32'd1000;
//        datamem[41] = 32'd2000;
//        datamem[42] = 32'd3000;
//        datamem[43] = 32'd4000;

        
//        datamem[50] = 32'd100;

    end

endmodule
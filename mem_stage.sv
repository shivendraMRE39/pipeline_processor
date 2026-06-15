`timescale 1ns / 1ps


module mem_stage(
input logic clk, rst,
input logic RegWriteM,
input logic [1:0] ResultSrcM,
input logic  MemWriteM,
input logic [31:0] ALUResultM,
input logic [31:0] WriteDataM,
input logic [4:0] RdM,
input logic [31:0] PCPlus4M,
input logic [2:0] LoadTypeM,
input logic [2:0] StoreTypeM,
output logic RegWriteW,
output logic [1:0] ResultSrcW,
output logic [31:0] ReadDataW,
output logic [31:0] ALUResultW,
output logic [4:0] RdW,
output logic [31:0] PCPlus4W
    );
   
   logic [31:0] read;
;
   
   logic [31:0] LoadData;
   
   logic [31:0] StoreData;
   
   logic [3:0] ByteEnable;

logic LoadMisaligned;
logic StoreMisaligned;
   
  
    //datamemory instantiation 
     data_memory  data_memory(
     .clk(clk),
     .A(ALUResultM),
     .WD(StoreData),
     .WE(MemWriteM),
     .BE(ByteEnable),
     .RD(read));
     
     always_ff@(posedge clk)
     begin 
     if(rst)
     begin 
     RegWriteW <= 1'b0;
     ResultSrcW <= 2'b0;
     ReadDataW <= 32'b0;
     RdW       <= 5'b0;
     PCPlus4W  <= 32'b0;
     ALUResultW <= 32'b0;
    
    
     end 
     
     else 
     begin 
     RegWriteW  <= RegWriteM;
     ResultSrcW <= ResultSrcM;
     ALUResultW <= ALUResultM;
     ReadDataW  <= LoadData;
     RdW        <= RdM;
     PCPlus4W   <= PCPlus4M;
     end
     end 
     

    
   LSU lsu(
    .Addr(ALUResultM),
    .WriteData(WriteDataM),
    .ReadData(read),

    .LoadType(LoadTypeM),
    .StoreType(StoreTypeM),

    .StoreData(StoreData),
    .LoadData(LoadData),
    .ByteEnable(ByteEnable),

    .LoadMisaligned(LoadMisaligned),
    .StoreMisaligned(StoreMisaligned)
); 
endmodule
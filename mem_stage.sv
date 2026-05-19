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
   logic [7:0]  byte_data;
   logic [15:0] half_data;
   
   logic [31:0] lb_result, lh_result;
   logic [31:0] lbu_result, lhu_result;
   
   logic [31:0] LoadData;
   
   logic [31:0] StoreData;
   
   
   //storetype instruction
  always_comb begin
    StoreData = read;   // start with OLD memory value

    case (StoreTypeM)

        3'b000: begin // SB
            case (ALUResultM[1:0])
                2'b00: StoreData[7:0]   = WriteDataM[7:0];
                2'b01: StoreData[15:8]  = WriteDataM[7:0];
                2'b10: StoreData[23:16] = WriteDataM[7:0];
                2'b11: StoreData[31:24] = WriteDataM[7:0];
            endcase
        end

        3'b001: begin // SH
            case (ALUResultM[1])
                1'b0: StoreData[15:0]  = WriteDataM[15:0];
                1'b1: StoreData[31:16] = WriteDataM[15:0];
            endcase
        end

        3'b010: begin // SW
            StoreData = WriteDataM;
        end

        default: StoreData = read;
    endcase
end
    //datamemory instantiation 
     data_memory  data_memory(
     .clk(clk),
     
     .A(ALUResultM),
     .WD(StoreData),
     .WE(MemWriteM),
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
     
     // Byte Selection (LB, LBU)
     
     always_comb begin
     byte_data = 8'b0;  // default
    case (ALUResultM[1:0])
        2'b00: byte_data = read[7:0];
        2'b01: byte_data = read[15:8];
        2'b10: byte_data = read[23:16];
        2'b11: byte_data = read[31:24];
    endcase
end

     // Half Word Selection (LH, LHU)
     
     always_comb begin
      half_data = 16'b0;  // default
    case (ALUResultM[1])
        1'b0: half_data = read[15:0];
        1'b1: half_data = read[31:16];
    endcase
end

    // Extension Logic
    
    assign lb_result  = {{24{byte_data[7]}}, byte_data};   // sign extend
    assign lh_result  = {{16{half_data[15]}}, half_data}; // sign extend

    assign lbu_result = {24'b0, byte_data};               // zero extend
    assign lhu_result = {16'b0, half_data};               // zero extend
       
      // Final Load Selector 
      
      always_comb begin
       LoadData = read;  // default LW behavior
    case (LoadTypeM)
        3'b000: LoadData = lb_result;    // LB
        3'b001: LoadData = lh_result;    // LH
        3'b010: LoadData = read;         // LW
        3'b011: LoadData = lbu_result;   // LBU
        3'b100: LoadData = lhu_result;   // LHU
        default: LoadData = read;
    endcase
end
    
    
endmodule

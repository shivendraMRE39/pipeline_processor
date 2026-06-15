`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2026 03:20:45 AM
// Design Name: 
// Module Name: mux_for_Writeback
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_for_Writeback(
input logic clk,rst,
input logic RegWriteW,
input logic [4:0] RdW,
input logic [1:0] ResultSrcW,
input logic [31:0] ALUResultW,
input logic [31:0] ReadDataW,
input logic [31:0] PCPlus4W,
output logic [31:0] ResultW,
output logic RegWriteW_out,
output logic [4:0] RdW_out
 );
  
  mux_3_1 mux4_1 (
   .A(ALUResultW),
   .B(ReadDataW),
   .C(PCPlus4W),
   .sel(ResultSrcW),
   .Y(ResultW));
   
//   always_ff@(posedge clk)
////   begin
//   if(rst)begin 
//   RegWriteW_out <= 0;
//   RdW_out <= 0;
//   end 
//   else begin 
//   RegWriteW_out <= RegWriteW;
//   RdW_out <= RdW;
//    end
//    end 

//    assign RegWriteW_out = RegWriteW;
//    assign RdW_out = RdW;

assign RdW_out = (rst) ? 5'b0 : RdW;
assign RegWriteW_out = (rst) ? 1'b0 : RegWriteW;
//always_ff @(posedge clk) begin
//  if (rst) begin
//    RegWriteW_out <= 0;
//    RdW_out <= 0;
//  end else begin
//    RegWriteW_out <= RegWriteW;
//    RdW_out <= RdW;
//  end
//end
endmodule
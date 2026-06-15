`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
module execute_stage(
input logic clk, rst,
input logic RegWriteE,
input logic [1:0] ResultSrcE,
input logic MemWriteE,
input logic JumpE,
input logic BranchE,
input logic [3:0] ALUcontrolE,
input logic ALUSrcE,
input logic [31:0] RD1E,
input logic [31:0] RD2E,
input logic [31:0] PCE,
input logic [4:0] RdE,
input logic [31:0] ImmExtE,
input logic [31:0] PCPlus4E,
input logic [1:0] ForwardAE, 
input logic [1:0] ForwardBE,
input logic [4:0] Rs1E,
input logic [4:0] Rs2E,
input  logic [31:0] ResultW,
input logic [2:0] LoadTypeE,
input logic [2:0] StoreTypeE,
input logic [2:0] BranchTypeE,

output logic RegWriteM,
output logic [1:0] ResultSrcM,
output logic MemWriteM, 
output logic [31:0] ALUResultM,
output logic [31:0] WriteDataM,
output logic [4:0] RdM,
output logic [31:0] PCPlus4M,
output logic PCSrcE,
output logic [31:0] PCTargetE,
output logic [4:0] Rs1E_out,
output logic [4:0] Rs2E_out,
output logic [4:0] RdE_H,
output logic [1:0]  ResultSrcE_H,
output logic [2:0] LoadTypeM,
output logic [2:0] StoreTypeM
);
    
    
    logic [31:0] ALUout;
//    logic ZeroE;
    logic [31:0] SrcBE;
    
//    logic Isq;
    logic [31:0] WriteDataE;
    logic [31:0] SrcAE;

    logic take_branch;

//Branch_logics 

//always_comb begin
//  take_branch = 1'b0;   //  default 
//if (BranchE) begin
//    case (BranchTypeE)
//        3'b000: take_branch = (SrcAE == WriteDataE);       //beq
//        3'b001: take_branch = (SrcAE != WriteDataE);       // bne
//        3'b010: take_branch = ($signed(SrcAE) < $signed(WriteDataE));     //blt
//        3'b011: take_branch = ($signed(SrcAE) >= $signed(WriteDataE));    // bge
//        3'b100: take_branch = (SrcAE < WriteDataE);     // bltu
//        3'b101: take_branch = (SrcAE >= WriteDataE);     // bgeu
//        default: take_branch = 1'b0;
//    endcase
//end
//end


branch_unit branch_unit_inst(

    .BranchE(BranchE),
    .BranchTypeE(BranchTypeE),

    .Rs1Data(SrcAE),
    .Rs2Data(WriteDataE),

    .TakeBranch(take_branch)

    );

assign PCSrcE = (BranchE & take_branch) || JumpE;



always_comb begin
ResultSrcE_H = 0;
RdE_H = 0; 

ResultSrcE_H = ResultSrcE;
RdE_H = RdE;
end 


assign Rs1E_out = (rst) ? 5'b0 : Rs1E;
assign Rs2E_out = (rst) ? 5'b0 : Rs2E;

// mux_forwardAE 
mux_3_1 muxforwardAE(
.A(RD1E),
.B(ResultW),
.C(ALUResultM),
.sel(ForwardAE),
.Y(SrcAE));

// mux_forwardBE
mux_3_1 muxforwardBE(
.A(RD2E),
.B(ResultW),
.C(ALUResultM),
.sel(ForwardBE),
.Y(WriteDataE));


    //2*1 mux instantiatioin 
    mux_2_input mux(
    .A(WriteDataE),
    .B(ImmExtE),
    .sel(ALUSrcE),
    .C(SrcBE));
    
   //ALU Instantiation 
   ALU alu(
//   .ZeroE(ZeroE),
   .SrcAE(SrcAE),
   .SrcBE(SrcBE),
   .ALUcontrol(ALUcontrolE),
   .ALUout(ALUout));
   
   // adder instantiati8on 
   adder adder(
   .A(PCE),
   .B(ImmExtE),
   .Sum(PCTargetE));
   
   
//   ZeroE = (!ALUout) ? 1'b1 : 1'b0;
//assign PCSrcE = ((BranchE & ZeroE) || JumpE);

   
   always_ff@(posedge clk)
   begin 
   if(rst) 
   begin 
   {RegWriteM , ResultSrcM, MemWriteM} <= 0;
   { ALUResultM, WriteDataM, RdM, PCPlus4M} <= 0;
   LoadTypeM  <= 3'b010;
   StoreTypeM <= 3'b010;
   end 
   
   else begin 
   RegWriteM  <= RegWriteE;
   ResultSrcM <= ResultSrcE;
   MemWriteM  <= MemWriteE;
   ALUResultM <= ALUout;
   WriteDataM <= WriteDataE;
   RdM        <= RdE;
   PCPlus4M   <= PCPlus4E;
   LoadTypeM  <= LoadTypeE;
   StoreTypeM <= StoreTypeE;
   end 
   end
   
  
   
   
   
endmodule
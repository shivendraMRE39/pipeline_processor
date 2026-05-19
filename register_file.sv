`timescale 1ns / 1ps



module register_file(
input logic clk, rst,
input logic WE3,
input logic [4:0] A1,
input logic [4:0] A2,
input logic [4:0] A3,
input logic [31:0] WD3,
output logic [31:0] RD1,
output logic [31:0] RD2 
 );
 
 // register memory
 logic signed [31:0] reg_mem [0:31];

 integer i;
 
  
  //zero register is hard wire register 
  
  assign  RD1 = (A1 == 5'd0 ? 32'b0 : reg_mem[A1]);
  assign  RD2 = (A2 == 5'd0 ? 32'b0 : reg_mem[A2]);
 
 initial 
 begin 
 for (int i = 0; i < 32; i++) begin
            reg_mem[i] = 32'b0;
           end
//         reg_mem[1] = 32'd6;  
//         reg_mem[2] = 32'd10;
//         reg_mem[3] = -32'd5     ;
//         reg_mem[4] = -32'd7;
//         reg_mem[5] = -32'd9;
//         reg_mem[6] = 32'd3;
//         reg_mem[7] = 32'd11;
//         reg_mem[8] = 32'd16;
//         reg_mem[9] = 32'd100;
//         reg_mem[10] = 32'd21;
//         reg_mem[11] = -32'd25;
//         reg_mem[12] = 32'd26;
         
//        
         end
         
         always_ff @(negedge clk)
begin
    if (rst) begin
        // do nothing OR initialize here
    end
    else if (WE3 && (A3 != 5'd0)) begin
        reg_mem[A3] <= WD3;
    end
end
                                                 
endmodule

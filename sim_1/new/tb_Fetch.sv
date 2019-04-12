`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2018 12:01:21 PM
// Design Name: 
// Module Name: tb_Fetch
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


module tb_Fetch(

    );
    
   reg clk,En,branch,Rst;
   reg [15:0] pc_incr;
   reg [15:0]branoff,next_addr,pres_addr;
   wire [31:0] ins,memdout;
    
    
    Fetch uut(
        .clk(clk),
        .En(En),
        .Rst(Rst),
        .branch(branch),
        .pc_incr_temp(pc_incr),
        .next_addr_temp(next_addr),
        .pres_addr_temp(pres_addr),
        .memdout_temp(memdout),
        .branoff(branoff),
        .ins(ins)
        );
    initial begin
        clk=1'b0;
    end
    always #5 clk=!clk;
    
    initial begin
        Rst=1'b1;
        #10
        Rst=1'b0;
        En=1'b1;
        branoff=16'h0008;
        branch=1'b0;
        #50
        branch=1'b1;
        #60
        branch=1'b0;
     end  
        
endmodule

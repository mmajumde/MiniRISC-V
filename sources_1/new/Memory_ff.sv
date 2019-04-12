`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/13/2018 03:50:17 PM
// Design Name: 
// Module Name: Memory_ff
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


module Memory_ff(
    input  logic       clk,
    input  logic       Rst,
    input  logic       wea,
    input  logic       En,
    input  logic [7:0] din,
    input  logic [5:0] addr,
    output logic [7:0] dout
    );
    logic [7:0] memdata[63:0];
    
    always_ff @(posedge clk)
        if(Rst)
            dout<=8'h00;
        else if(wea & En)begin
            memdata[addr]<=din;
            dout<=din;
            end
        else
            dout<=memdata[addr];
    `ifndef SYNTHESIS
                integer i;
                initial begin
                  for(i=0; i<64 ;i=i+1)begin
                    memdata[i] = 8'hff;
                  end
                    end
                  `endif        
        
endmodule : Memory_ff

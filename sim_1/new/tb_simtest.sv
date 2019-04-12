`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 04:00:43 PM
// Design Name: 
// Module Name: tb_simtest
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


module tb_simtest(

    );
    logic [31:0]a,b,s;
    simtest uut (.a(a),.b(b),.s(s));
    
    initial begin
        repeat (10) begin
             a=$random;
             b=$random;
             #10;
        end
    end
endmodule

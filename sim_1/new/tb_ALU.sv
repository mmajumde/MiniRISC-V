`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2018 06:24:44 PM
// Design Name: 
// Module Name: tb_ALU
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


module tb_ALU(

    );
    reg [31:0]a,b,s;
    reg [2:0]sel;
    reg addb,rightb,logicb;
    ALU uut(
    .a(a),
    .b(b),
    .s(s),
    .sel(sel),
    .addb(addb),
    .rightb(rightb),
    .logicb(logicb)
    );
    
    initial begin
     repeat(50)begin
        a=$random;
        b=$random;
        sel=$random;
        addb=$random;
        rightb=$random;
        logicb=$random;
        #10;
      end
     end
endmodule

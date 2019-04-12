`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 07:42:39 PM
// Design Name: 
// Module Name: tb_Branchdecision
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


module tb_Branchdecision(

    );
    reg [3:0] a,b,s;
    reg cin,cout;
    Branchdecision uut(
        .a(a),
        .b(b),
        .s(s),
        .cout(cout),
        .cin(cin)
        );
        
     initial begin
        cin=1'b0;
        a=4'hF;
        b=4'h5;
        #10
        a=4'h9;
        b=4'hE;
        #10
        a=4'h1;
        b=4'hD;
        #10
        a=4'h7;
        b=4'h1;
      end
endmodule

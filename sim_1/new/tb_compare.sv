`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2018 05:26:12 PM
// Design Name: 
// Module Name: tb_compare
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


module tb_compare(

    );
    reg [4:0]rs1,rs2,rd1,rd2;
    reg z1,z2,z3,z4;
    compare uut(
    .IF_ID_rs1(rs1),
    .IF_ID_rs2(rs2),
    .ID_EX_rd(rd1),
    .EX_MEM_rd(rd2),
    .zero1(z1),
    .zero2(z2),
    .zero3(z3),
    .zero4(z4)
    );
    
    initial begin
        repeat(100) begin 
            rs1 = $random; //apply random stimulus 
            rs2 = $random; 
            rd1 = $random;
            rd2 = $random;
            #10; 
        end
     end
       
endmodule

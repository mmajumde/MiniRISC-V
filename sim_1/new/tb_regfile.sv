`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2018 02:47:26 PM
// Design Name: 
// Module Name: tb_regfile
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


module tb_regfile(

    );
    
    reg clk,regwrite;
    reg [4:0]adr_rs1,adr_rs2,adr_rd;
    reg [31:0]dout_rs1,dout_rs2,din_rd;
    Regfile uut(
        .clk(clk),
        .adr_rs1(adr_rs1),
        .adr_rs2(adr_rs2),
        .adr_rd(adr_rd),
        .dout_rs1(dout_rs1),
        .dout_rs2(dout_rs2),
        .din_rd(din_rd),
        .regwrite(regwrite)
        );
     initial begin
        clk=1'b0;
     end
     
     always #5 clk=!clk;
     
     initial begin
        adr_rs1=5'b00001;
        adr_rs2=5'b00010;
        adr_rd=5'b000001;
        din_rd=32'hFFFFFFFF;
        regwrite=1'b0;
        #17
        regwrite=1'b1;
        #15
        adr_rd=5'b00010;
        din_rd=43'hFFFF0000;
        #15
        regwrite=1'b0;
        
     end
endmodule

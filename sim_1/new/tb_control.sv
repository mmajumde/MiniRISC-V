`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2018 02:51:54 PM
// Design Name: 
// Module Name: tb_control
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


module tb_control(

    );
    
    logic [6:0]opcode;
    logic [2:0]funct3;
    logic [6:0]funct7; 
    logic ins_zero;
    logic hazard;
    logic flush;
    logic alusel2,alusel1,alusel0;
    logic addb,rightb,logicb,branch,memwrite,memread,regwrite,alusrc;
    logic compare;
    logic jal,jalr;
    Control uut(.*);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
   
        initial begin
            opcode=7'b0110011;
            ins_zero=1'b0;
            hazard=1'b0;
            flush=1'b0;
            funct7=7'b0000000;
            for(int i=0;i<8;i++)begin
                funct3=i;
                #10;
            end
            funct7=7'b0100000;
            #10
            opcode=7'b0010011;
            ins_zero=1'b0;
            hazard=1'b0;
            flush=1'b0;
            funct7=7'b0000000;
            for(int i=0;i<8;i++)begin
                funct3=i;
                #10;
            end
        end
            
//            ins30=1'b1;
//            #10
//            ins30=1'b0;
//            funct3=3'b001;
//            #10
//            funct3=3'b100;
//            #10
//            funct3=3'b101;
//            #10
//            ins30=1'b1;
//            #10
//            ins30=1'b0;
//            funct3=3'b110;
//            #10
//            funct3=3'b111;
//            #10
//            op=7'b0010011;
//            funct3=3'b000;
//            #10
//            funct3=3'b001;
//            #10
//            funct3=3'b100;
//            #10
//            funct3=3'b101;
//            #10
//            ins30=1'b1;
//            #10
//            ins30=1'b0;
//            funct3=3'b110;
//            #10
//            funct3=3'b111;
//            #10
//            op=7'b0000011;
//            #10
//            op=7'b0100011;
//            #10
//            op=7'b1100111;
       
            
            
endmodule

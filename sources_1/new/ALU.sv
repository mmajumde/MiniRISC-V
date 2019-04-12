`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/19/2018 05:58:47 PM
// Design Name: 
// Module Name: ALU
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


//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Branchdecision
// Description:
//   Implements the RISC-V ALU block (part of execute pipeline stage)
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   a -- 32-bit input "a"
//   b -- 32-bit input "b"
//   ID_EX_pres_adr -- present address (program counter) from decoder
//   sel -- ALU select bits from decoder stage
//   addb -- 
//   logicb --
//   rightb --
//   ID_EX_jal --
//   ID_EX_jalr --
//   ID_EX_compare --
// Output:
//   res -- ALU operation result
//   comp_res -- ALU result of comparison
// 
//////////////////////////////////////////////////////////////////////////////////


module ALU
 (input  logic [31:0] a,
  input  logic [31:0] b,
  input  logic [7:0]  ID_EX_pres_adr, //jal instr
  input  logic [2:0]  alusel,
  input  logic        ID_EX_lui,
  input  logic        ID_EX_jal,
  input  logic        ID_EX_jalr,
  input  logic        ID_EX_compare,
  output logic [31:0] res,
  output logic        comp_res);
  
  logic [31:0] s;
  logic [32:0] comp_res_temp;

  assign comp_res_temp = a - b;
  assign comp_res= (a < b);
    
  always_comb
    case(alusel)
      3'b000 : s = a+b;
      3'b001 : s = a-b;
      3'b010 : s = a&b;
      3'b011 : s = a|b;
      3'b100 : s = a^b;
      3'b101 : s = a<<b[4:0];
      3'b110 : s = a>>b[4:0];
      3'b111 : s = a>>>b[4:0];
    endcase

  assign res = (ID_EX_lui) ? b : (ID_EX_jal||ID_EX_jalr) ? {24'h000000,ID_EX_pres_adr} : 
                                         ((ID_EX_compare&&comp_res) ? 
                                          32'h1 : s);
endmodule: ALU
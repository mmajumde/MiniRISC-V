`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Immgen
// Description:
//   Implements the RISC-V immediate generation logic (part of decoder pipeline stage)
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   ins -- 32-bit instruction operation code
//   jalr -- 1-bit control for jump and link for subrouting return
// Output:
//   imm -- 32-bit immediate value to be used during execution
// 
//////////////////////////////////////////////////////////////////////////////////


module Immgen
 (input  logic [31:0] ins,       
  output logic [31:0] imm);

  always_comb
    unique case (ins[6:2])
      5'b00100: imm = {{21{ins[31]}}, ins[30:20]}; //I_type (register)
      5'b00000: imm = {{21{ins[31]}}, ins[30:20]}; //I_type (load)
      5'b01000: imm = {{21{ins[31]}}, ins[30:25], ins[11:7]}; //S_type
      5'b01101: imm = {ins[31:12], {12{1'b0}}}; //lui
      default : imm = {{21{ins[31]}}, ins[30:20]}; 
    endcase
   
    
    
           
         
    endmodule: Immgen

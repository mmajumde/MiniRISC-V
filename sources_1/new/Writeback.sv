`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Writeback
// Description:
//   Implements the writeback function of a RISC-V pipeline
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   MEM_WB_alures -- 32-bit registered value from ALU
//   MEM_WB_memres -- 32-bit value from memory
//   MEM_WB_memread -- 1-bit signal indicating writeback from memory or ALU
// Output:
//   WB_res -- 32-bit value to be written back to register file
// 
//////////////////////////////////////////////////////////////////////////////////


module Writeback
 (input  logic clk,
  input  logic Rst,
  input  logic debug,
  input  logic [31:0] MEM_WB_alures,
  input  logic [31:0] MEM_WB_memres,
  input  logic        MEM_WB_memread,
  input  logic        MEM_WB_regwrite,
  input  logic [4:0]  MEM_WB_rd,
  output logic        WB_ID_regwrite,
  output logic [4:0]  WB_ID_rd,
  output logic [31:0] WB_res,
  output logic [31:0] WB_ID_res);
  
  logic [31:0] WB_res_sig; 
  assign WB_res_sig = (MEM_WB_memread) ? MEM_WB_memres : MEM_WB_alures;
  assign WB_res     = WB_res_sig;
  
  always_ff @(posedge clk) begin
        if (Rst)begin
            WB_ID_rd<=5'b00000;
            WB_ID_res<=32'h00000000;
            WB_ID_regwrite<=1'b0;
        end
        
        else if (!debug)begin
            WB_ID_rd<=MEM_WB_rd;
            WB_ID_res<=WB_res_sig;
            WB_ID_regwrite<=MEM_WB_regwrite;
        end
  end
endmodule: Writeback

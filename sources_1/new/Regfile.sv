`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Regfile
// Description:
//   Implements the RISC-V register file as an array of 32 32-bit registers
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   adr_rs1 -- 5-bit address for source register 1 (rs1)
//   adr_rs2 -- 5-bit address for source register 2 (rs2)
//   adr_rd -- 5-bit address for destination register (rd)
//   din_rd -- 32-bit value to be written to desitination register (rd)
//   regwrite -- 1-bit register write control
// Output:
//   dout_rs1 -- 32-bit value read from source register 1 (rs1)
//   dout_rs2 -- 32-bit value read from source register 2 (rs2)
// 
//////////////////////////////////////////////////////////////////////////////////

module Regfile
  (input  logic        clk,
  input  logic [4:0]  adr_rs1,
  input  logic [4:0]  adr_rs2,
  input  logic [4:0]  adr_rd,
  output logic [31:0] dout_rs1,
  output logic [31:0] dout_rs2,
  input  logic [31:0] din_rd,
  input  logic        regwrite);
  
  
  logic [31:0] regdata[31:0];  // array of 32 32-bit registers
  logic        wen;

  //write enable if regwrite is asserted and read address is not zero
  assign wen = regwrite && |adr_rd;
    
  assign dout_rs1 = |adr_rs1 ? regdata[adr_rs1] : 0;
  assign dout_rs2 = |adr_rs2 ? regdata[adr_rs2] : 0;

  always_ff @(posedge clk)
    if(wen)
      regdata[adr_rd] <= din_rd;
    
  `ifndef SYNTHESIS
    integer i;
    initial begin
      for(i=0; i<32 ;i=i+1)begin
        regdata[i] = $random;
      end
        end
      `endif
    endmodule: Regfile


//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Hazard
// Description:
//   Implements the RISC-V hazard detection (part of decoder pipeline stage)
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   zero1
//   zero2
//   zero3
//   zero4
//   ID_EX_memread -- 1-bit indicating memory read
//   ID_EX_regwrite -- 1-bit indicating register write
//   EX_MEM_memread -- 
//   IF_ID_branch -- 1-bit indicating branch
//   IF_ID_alusrc -- 1-bit indicating instruction from ALU
//   IF_ID_jalr -- 1-bit indicating jump and link for subrouting return
// Output:
//   hz -- 1-bit output indicating hazard condition
// 
//////////////////////////////////////////////////////////////////////////////////

module Hazard
 (input  logic zero1,
  input  logic zero2,
  input  logic zero3,
  input  logic zero4,
  input  logic ID_EX_memread,
  input  logic ID_EX_regwrite,
  input  logic EX_MEM_memread,
  input  logic IF_ID_branch,
  output logic hz,
  input  logic IF_ID_alusrc,
  input  logic IF_ID_jalr);
  
  logic hzi1, hzi2, hzi3, hzi4, hzi5, hzi6, hzi7;
  logic mute;
    
  assign mute = !(IF_ID_jalr+IF_ID_alusrc);
  assign hzi1 = zero1 || (zero2&&mute);
  assign hzi2 = hzi1 && ID_EX_memread;

  assign hz = hzi2 || hzi7;

  assign hzi3 = hzi1 && ID_EX_regwrite;
  assign hzi4 = zero3 || (zero4&&mute);
  assign hzi5 = hzi4 && EX_MEM_memread;
  assign hzi6 = hzi3 || hzi5;
  assign hzi7 = hzi6 && IF_ID_branch; 
  
   
endmodule: Hazard

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Branoffgen
// Description:
//   Implements the RISC-V branch offset generation logic (part of decoder)
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   ins -- 32-bit instruction op code
//   rs1_mod -- 32-bit source register 1 value
//   jal -- indicates jump and link
//   jalr -- indicated jump and link for subrouting return
// Output:
//   branoff -- 16-bit branch offset value
// 
//////////////////////////////////////////////////////////////////////////////////

module Branoffgen
   (input logic [31:0] ins,
    input logic [31:0]rs1_mod,
    input logic jal,
    input logic jalr,
    output logic [7:0] branoff
    );
    logic [31:0]branoff_branch,branoff_jal,branoff_jalr;
    assign branoff_branch={{20{ins[31]}},ins[7],ins[30:25],ins[11:8],1'b0};
    assign branoff_jal={{12{ins[31]}},ins[19:12],ins[20],ins[30:21],1'b0};
    assign branoff_jalr=rs1_mod+{20'h0,ins[31:20]};
    assign branoff=jal?branoff_jal[7:0]:jalr?branoff_jalr[7:0]:branoff_branch[7:0];
                                                                                  
endmodule: Branoffgen

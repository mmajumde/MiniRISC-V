`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Fetch
// Description:
//   Implements the RISC-V fetch pipeline stage
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   En -- enable signal
//   debug -- debug I/O control
//   Rst -- system reset
//   branch -- branch single
//   IF_ID_jalr -- flag jump and link for subrouting return
//   branoff -- 16-bit offset for branching
// Output:
//   IF_ID_pres_adr -- 16-bit program counter address
//   ins -- 32-bit instruction operation code
// 
//////////////////////////////////////////////////////////////////////////////////

module Fetch(
    input  logic        clk,
    input  logic        En,
    input  logic        debug,
    input  logic        Rst,
    input  logic        branch,
    input  logic        IF_ID_jalr,
    input  logic [7:0]  branoff,
    output logic [7:0]  IF_ID_pres_adr,
    output logic [31:0] ins
    );
    logic [7:0] pc_incr;
    logic [31:0] memdout;
    logic [7:0] next_addr;
    logic [7:0] pres_addr;
    logic  En_sig;
    
    assign IF_ID_pres_adr=pres_addr;
    assign pc_incr=(branch)?branoff:8'h04;
    assign next_addr=IF_ID_jalr?branoff:(pres_addr+pc_incr);
    assign En_sig=En && (!debug);//registers disabled when in the debug mode
    
    always_ff@(posedge clk)
    begin
        if (Rst) pres_addr<=8'h00;
        else if(En_sig) pres_addr<=next_addr;     
    end
        //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
        blk_mem_gen_0 ins_mem (
          .clka(clk),    // input wire clka
          .ena(En_sig),      // input wire ena
          .wea(4'b0000),      // input wire [3 : 0] wea
          .addra(pres_addr[7:2]),  // input wire [7 : 0] addra
          .dina(32'h00000000),    // input wire [31 : 0] dina
          .douta(memdout)  // output wire [31 : 0] douta
        );
        
       assign ins=Rst?32'h00000000:memdout;
endmodule

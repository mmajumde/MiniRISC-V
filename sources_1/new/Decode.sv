`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Decode
// Description:
//   Implements the RISC-V decode pipeline stage
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   Rst -- system reset
//   debug -- debug I/O control
//   IF_ID_pres_adr -- 16-bit program counter address from fetch stage
//   ins -- 32-bit instruction operation code
//   WB_res -- 32-bit results for write back
//   EX_MEM_memread --
//   EX_MEM_regwrite --
//   EX_MEM_alures -- 32-bit ALU result
//   EX_MEM_rd -- 5-bit destination register (rd) address
//   IF_ID_dout_rs1 -- 32-bit source register (rs1) value from fetch stage
//   IF_ID_dout_rs2 -- 32-bit source register (rs2) value from fetch stage
// Output:
//   ID_EX_pres_adr -- 16-bit program counter address to execute stage
//   IF_ID_jalr -- fetch to decode flag for jump and link for subroutine return
//   ID_EX_jalr -- decode to execute flag for jump and link for subroutine return
//   branch_taken -- flag indicating branch taken
//   IF_ID_rs1 -- source register (rs1) address
//   IF_ID_rs2 -- source register (rs2) address
//   ID_EX_dout_rs1 -- 32-bit source register (rs1) value to execute stage
//   ID_EX_dout_rs2 -- 32-bit source register (rs2) value to execute stage
//   branoff -- 16-bit branch offset
//   ID_EX_rs1 -- 5-bit source register (rs1) address to execute stage
//   ID_EX_rs2 -- 5-bit source register (rs2) address to execute stage
//   ID_EX_alusel2 -- 
//   ID_EX_alusel1 -- 
//   ID_EX_alusel0 -- 
//   ID_EX_addb -- 
//   ID_EX_logicb -- 
//   ID_EX_rightb -- 
//   ID_EX_alusrc -- 
//   ID_EX_memread -- 
//   ID_EX_memwrite -- 
//   hz -- 
// Input/Output (Bidirectional):
//   ID_EX_rd -- 5-bit destination register (rd) address
// 
//////////////////////////////////////////////////////////////////////////////////



module Decode
(input  logic clk,
 input  logic Rst,
 input  logic debug,
 input  logic [7:0] IF_ID_pres_adr,  //from PC
 output logic [7:0] ID_EX_pres_adr,
 input  logic [31:0] ins,
 input  logic [4:0]  MEM_WB_rd,
 input  logic [31:0] WB_res,
 input  logic        EX_MEM_memread,
 input  logic        EX_MEM_regwrite,
 input  logic        MEM_WB_regwrite,//new
 input  logic [31:0] EX_MEM_alures,
 input  logic [4:0]  EX_MEM_rd,
 output logic        IF_ID_jalr,
 output logic        ID_EX_jalr,
 output logic        branch_taken,
 output logic [4:0]  IF_ID_rs1,
 output logic [4:0]  IF_ID_rs2,
 input  logic [31:0] IF_ID_dout_rs1,
 input  logic [31:0] IF_ID_dout_rs2,
 output logic [31:0] ID_EX_dout_rs1,
 output logic [31:0] ID_EX_dout_rs2,
 output logic [7:0]  branoff,
 output logic        hz,   
 output logic [4:0]  ID_EX_rs1,
 output logic [4:0]  ID_EX_rs2,
 //inout        [4:0]  ID_EX_rd,
 output logic [4:0]  ID_EX_rd,
 output logic [2:0]  ID_EX_alusel,
 output logic [2:0]  ID_EX_storecntrl,
 output logic [4:0]  ID_EX_loadcntrl,
 output logic [3:0]  ID_EX_cmpcntrl, 
 output logic        ID_EX_auipc,
 output logic        ID_EX_lui,
 output logic        ID_EX_alusrc,
 inout  logic        ID_EX_memread,
 output logic        ID_EX_memwrite,
 output logic [31:0] ID_EX_imm,
 output logic        ID_EX_compare,
 output logic        ID_EX_jal,
 inout  logic        ID_EX_regwrite);
 
logic IF_ID_lui;
logic ID_EX_memread_sig, ID_EX_regwrite_sig;
//logic[4:0] ID_EX_rd_sig;

//fluhed instruction detector
logic flush;

//logic debug;
logic ins_zero;
logic flush_sig;
logic [31:0]rs1_mod,rs2_mod;

//logic jal,jalr;
logic [2:0]funct3;
logic [6:0]funct7;

logic IF_ID_jal, IF_ID_compare;
logic IF_ID_jalr_sig;

//hazard detection and compare unit
logic zero1,zero2,zero3,zero4,zeroa,zerob;

//register file
logic [4:0]IF_ID_rd;
logic [31:0]dout_rs1,dout_rs2;

//control
logic [2:0]IF_ID_alusel;
logic      IF_ID_branch;
logic      IF_ID_memwrite,IF_ID_memread,IF_ID_regwrite,IF_ID_alusrc;
logic [2:0]IF_ID_storecntrl;
logic [4:0]IF_ID_loadcntrl;
logic [3:0]IF_ID_cmpcntrl;
logic      IF_ID_auipc;

//imm gen
logic [31:0]imm;
logic hz_sig;
logic branch_taken_sig;

//separating different field of instruction
assign funct3=ins[14:12];
assign funct7=ins[31:25];
assign IF_ID_rs1=ins[19:15];
assign IF_ID_rs2=ins[24:20];
assign IF_ID_rd=ins[11:7];

//assign flush=branch_taken_sig;
//assign debug_out=debug;
assign branch_taken=branch_taken_sig;
assign ins_zero=!(|ins);
assign hz=hz_sig;

   
   //control signal generation
   Control u1(
       .opcode(ins[6:0]),
       .funct3(funct3),
       .funct7(funct7),
       .ins_zero(ins_zero),
       .flush(flush),
       .hazard(hz_sig),
       .alusel(IF_ID_alusel),
       .branch(IF_ID_branch),
       .memwrite(IF_ID_memwrite),
       .memread(IF_ID_memread),
       .regwrite(IF_ID_regwrite),
       .alusrc(IF_ID_alusrc),
       .compare(IF_ID_compare),
       .lui(IF_ID_lui),
       .auipc(IF_ID_auipc),
       .jal(IF_ID_jal),
       .jalr(IF_ID_jalr_sig),
       .storecntrl(IF_ID_storecntrl),
       .loadcntrl(IF_ID_loadcntrl),
       .cmpcntrl(IF_ID_cmpcntrl)
       
   );
   //branchforward
   branchforward u0(
       .rs1(IF_ID_dout_rs1),
       .rs2(IF_ID_dout_rs2),
       .zero3(zero3),
       .zero4(zero4),
       .zeroa(zeroa),
       .zerob(zerob),
       .alusrc(IF_ID_alusrc),
       .imm(imm),
       .alures(EX_MEM_alures),
       .wbres(WB_res),
       .EX_MEM_regwrite(EX_MEM_regwrite),
       .EX_MEM_memread(EX_MEM_memread),
       .MEM_WB_regwrite(MEM_WB_regwrite),
       .rs1_mod(rs1_mod),
       .rs2_mod(rs2_mod)
       );
   
   //Branch decision module
   Branchdecision u2(
        .rs1_mod(rs1_mod),
        .rs2_mod(rs2_mod),
        .hazard(hz_sig),
        .branch(IF_ID_branch),
        .funct3(funct3),
        .jal(IF_ID_jal),
        .jalr(IF_ID_jalr_sig),
        .branch_taken(branch_taken_sig)
   );
   //Hazard detection unit
   Hazard u3(
        .zero1(zero1),
        .zero2(zero2),
        .zero3(zero3),
        .zero4(zero4),
        .IF_ID_alusrc(IF_ID_alusrc),
        .IF_ID_jalr(IF_ID_jalr_sig),
        .IF_ID_branch(IF_ID_branch),
        .ID_EX_memread(ID_EX_memread),
        .ID_EX_regwrite(ID_EX_regwrite),
        .EX_MEM_memread(EX_MEM_memread),
        .hz(hz_sig)
   );
   //Branchoffgen
   Branoffgen u4(
       .ins(ins),
       .rs1_mod(rs1_mod),
       .jal(IF_ID_jal),
       .jalr(IF_ID_jalr_sig),
       .branoff(branoff)
   );
   //Immediate generation
   Immgen u5(
        .ins(ins),
        .imm(imm)        
   );
   //Compare unit for branch decision and hazard detection
   compare u6(
        .IF_ID_rs1(IF_ID_rs1),
        .IF_ID_rs2(IF_ID_rs2),
        .ID_EX_rd(ID_EX_rd),
        .EX_MEM_rd(EX_MEM_rd),
        .MEM_WB_rd(MEM_WB_rd),
        .zero1(zero1),
        .zero2(zero2),
        .zero3(zero3),
        .zero4(zero4),
        .zeroa(zeroa),
        .zerob(zerob)
   ); 
   
   always_ff @(posedge clk)begin
        if(Rst)begin
            ID_EX_alusel<=3'h0;
            ID_EX_alusrc<=1'b0;
            ID_EX_memread_sig<=1'b0;
            ID_EX_memwrite<=1'b0;
            ID_EX_regwrite_sig<=1'b0;
            ID_EX_storecntrl<=3'h0;
            ID_EX_loadcntrl<=5'h0;
            ID_EX_cmpcntrl<=4'h0;
            ID_EX_rs1<=5'b00000;
            ID_EX_rs2<=5'b00000;
            //ID_EX_rd_sig<=5'b00000;
            ID_EX_rd<=5'b00000;
            ID_EX_dout_rs1<=32'h00000000;
            ID_EX_dout_rs2<=32'h00000000;
            ID_EX_pres_adr<=8'h00;
            ID_EX_compare<=1'b0;
            ID_EX_imm<=32'h00000000;
            ID_EX_jal<=1'b0;
            ID_EX_jalr<=1'b0;
            ID_EX_lui<=1'b0;
            ID_EX_auipc<=1'b0;
            end
        else if(!debug) begin
            ID_EX_alusel<=IF_ID_alusel;
            ID_EX_alusrc<=IF_ID_alusrc;
            ID_EX_memread_sig<=IF_ID_memread;
            ID_EX_memwrite<=IF_ID_memwrite;
            ID_EX_regwrite_sig<=IF_ID_regwrite;
            ID_EX_storecntrl<=IF_ID_storecntrl;
            ID_EX_loadcntrl<=IF_ID_loadcntrl;
            ID_EX_cmpcntrl<=IF_ID_cmpcntrl;
            ID_EX_rs1<=IF_ID_rs1;
            ID_EX_rs2<=IF_ID_rs2;
           // ID_EX_rd_sig<=IF_ID_rd;
            ID_EX_rd<=IF_ID_rd;
            ID_EX_compare<=IF_ID_compare;
            ID_EX_dout_rs1<=IF_ID_dout_rs1;
            ID_EX_dout_rs2<=IF_ID_dout_rs2;
            ID_EX_imm<=imm;
            ID_EX_pres_adr<=IF_ID_pres_adr;
            flush_sig<=branch_taken_sig;
            ID_EX_jal<=IF_ID_jal;
            ID_EX_jalr<=IF_ID_jalr_sig;
            ID_EX_lui<=IF_ID_lui;
            ID_EX_auipc<=IF_ID_auipc;
            end
    end
        
    assign ID_EX_memread=ID_EX_memread_sig;
    assign ID_EX_regwrite=ID_EX_regwrite_sig;
   // assign ID_EX_rd=ID_EX_rd_sig;
    assign flush=flush_sig;
    assign IF_ID_jalr=IF_ID_jalr_sig;
endmodule

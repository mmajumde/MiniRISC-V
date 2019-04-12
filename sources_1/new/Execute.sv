`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: Execute
// Description:
//   Implements the RISC-V execution pipeline stage
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   Rst -- system reset
//   debug -- debug I/O control
//   ID_EX_compare --
//   ID_EX_pres_adr -- 16-bit program counter (present address) from decode stage
//   ID_EX_alusel2 -- 
//   ID_EX_alusel1 -- 
//   ID_EX_alusel0 -- 
//   ID_EX_addb --
//   ID_EX_rightb --
//   ID_EX_logicb --
//   ID_EX_alusrc --
//   ID_EX_memread --
//   ID_EX_memwrite --
//   ID_EX_regwrite --
//   ID_EX_rs1 -- 5-bit source register 1 address (rs1)
//   ID_EX_rs2 -- 5-bit source register 2 address (rs2)
//   ID_EX_rd -- 5-bit destination register address (rd)
//   ID_EX_dout_rs1 -- 32-bit value from source register 1 (rs1)
//   ID_EX_dout_rs2 -- 32-bit value from source register 2 (rs2)
//   ID_EX_imm -- 32-bit immediate value
//   MEM_WB_regwrite --
//   EX_MEM_alures -- 32-bit
//   WB_res -- 32-bit
//   ID_EX_jal -- jump and link indicator
//   ID_EX_jalr -- jump and link for subrouting return indicator
//   MEM_WB_rd -- 5-bit destination register address for write back
// Output:
//   EX_MEM_dout_rs2 -- 32-bit value output to memory
//   ins -- 32-bit instruction operation code
//   EX_MEM_memread --
//   EX_MEM_rd -- 5-bit destination register address for memory access
//   EX_MEM_memwrite -- memory write signal
//   EX_MEM_regwrite -- register write signal
//   EX_MEM_comp_res --
//   dbg_ALUop1 -- 32-bit ALU operation for debugging
//   dbg_ALUop2 -- 32-bit ALU operation for debugging
// 
//////////////////////////////////////////////////////////////////////////////////


module Execute
 (input  logic        clk,
  input  logic        Rst,
  input  logic        debug,
  input  logic        ID_EX_lui,
  input  logic        ID_EX_auipc,
  //memory control input
  input  logic [4:0]  ID_EX_loadcntrl,
  input  logic [2:0]  ID_EX_storecntrl,
  input  logic [3:0]  ID_EX_cmpcntrl,
  //memory control output
  output logic [4:0]  EX_MEM_loadcntrl,
  output logic [2:0]  EX_MEM_storecntrl,
  
  input  logic        ID_EX_compare,
  input  logic [7:0]  ID_EX_pres_adr,
  input  logic [2:0]  ID_EX_alusel,
  input  logic        ID_EX_alusrc,
  input  logic        ID_EX_memread,
  input  logic        ID_EX_memwrite,
  input  logic        ID_EX_regwrite,
  input  logic        ID_EX_jal,
  input  logic        ID_EX_jalr,
  input  logic [4:0]  ID_EX_rs1,
  input  logic [4:0]  ID_EX_rs2,
  input  logic [4:0]  ID_EX_rd,
  input  logic [31:0] ID_EX_dout_rs1,
  input  logic [31:0] ID_EX_dout_rs2,
  output logic [31:0] EX_MEM_dout_rs2,
  input  logic [31:0] ID_EX_imm,
  input  logic        MEM_WB_regwrite,
  input  logic        WB_ID_regwrite,
  output logic [31:0] EX_MEM_alures,
  input  logic [31:0] WB_res,
  input  logic [31:0] WB_ID_res,
  output logic        EX_MEM_memread,
  output logic [4:0]  EX_MEM_rd,
  input  logic [4:0]  MEM_WB_rd,
  input  logic [4:0]  WB_ID_rd,
  output logic        EX_MEM_memwrite,
  output logic        EX_MEM_regwrite,
  output logic        EX_MEM_comp_res
  );
 
  logic EX_MEM_memread_sig, EX_MEM_regwrite_sig;
  logic [31:0] EX_MEM_alures_sig;
  logic [4:0]  EX_MEM_rd_sig;
  logic comp_res;
  logic [31:0] alures;
  logic [2:0]  sel;
  logic [31:0] ALUop1,ALUop2,rs2_mod;
  logic [31:0] rs2_mod_final;//new
  
  
 
  

  Forwarding dut(
         .EX_MEM_regwrite(EX_MEM_regwrite_sig),
         .EX_MEM_memread(EX_MEM_memread_sig),
         .MEM_WB_regwrite(MEM_WB_regwrite),
         .WB_ID_regwrite(WB_ID_regwrite),
         .EX_MEM_rd(EX_MEM_rd_sig),
         .MEM_WB_rd(MEM_WB_rd),
         .WB_ID_rd(WB_ID_rd),
         .ID_EX_rs1(ID_EX_rs1),
         .ID_EX_rs2(ID_EX_rs2),
         .alures(EX_MEM_alures),
         .memres(WB_res),
         .wbres(WB_ID_res),
         .alusrc(ID_EX_alusrc),
         .imm(ID_EX_imm),
         .rs1(ID_EX_dout_rs1),
         .rs2(ID_EX_dout_rs2),
         .fw_rs1(ALUop1),
         .fw_rs2(ALUop2),
         .rs2_mod(rs2_mod)
  );
  
 ALU uut(
        .a(ALUop1),
        .b(ALUop2),
        .alusel(ID_EX_alusel),
        .ID_EX_compare(ID_EX_compare),
        .ID_EX_pres_adr(ID_EX_pres_adr),
        .ID_EX_lui(ID_EX_lui),
        .ID_EX_jal(ID_EX_jal),
        .ID_EX_jalr(ID_EX_jalr),
        .res(alures),
        .comp_res(comp_res)
        );
        
 always_ff @(posedge clk) begin
        if(Rst) begin
            EX_MEM_rd_sig<=5'b00000;
            EX_MEM_memread_sig<=1'b0;
            EX_MEM_memwrite<=1'b0;
            EX_MEM_regwrite_sig<=1'b0;
            EX_MEM_alures_sig<=32'h00000000;
            EX_MEM_dout_rs2<=32'h00000000;
            EX_MEM_comp_res<=1'b0;
            EX_MEM_loadcntrl<=5'h0;
            EX_MEM_storecntrl<=3'h0;
        end
        else if(!debug) begin
            EX_MEM_rd_sig<=ID_EX_rd;
            EX_MEM_memread_sig<=ID_EX_memread;
            EX_MEM_memwrite<=ID_EX_memwrite;
            EX_MEM_regwrite_sig<=(ID_EX_regwrite&&(!ID_EX_compare))+(ID_EX_regwrite&&ID_EX_compare&&comp_res);
            EX_MEM_alures_sig<=alures;
            EX_MEM_dout_rs2<=rs2_mod;//new
            EX_MEM_comp_res<=comp_res;
            EX_MEM_loadcntrl<=ID_EX_loadcntrl;
            EX_MEM_storecntrl<=ID_EX_storecntrl;
        end
  end
  
  assign EX_MEM_rd=EX_MEM_rd_sig;
  assign EX_MEM_alures=EX_MEM_alures_sig;
  assign EX_MEM_memread=EX_MEM_memread_sig;
  assign EX_MEM_regwrite=EX_MEM_regwrite_sig;
endmodule: Execute

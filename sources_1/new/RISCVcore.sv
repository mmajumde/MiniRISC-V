`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Created by:
//   Md Badruddoja Majumder, Garrett S. Rose
//   University of Tennessee, Knoxville
// 
// Created:
//   October 30, 2018
// 
// Module name: RISCVcore
// Description:
//   Implements top Mini-RISC-V core logic
//
// "Mini-RISC-V" implementation of RISC-V architecture developed by UC Berkeley
//
// Inputs:
//   clk -- system clock
//   Rst -- system reset signal
//   debug -- 1-bit debug control signal
//   debug_input -- 5-bit register address for viewing via debug port
// Output:
//   debug_output -- 32-bit output port for viewing contents of register
// 
//////////////////////////////////////////////////////////////////////////////////


module RISCVcore(    input   logic         clk,
    input   logic         Rst,
    input   logic         debug,
    input   logic [4:0]   debug_input,
    output  logic [31:0]  debug_output

    );

    
    
    wire         PC_En;
    wire         hz;
    wire         branch_taken;
    wire  [7:0]  branoff;
    wire  [7:0]  ID_EX_pres_adr;
    wire  [31:0] ins;
    wire  [4:0]  ID_EX_rd;
    wire         ID_EX_memread,ID_EX_regwrite;
    wire  [4:0]  EX_MEM_rd,MEM_WB_rd,WB_ID_rd;
    wire  [4:0]  ID_EX_rs1,ID_EX_rs2;
    wire  [31:0] ID_EX_dout_rs1,ID_EX_dout_rs2,EX_MEM_dout_rs2;
    wire  [31:0] IF_ID_dout_rs1,IF_ID_dout_rs2;
    wire  [7:0]  IF_ID_pres_adr;
    wire         IF_ID_jalr;
    wire         ID_EX_jal,ID_EX_jalr;
    wire         ID_EX_compare;
    wire  [31:0] EX_MEM_alures,MEM_WB_alures,MEM_WB_memres;
    wire         EX_MEM_comp_res;
    
    wire  [2:0]  ID_EX_alusel;
    wire  [4:0]  ID_EX_loadcntrl;
    wire  [2:0]  ID_EX_storecntrl;
    wire  [3:0]  ID_EX_cmpcntrl;
    wire  [4:0]  EX_MEM_loadcntrl;
    wire  [2:0]  EX_MEM_storecntrl;
    wire         ID_EX_alusrc;
    wire         EX_MEM_memread,MEM_WB_memread;
    wire         ID_EX_memwrite,EX_MEM_memwrite;
    wire         EX_MEM_regwrite,MEM_WB_regwrite,WB_ID_regwrite;
    wire         ID_EX_lui;
    wire         ID_EX_auipc;
    wire  [31:0] ID_EX_imm;
    wire  [31:0] WB_res,WB_ID_res;
    wire  [4:0]  adr_rs1;//used for debug option
    wire  [4:0]  IF_ID_rs1,IF_ID_rs2;
    wire         ID_EX_lb,ID_EX_lh,ID_EX_lw,ID_EX_lbu,ID_EX_lhu,ID_EX_sb,ID_EX_sh,ID_EX_sw;
    wire         EX_MEM_lb,EX_MEM_lh,EX_MEM_lw,EX_MEM_lbu,EX_MEM_lhu,EX_MEM_sb,EX_MEM_sh,EX_MEM_sw;
    
    

    assign PC_En=!hz;
    
    //debugging resister
    assign adr_rs1=debug ? debug_input:IF_ID_rs1;
    
    always_ff @(posedge clk) begin
        if(Rst) begin
            debug_output<=32'h00000000;
        end
        else if(debug) begin
                debug_output=IF_ID_dout_rs1;
        end
    end
    
    Fetch u1(
        .clk(clk),
        .En(PC_En),
        .debug(debug),
        .Rst(Rst),
        .IF_ID_jalr(IF_ID_jalr),
        .IF_ID_pres_adr(IF_ID_pres_adr),
        .branch(branch_taken),
        .branoff(branoff),
        .ins(ins)
    );
    
    //register file
       Regfile u0(
           .clk(clk),
           .adr_rs1(adr_rs1),
           .adr_rs2(IF_ID_rs2),
           .adr_rd(MEM_WB_rd),
           .dout_rs1(IF_ID_dout_rs1),
           .dout_rs2(IF_ID_dout_rs2),
           .din_rd(WB_res),
           .regwrite(MEM_WB_regwrite)
       );
    Decode u2(
        .clk(clk),
        .Rst(Rst),
        .debug(debug),
        .ins(ins),
        .MEM_WB_rd(MEM_WB_rd),
        .MEM_WB_regwrite(MEM_WB_regwrite),
        .IF_ID_jalr(IF_ID_jalr),
        .ID_EX_jalr(ID_EX_jalr),
        .ID_EX_jal(ID_EX_jal),
        .WB_res(WB_res),
        .EX_MEM_memread(EX_MEM_memread),
        .EX_MEM_regwrite(EX_MEM_regwrite),
        .EX_MEM_alures(EX_MEM_alures),
        .EX_MEM_rd(EX_MEM_rd),
        .branch_taken(branch_taken),
        .ID_EX_pres_adr(ID_EX_pres_adr),
        .IF_ID_pres_adr(IF_ID_pres_adr),
        .IF_ID_rs1(IF_ID_rs1),
        .IF_ID_rs2(IF_ID_rs2),
        .IF_ID_dout_rs1(IF_ID_dout_rs1),
        .IF_ID_dout_rs2(IF_ID_dout_rs2),
        .ID_EX_dout_rs1(ID_EX_dout_rs1),
        .ID_EX_dout_rs2(ID_EX_dout_rs2),
        .branoff(branoff),
        .hz(hz),
        .ID_EX_rs1(ID_EX_rs1),
        .ID_EX_rs2(ID_EX_rs2),
        .ID_EX_rd(ID_EX_rd),
        .ID_EX_alusel(ID_EX_alusel),
        .ID_EX_alusrc(ID_EX_alusrc),
        .ID_EX_memread(ID_EX_memread),
        .ID_EX_memwrite(ID_EX_memwrite),
        .ID_EX_compare(ID_EX_compare),
        .ID_EX_imm(ID_EX_imm),
        .ID_EX_lui(ID_EX_lui),
        .ID_EX_auipc(ID_EX_auipc),
        .ID_EX_regwrite(ID_EX_regwrite),
        .ID_EX_loadcntrl(ID_EX_loadcntrl),
        .ID_EX_storecntrl(ID_EX_storecntrl),
        .ID_EX_cmpcntrl(ID_EX_cmpcntrl)
       
    );
    
    Execute u3(
        .clk(clk),
        .Rst(Rst),
        .debug(debug),
        .ID_EX_lui(ID_EX_lui),
        .ID_EX_auipc(ID_EX_auipc),
        .ID_EX_loadcntrl(ID_EX_loadcntrl),
        .ID_EX_storecntrl(ID_EX_storecntrl),
        .ID_EX_cmpcntrl(ID_EX_cmpcntrl),
        .EX_MEM_loadcntrl(EX_MEM_loadcntrl),
        .EX_MEM_storecntrl(EX_MEM_storecntrl),
        .ID_EX_compare(ID_EX_compare),
        .ID_EX_pres_adr(ID_EX_pres_adr),
        .ID_EX_jal(ID_EX_jal),
        .ID_EX_jalr(ID_EX_jalr),
        .ID_EX_alusel(ID_EX_alusel),
        .ID_EX_alusrc(ID_EX_alusrc),
        .ID_EX_memread(ID_EX_memread),
        .ID_EX_memwrite(ID_EX_memwrite),
        .ID_EX_regwrite(ID_EX_regwrite),
        .ID_EX_rs1(ID_EX_rs1),
        .ID_EX_rs2(ID_EX_rs2),
        .ID_EX_rd(ID_EX_rd),
        .ID_EX_dout_rs1(ID_EX_dout_rs1),
        .ID_EX_dout_rs2(ID_EX_dout_rs2),
        .EX_MEM_dout_rs2(EX_MEM_dout_rs2),
        .ID_EX_imm(ID_EX_imm),
        .MEM_WB_regwrite(MEM_WB_regwrite),
        .EX_MEM_alures(EX_MEM_alures),
        .WB_res(WB_res),
        .WB_ID_res(WB_ID_res),
        .EX_MEM_memread(EX_MEM_memread),
        .EX_MEM_rd(EX_MEM_rd),
        .MEM_WB_rd(MEM_WB_rd),
        .WB_ID_rd(WB_ID_rd),
        .EX_MEM_memwrite(EX_MEM_memwrite),
        .EX_MEM_regwrite(EX_MEM_regwrite),
        .WB_ID_regwrite(WB_ID_regwrite),
        .EX_MEM_comp_res(EX_MEM_comp_res)
    );
    
    Memory u4(
        .clk(clk),
        .Rst(Rst),
        .debug(debug),
        .EX_MEM_loadcntrl(EX_MEM_loadcntrl),
        .EX_MEM_storecntrl(EX_MEM_storecntrl),
        .EX_MEM_alures(EX_MEM_alures), //ALU result
        .EX_MEM_alusec(EX_MEM_dout_rs2), //second operand of ALU
        .EX_MEM_rd(EX_MEM_rd),
        .EX_MEM_regwrite(EX_MEM_regwrite),
        .EX_MEM_memread(EX_MEM_memread),
        .EX_MEM_memwrite(EX_MEM_memwrite),
        .MEM_WB_regwrite(MEM_WB_regwrite),
        .MEM_WB_memread(MEM_WB_memread),
        .MEM_WB_rd(MEM_WB_rd),
        .MEM_WB_alures(MEM_WB_alures),
        .MEM_WB_memres(MEM_WB_memres)
    );
    
    Writeback u5(
        .clk(clk),
        .Rst(Rst),
        .debug(debug),
        .MEM_WB_alures(MEM_WB_alures),
        .MEM_WB_memres(MEM_WB_memres),
        .MEM_WB_memread(MEM_WB_memread),
        .MEM_WB_rd(MEM_WB_rd),
        .MEM_WB_regwrite(MEM_WB_regwrite),
        .WB_ID_regwrite(WB_ID_regwrite),
        .WB_ID_rd(WB_ID_rd),
        .WB_res(WB_res),
        .WB_ID_res(WB_ID_res)
    );
endmodule

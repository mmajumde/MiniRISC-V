`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/09/2018 10:39:10 PM
// Design Name: 
// Module Name: Memory_byteaddress
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


module Memory_byteaddress(
    input  logic        clk,
    input  logic        rst,
    input  logic        wea,
    input  logic [3:0]  en,
    input  logic [7:0]  addr,
    input  logic [31:0] din,
    output logic [31:0] dout
    );
    //logic [1:0] dout_sel;
    
    
    logic [5:0]  addr0,addr1,addr2,addr3;
    logic [7:0]  d0,d1,d2,d3;
    logic [31:0] di;
    
 
//    always_ff @(posedge clk)
//        dout_sel<=addr[1:0];
    assign dout={d3,d2,d1,d0};   
    always_comb   
    case (addr[1:0])
        2'b00:
            begin
                addr0 = addr[7:2];
                addr1 = addr[7:2];
                addr2 = addr[7:2];
                addr3 = addr[7:2];
                di    = din;
            end 
         2'b01:
            begin
                addr0  = addr[7:2]+6'h1;
                addr1  = addr[7:2];
                addr2  = addr[7:2];
                addr3  = addr[7:2];
                di     = {din[23:16],din[15:8],din[7:0],din[31:24]};
             end 
          2'b10:
             begin
                addr0 =  addr[7:2]+6'h1;
                addr1  = addr[7:2]+6'h1;
                addr2  = addr[7:2];
                addr3  = addr[7:2];
                di     = {din[15:8],din[7:0],din[31:24],din[23:16]};  
             end
             
          2'b11:
            begin
               addr0 =  addr[7:2]+6'h1;
               addr1  = addr[7:2]+6'h1;
               addr2  = addr[7:2]+6'h1;
               addr3  = addr[7:2];
               di     = {din[7:0],din[31:24],din[23:16],din[15:8]};   
            end
       endcase
       
   /*    always_comb
       case(dout_sel)
            2'b00: dout  = {d3,d2,d1,d0};
            2'b01: dout  = {d0,d3,d2,d1};
            2'b10: dout  = {d1,d0,d3,d2};
            2'b11: dout  = {d2,d1,d0,d3};
        endcase         
   */  
 /*   //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    blk_mem_gen_1 mem0 (
      .clka(clk),    // input wire clka
      .ena(en[0]),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addr0),  // input wire [5 : 0] addra
      .dina(di[7:0]),    // input wire [7 : 0] dina
      .douta(d0)  // output wire [7 : 0] douta
    );
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    blk_mem_gen_2 mem1 (
      .clka(clk),    // input wire clka
      .ena(en[1]),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addr1),  // input wire [5 : 0] addra
      .dina(di[15:8]),    // input wire [7 : 0] dina
      .douta(d1)  // output wire [7 : 0] douta
    );
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    blk_mem_gen_3 mem2 (
      .clka(clk),    // input wire clka
      .ena(en[2]),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addr2),  // input wire [5 : 0] addra
      .dina(di[23:16]),    // input wire [7 : 0] dina
      .douta(d2)  // output wire [7 : 0] douta
    );
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    blk_mem_gen_4 your_instance_name (
      .clka(clk),    // input wire clka
      .ena(en[3]),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addr3),  // input wire [5 : 0] addra
      .dina(di[31:24]),    // input wire [7 : 0] dina
      .douta(d3)  // output wire [7 : 0] douta
    );*/
    
    
    Memory_ff dmem0 (
        .clk(clk),
        .Rst(rst),
        .wea(wea),
        .En(en[0]),
        .addr(addr0),
        .din(di[7:0]),
        .dout(d0)
        );
    Memory_ff dmem1 (
        .clk(clk),
        .Rst(rst),
        .wea(wea),
        .En(en[1]),
        .addr(addr1),
        .din(di[15:8]),
        .dout(d1)
        );
    Memory_ff dmem2 (
        .clk(clk),
        .Rst(rst),
        .wea(wea),
        .En(en[2]),
        .addr(addr2),
        .din(di[23:16]),
        .dout(d2)
        );
    Memory_ff dmem3 (
        .clk(clk),
        .Rst(rst),
        .wea(wea),
        .En(en[3]),
        .addr(addr3),
        .din(di[31:24]),
        .dout(d3)
        );
                
    
endmodule

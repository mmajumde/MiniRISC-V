`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2018 04:23:46 PM
// Design Name: 
// Module Name: tb_memory
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


module tb_memory(
          );

    reg clka;
    reg ena;
    reg [0:0] wea;
    reg [15:0] addra;
    reg [31:0] dina,douta;
    
    // The following must be inserted into your Verilog file for this
    // core to be instantiated. Change the instance name and port connections
    // (in parentheses) to your own signal names.
    
    //----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
    blk_mem_gen_2 your_instance_name (
      .clka(clka),    // input wire clka
      .ena(ena),      // input wire ena
      .wea(wea),      // input wire [0 : 0] wea
      .addra(addra),  // input wire [15 : 0] addra
      .dina(dina),    // input wire [31 : 0] dina
      .douta(douta)  // output wire [31 : 0] douta
    );
    // INST_TAG_END ------ End INSTANTIATION Template ---------
    
    // You must compile the wrapper file blk_mem_gen_0.v when simulating
    // the core, blk_mem_gen_0. When compiling the wrapper file, be sure to
    // reference the Verilog simulation library.
    initial begin
        clka=1'b0;
    end
    always #5 clka=!clka;
    
    initial begin
        ena=1'b1;
        wea=1'b0;
        addra=32'h00000;
        #20;
        addra=32'h00001;
        #20;
        addra=32'h00002;
        #5;
        wea=1'b1;
        dina=32'h11101010;
        #10;
        wea=1'b0;
    end
    
        
        

    
endmodule

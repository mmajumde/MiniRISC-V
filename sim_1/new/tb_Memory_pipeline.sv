`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2018 11:43:17 AM
// Design Name: 
// Module Name: tb_Memory_pipeline
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


module tb_Memory_pipeline(

    );
    
    reg clk;
    reg EX_MEM_regwrite, EX_MEM_memread, EX_MEM_memwrite;
    reg MEM_WB_regwrite, MEM_WB_memread;
    reg [31:0]EX_MEM_alures,EX_MEM_alusec;
    reg [31:0]MEM_WB_alures,MEM_WB_memres;
    reg [4:0]EX_MEM_rd,MEM_WB_rd;
    //wire [31:0] memres;
    Memory uut(
    .clk(clk),
    .EX_MEM_alures(EX_MEM_alures),
    .EX_MEM_alusec(EX_MEM_alusec),
    .EX_MEM_regwrite(EX_MEM_regwrite),
    .EX_MEM_memread(EX_MEM_memread),
    .EX_MEM_memwrite(EX_MEM_memwrite),
    .MEM_WB_regwrite(MEM_WB_regwrite),
    .MEM_WB_memread(MEM_WB_memread),
    .EX_MEM_rd(EX_MEM_rd),
    //.memres(memres),
    .MEM_WB_rd(MEM_WB_rd), 
    .MEM_WB_alures(MEM_WB_alures),
    .MEM_WB_memres(MEM_WB_memres)
    );
    
    initial begin
        clk=1'b0;
    end
    
    always #5 clk=!clk;
    
    initial begin
        repeat(10)begin
            EX_MEM_rd=$random;
            EX_MEM_memread=$random;
            EX_MEM_regwrite=$random;
            
            #10;
        end
    end
    
    initial begin
        EX_MEM_memwrite=1'b1;
        EX_MEM_alures=32'h00000100;
        EX_MEM_alusec=$random;
        #10
        EX_MEM_alures=32'h00000101;
        EX_MEM_alusec=$random;
        #10
        EX_MEM_alures=32'h00000102;
        EX_MEM_alusec=$random;
        #10
        EX_MEM_alures=32'h00000103;
        EX_MEM_alusec=$random;
        #10
        EX_MEM_alures=32'h00000104;
        EX_MEM_alusec=$random;
        #10
        EX_MEM_memwrite=1'b0;
        EX_MEM_alures=32'h00000100;
        #10
        EX_MEM_alures=32'h00000101;
        #10
        EX_MEM_alures=32'h00000102;
        #10
        EX_MEM_alures=32'h00000103;
        #10
        EX_MEM_alures=32'h00000104;
     end
        

    
endmodule

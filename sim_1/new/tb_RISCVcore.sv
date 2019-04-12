`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2018 01:30:18 PM
// Design Name: 
// Module Name: tb_RISCVcore
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


module tb_RISCVcore(

    );
    logic clk;
    logic Rst;
    logic debug;
    logic [4:0]debug_input;
    logic [31:0]debug_output;
//    logic [7:0]debug_IF_ID_pres_adr;
//    logic [31:0]debug_ins;
//    logic [31:0]dbg_imm;
//    logic [31:0]debug_ID_EX_imm;
//    logic [4:0]debug_ID_EX_rs1;
//    logic [4:0]debug_ID_EX_rs2;
//    logic [4:0]debug_ID_EX_rd;
//    logic [4:0]debug_EX_MEM_rd;
//    logic [4:0]debug_MEM_WB_rd;
//    logic [4:0]debug_WB_ID_rd;
//    logic [31:0]debug_ID_EX_dout_rs1;
//    logic [31:0]debug_ID_EX_dout_rs2;
//    logic [31:0]debug_EX_MEM_dout_rs2;
//    logic [31:0]dbg_ALUop1,dbg_ALUop2;
//    logic [31:0]debug_EX_MEM_alures;
//    logic [31:0]debug_MEM_WB_alures;
//    logic [31:0]debug_MEM_WB_memres;
//    logic [31:0]debug_WB_res;
//    logic [31:0]debug_WB_ID_res;
//    logic debug_branch_taken;
//    logic debug_hazard;
//    logic debug_ID_EX_compare;
//    logic dbg_IF_ID_jal;
//    logic dbg_IF_ID_jalr;
//    logic dbg_zero1;
//    logic dbg_zero2;
//    logic dbg_zero3;
//    logic dbg_zero4;
//    logic dbg_zeroa;
//    logic dbg_zerob;
//    logic dbg_IF_ID_branch;
//    logic debug_MEM_WB_regwrite;
//    logic debug_WB_ID_regwrite;
//    logic debug_ID_EX_sel2;
//    logic debug_ID_EX_sel1;
//    logic debug_ID_EX_sel0;
//    logic debug_ID_EX_addb;
//    logic debug_ID_EX_logicb;
//    logic debug_ID_EX_rightb;
//    logic debug_ID_EX_alusrc;
//    logic debug_ID_EX_memread;
//    logic debug_ID_EX_memwrite;
//    logic debug_ID_EX_regwrite;
//    logic debug_EX_MEM_comp_res;
    
    //wire [31:0]dbg_ALUop1,dbg_ALUop2;
   
   
    RISCVcore uut(
        .clk(clk),
        .Rst(Rst),
        .debug(debug),
        .debug_input(debug_input),
        .debug_output(debug_output)
//        .debug_ins(debug_ins),
//        .debug_IF_ID_pres_adr(debug_IF_ID_pres_adr),
//        .debug_ID_EX_imm(debug_ID_EX_imm),
//        .debug_ID_EX_rs1(debug_ID_EX_rs1),
//        .debug_ID_EX_rs2(debug_ID_EX_rs2),
//        .debug_ID_EX_rd(debug_ID_EX_rd),
//        .debug_ID_EX_dout_rs1(debug_ID_EX_dout_rs1),
//        .debug_ID_EX_dout_rs2(debug_ID_EX_dout_rs2),
//        .debug_EX_MEM_dout_rs2(debug_EX_MEM_dout_rs2),
//        .debug_EX_MEM_alures(debug_EX_MEM_alures),
//        .debug_MEM_WB_alures(debug_MEM_WB_alures),
//        .debug_MEM_WB_memres(debug_MEM_WB_memres),
//        .debug_WB_res(debug_WB_res),
//        .debug_WB_ID_res(debug_WB_ID_res),
//        .debug_MEM_WB_rd(debug_MEM_WB_rd),
//        .debug_EX_MEM_rd(debug_EX_MEM_rd),
//        .debug_WB_ID_rd(debug_WB_ID_rd),
//        .debug_branch_taken(debug_branch_taken),
//        .debug_ID_EX_compare(debug_ID_EX_compare),
//        .debug_hazard(debug_hazard),
//        .debug_MEM_WB_regwrite(debug_MEM_WB_regwrite),
//        .debug_WB_ID_regwrite(debug_WB_ID_regwrite),
//        .debug_ID_EX_alusel2(debug_ID_EX_sel2),
//        .debug_ID_EX_alusel1(debug_ID_EX_sel1),
//        .debug_ID_EX_alusel0(debug_ID_EX_sel0),
//        .debug_ID_EX_addb(debug_ID_EX_addb),
//        .debug_ID_EX_logicb(debug_ID_EX_logicb),
//        .debug_ID_EX_rightb(debug_ID_EX_rightb),
//        .debug_ID_EX_alusrc(debug_ID_EX_alusrc),
//        .debug_ID_EX_memread(debug_ID_EX_memread),
//        .debug_ID_EX_memwrite(debug_ID_EX_memwrite),
//        .debug_ID_EX_regwrite(debug_ID_EX_regwrite),
//        .debug_EX_MEM_comp_res(debug_EX_MEM_comp_res),
//        .dbg_ALUop1(dbg_ALUop1),
//        .dbg_ALUop2(dbg_ALUop2),
//        .dbg_zero1(dbg_zero1),
//        .dbg_zero2(dbg_zero2),
//        .dbg_zero3(dbg_zero3),
//        .dbg_zeroa(dbg_zeroa),
//        .dbg_zerob(dbg_zerob),
//        .dbg_imm(dbg_imm),
//        .dbg_zero4(dbg_zero4),
//        .dbg_IF_ID_jal(dbg_IF_ID_jal),
//        .dbg_IF_ID_jalr(dbg_IF_ID_jalr),
//        .dbg_IF_ID_branch(dbg_IF_ID_branch)
    );
    //clock generator
    always #5 clk=!clk;
    
    //stimuli
    initial begin
        clk=1'b0;
        Rst=1'b1;
        debug=1'b0;
        debug_input=5'b01001;
        #10
        Rst=1'b0;
        #3400
        debug=1'b1;
        #10
        debug=1'b0;
    end
    
    //check the results
//    initial begin
//        #26
//        if (uut.u3.alures==32'h0)
//            $display("success 1st instruction in alures");
//        else
//            $display("error in the 1st instruction in alures");
            
//        #10
      
//        $display("ALUop1 at time %0t: %h ",$time,uut.u3.ALUop1);
//        if (uut.u3.ALUop1==32'h0)
//            $display("success 2nd instruction ALUop1");
//        else
//            $display("error in the 2nd instruction in ALUop1");
            
//        if (uut.u3.ALUop2==32'h5)
//            $display("success 2nd instruction ALUop2");
//        else
//            $display("error in the 2nd instruction in ALUop2"); 
            
//        if (uut.u3.alures==32'h5)
//            $display("success 2nd instruction alures ");
//        else
//            $display("error in the 2nd instruction in alures");        

//        #10
//        if (uut.u3.ALUop1==32'h5)
//            $display("success 3rd instruction ALUop1");
//        else
//            $display("error in the 2nd instruction in ALUop1");
            
//        if (uut.u3.ALUop2==32'h5)
//            $display("success 3rd instruction ALUop2");
//        else
//            $display("error in the 2nd instruction in ALUop2"); 
            
//        if (uut.u3.alures==32'ha)
//            $display("success 3rd instruction alures ");
//        else
//            $display("error in the 3rd instruction in alures");        

//        #10
//        if (uut.u3.ALUop1==32'h5)
//            $display("success 4th instruction ALUop1");
//        else
//            $display("error in the 4th instruction in ALUop1");
            
//        if (uut.u3.ALUop2==32'h2)
//            $display("success 4th instruction ALUop2");
//        else
//            $display("error in the 4th instruction in ALUop2"); 
            
//        if (uut.u3.alures==32'h7)
//            $display("success 4th instruction alures ");
//        else
//            $display("error in the 4th instruction in alures");        

            
//        if (uut.u3.rs2_mod==32'ha)
//            $display("success 4th instruction alusec ");
//        else
//            $display("error in the 4th instruction in alusec");        

//        #10
//        if (uut.u3.ALUop1==32'h5)
//            $display("success 5th instruction ALUop1");
//        else
//            $display("error in the 5th instruction in ALUop1");
            
//        if (uut.u3.ALUop2==32'h2)
//            $display("success 5th instruction ALUop2");
//        else
//            $display("error in the 5th instruction in ALUop2"); 
            
//        if (uut.u3.alures==32'h7)
//            $display("success 5th instruction alures ");
//        else
//            $display("error in the 5th instruction in alures");       
            
  
//        $display("hazard at time %0t: %h ",$time,uut.u2.u1.hazard);
//        if (uut.u2.u1.hazard==1'b1)
//            $display("success 6th instruction data hazard");
//        else
//            $display("error in the 6th instruction data hazard");
                
          

//        #20
        
//            if (uut.u4.MEM_WB_memres==32'ha)
//                $display("success 5th instruction memory");
//            else
//                $display("error in the 5th instruction in memory"); 
//            if (uut.u3.ALUop1==32'ha)
//                $display("success 6th instruction ALUop1");
//            else
//                $display("error in the 6th instruction in ALUop1");
                
//            if (uut.u3.ALUop2==32'h6)
//                $display("success 6th instruction ALUop2");
//            else
//                $display("error in the 6th instruction in ALUop2"); 
                
//            if (uut.u3.alures==32'h10)
//                $display("success 6th instruction alures ");
//            else
//                $display("error in the 6th instruction in alures");       


//        #10
//        if (uut.u3.ALUop1==32'ha)
//            $display("success 7th instruction ALUop1");
//        else
//            $display("error in the 7th instruction in ALUop1");
            
//        if (uut.u3.ALUop2==32'ha)
//            $display("success 7th instruction ALUop2");
//        else
//            $display("error in the 7th instruction in ALUop2"); 
            
//        if (uut.u3.alures==32'h0)
//            $display("success 7th instruction alures ");
//        else
//            $display("error in the 7th instruction in alures");        
              
 

//        #10
//        if (uut.u3.ALUop1==32'ha)
//            $display("success 8th instruction ALUop1");
//        else
//            $display("error in the 8th instruction in ALUop1");
            
//        if (uut.u3.ALUop2==32'h0)
//            $display("success 8th instruction ALUop2");
//        else
//            $display("error in the 8th instruction in ALUop2"); 
            
//        if (uut.u3.alures==32'h0)
//            $display("success 8th instruction alures ");
//        else
//            $display("error in the 8th instruction in alures");        
                          
//    end        
             
 

            
        
    
endmodule

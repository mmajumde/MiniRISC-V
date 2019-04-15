# MiniRISC-V
Single core processor implementing user level instruction of RISC-V 32I instruction set.
5 stage pipline.

1. Design source files are in the directory: MiniRISC-V/sources
2. Testbenches are in the directory: MiniRISC-V/sim_1/new
3. Instruction memory is a VIVADO IP core used in the Fetch.sv file
      go to IP_catalogue of VIVADO
      search and open the IP "Block Memory Generator"
      Set configuration:
        Interface Type: Native
        Memory Type: Single Port RAM
        ECC Type: No ECC
        Byte Write Enable: Enabled
        Byte Size (bits): 8
        Algorithm Options: default
        
        PORTA Options:
          Write Width: 32
          Read Width:  32
          Write Depth: 64
          Read Depth:  64
        Operating Mode: Write First, Enable Port Type: Use ENA Pin
        
        Other Options:
          Load Init File: checked
          Coe File: Choose one from the directory MiniRISC-V:/Assembly
          Fill Remaining Memory Locations: 00000
4. You can run your own assembly program and generate .coe file using the assembler.py file in the MiniRISC-V/Assembly
5. Run the tb_RISCVcore to simulate detailed functionality of the core in each pipeline.
        
          
      
      
      

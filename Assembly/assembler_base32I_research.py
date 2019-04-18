import re
import sys



inputfile=sys.argv[1]
outputfile=sys.argv[2]

fw=open(outputfile,'w')




fw.write('memory_initialization_radix=16;\n'+'memory_initialization_vector=\n')
Rtype=['add','sub','and','or','xor','sll','srl','sra','slt','sltu']
Itype_1=['addi','subi','andi','ori','xori','slli','srli','srai','slti','sltiu']
Itype_2=['lb','lh','lw','lbu','lhu']
Stype=['sb','sh','sw']
Btype=['beq','bne','blt','bge','bltu','bgeu']
Call=['jal']
Ret=['jalr']
LUI=['lui']

funct3={'add':'000',
	'sub':'000',
	'and':'111',
	'or' :'110',
	'xor':'100',
	'sll':'001',
	'srl':'101',
	'sra':'101',
	'slt':'010',
	'sltu':'011',
	'addi':'000',
	'andi':'111',
	'ori' :'110',
	'xori':'100',
	'slli':'001',
	'srli':'101',
	'srai':'101',
	'slti':'010',
	'sltiu':'011',
	'beq' :'000',
	'bne' :'001',
	'blt' :'100',
	'bge' :'101',
	'bltu':'110',
	'bgeu':'111',
	'lb'  :'000',
	'lh'  :'001',
	'lw'  :'010',
	'lbu' :'100',
	'lhu' :'101',
	'sb'  :'000',
	'sh'  :'001',
	'sw'  :'010'}

ins_bin=''
def line_num(phrase,inputfile):
	with open(inputfile) as f:
		count=0
		for line in f:
			count=count+1
			if line==phrase:
				return count
a=line_num('start:\n',inputfile)

with open(inputfile) as f:
	labeldict={}
	count=0
	for line in f:
		count=count+1
		line=line.strip('\n')
		line=line.strip(']')
		line=line.strip(':')
		ins=re.split(',|\[| ',line)
		if ins[0] not in Rtype+Itype_1+Itype_2+Stype+Btype+Call+Ret+LUI:
			labeldict[ins[0]]=count
			count=count-1
			
with open(inputfile) as f:
	lcount=0
	truecount=0
	for line in f:
		lcount=lcount+1
		truecount=truecount+1
		line=line.strip('\n')
		line=line.strip(']')
		ins=re.split(',|\[| ',line)
		flag=1
		print(ins[0]) 
		#opcode field	
		if  ins[0] in Rtype:
			opcode='0110011'
			rd=format(int(ins[1][1:]),'05b')
			rs1=format(int(ins[2][1:]),'05b')
			rs2=format(int(ins[3][1:]),'05b')
			if (ins[0]=='sub' or ins[0]=='sra'):
				op30='1'
			else:
				op30='0'
			
			ins_bin='0'+op30+'00000'+rs2+rs1+funct3[ins[0]]+rd+opcode
			
		elif ins[0] in Itype_1:
			opcode='0010011'
			rd=format(int(ins[1][1:]),'05b')
			rs1=format(int(ins[2][1:]),'05b')
			imm=int(ins[3])
			print(imm)
			if imm<0:
				imm=2**12+imm
			imm=format(imm,'012b')
			print(imm)
			ins_bin=imm+rs1+funct3[ins[0]]+rd+opcode
		elif ins[0] in Itype_2:
			opcode='0000011'
			rd=format(int(ins[1][1:]),'05b')
			rs1=format(int(ins[2][1:]),'05b')
			imm=int(ins[3])
			print(imm)
			if imm<0:
				imm=2**12+imm
			imm=format(imm,'012b')
			ins_bin=imm+rs1+funct3[ins[0]]+rd+opcode	
		elif ins[0] in Stype:
			opcode='0100011'
			rs2=format(int(ins[1][1:]),'05b')
			rs1=format(int(ins[2][1:]),'05b')
			imm=int(ins[3])
			if imm<0:
				imm=2**12+imm
			imm=format(imm,'012b')
			ins_bin=imm[0:7]+rs2+rs1+funct3[ins[0]]+imm[7:]+opcode
		elif ins[0] in Btype:
			opcode='1100011'
			rs1=format(int(ins[1][1:]),'05b')
			rs2=format(int(ins[2][1:]),'05b')
			jump_label=ins[3]
			line_jump=labeldict[jump_label]
			imm=line_jump-truecount
			imm=imm*2
			if imm<0:
				imm=2**12+imm
			imm=format(imm,'012b')
			ins_bin=imm[0]+imm[2:8]+rs2+rs1+funct3[ins[0]]+imm[8:]+imm[1]+opcode
			print(ins_bin)
		elif ins[0] in Call:
			opcode='1101111'
			rd=format(int(ins[1][1:]),'05b')
			jump_label=ins[2]
			line_jump=labeldict[jump_label]
			print(line_jump)
			print(truecount)
			imm=line_jump-truecount
			imm=imm*2
			print(imm)
			if imm<0:
				imm=2**20+imm
			imm=format(imm,'020b')
			ins_bin=imm[0]+imm[10:20]+imm[9]+imm[1:9]+rd+opcode
		elif ins[0] in Ret:
			opcode='1100111'
			rd=format(int(ins[1][1:]),'05b')
			rs1=format(int(ins[2][1:]),'05b')
			imm=format(int(ins[3]),'012b')
			ins_bin=imm+rs1+'000'+rd+opcode
		elif ins[0] in LUI:
			opcode='0110111'
			rd=format(int(ins[1][1:]),'05b')
			imm=(int(ins[2]))
			print(imm)
			if imm<0:
				imm=2**20+imm
			imm=format(imm,'020b')
			ins_bin=imm+rd+opcode
			
			
		else:
			flag=0
			truecount=truecount-1
		if flag==1:
			ins_bin_hex=format(int(ins_bin,2),'08x')
			fw.write(ins_bin_hex+'\n')
			print(ins_bin)
fw.write(';')
fw.close()

	
	
	
                                                                     

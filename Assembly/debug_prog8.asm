jal x1,proc
addi x12,x9,0
slt x11,x3,x12
slli x15,x11,2
proc:
xor x3,x3,x3
addi x3,x3,5
add x4,x3,x3
sw x4,x3,2
addi x5,x3,6
start:
xor x6,x3,x4
lhu x4,x3,3
and x4,x6,x6
bne x3,x3,start
or x9,x5,x3
jalr x0,x1,0






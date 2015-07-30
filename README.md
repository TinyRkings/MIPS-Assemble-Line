#### MIPS-Assemble-Line/Verilog
*purpose*: simulate the process of MIPS Assemble Line

*function*: it realizes about 21 commands in the MIPS instruction listed in the following
construction 1：  add  rd, rs, rt  
construction 2：  addi  rt, rs, imm  
construction 3：  addiu  rt, rs, imm  
construction 4：  sub  rd, rs, rt  
construction 5：  subu  rd, rs, rt  
construction 6：  seb  rd,rt  
construction 7：  nor  rd,rs,rt  
construction 8：  xori  rt,ts,imm  
construction 9：  clo  rd,rs  
construction 10： clz  rd,rs
construction 11： sra  rd,rt,rs
construction 12： rotr  rd, rt, shamt
construction 13： sltu  rd, rs, rt
construction 14： slti  rt, rs, imm
construction 15： j  target
construction 16： bgezal  rs,offset
construction 17： lui  rt,imm
construction 18： lwl  rt, offset(base)
construction 19： lw  rt,offset(base)
construction 20： sw  rt, offset(rs)
construction 21： swr  rt, offset(rs)

*device*: computer with quartus II and Modelism
*help*:experiment report(Chinese)

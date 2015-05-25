module lab06_all(clk,branch,Jump,jishu,jishu2,Memwrite,newOperandB,right_answer,newOperandB_src,Jump2,branch2,PC_src,jump_addr,branch_addr,Shift_out,WriteData,ALU_SrcA,ALU_SrcB,Rd_addr,Rd_addr2,WriteReg,Regwr3,Regwr4,OperandA,OperandB,WBdata,WBdata2,right_Mem,Mem_data_out,PC_in,PC_out,A_in,B_in,Overflow,Less,OP,Rs,Rt,Rd,Shamt,Func,Immediate32_2);
input clk;
//程序计数器模块变量定义
output wire[31:0]PC_in;
output [31:0]PC_out;
//存储器模块定义
output wire [31:0]Mem_data_out;
//指令寄存器模块变量定义
//IF、ID流水线段寄存器组
wire [31:0]add_pc;
output wire [5:0]OP;
output wire [4:0]Rs;
output wire [4:0]Rt;
output wire [4:0]Rd;
output wire [4:0]Shamt;
output wire [5:0]Func;
//取数和译码阶段的输出定义，译码控制器变量定义
wire [3:0]WBtype;
wire [1:0]regdst;//用来选择回写寄存器组时的地址，可以rd,rs,或11111
wire [2:0]MemOp;//用于寄存器输出移位器
wire [2:0]CacheOp;//用于数据存储器输出移位器
wire Choice;//用于选择是否经过数据存储器移位器
wire [3:0]Mem_byte_wr_in;//用于数据存储器的使能端
wire MemRead;//决定最后存回的为执行输出还是数据存储器输出
wire [1:0]Extend;//用于立即数扩展
output wire branch;//判断是否分支
output wire Jump;//判断是否跳转
wire [2:0]Condition;
wire [2:0]ExResultSrc;
wire ALUSrcA;
wire ALUSrcB;
wire [3:0]ALU_op;
wire Shift_amountSrc;
wire [1:0]Shift_op;
output wire [31:0]OperandA;
output wire [31:0]OperandB;
wire [31:0]Immediate32;
//寄存器组变量定义
output wire [4:0]WriteReg;//写地址
output wire [31:0]WriteData;//写数据
wire[3:0]Rd_write_byte_en;
wire Regwrite;//写信号，1写入
//执行阶段变量定义
wire [3:0]WBtype2;
wire [3:0]Rd_enable;
wire [1:0]regdst2;
wire [31:0]add_pc2;
wire [2:0]MemOp2;
wire [2:0]CacheOp2;//用于数据存储器输出移位器
wire Choice2;//用于选择是否经过数据存储器移位器
wire [4:0]Rs2;
wire [4:0]Rt2;
wire [4:0]Rd2;
wire [3:0]Mem_byte_wr_in2;//用于数据存储器的使能端
wire [3:0]rig_Mem_byte_wr_in;//由结果变化后的正确的数据存储器的使能端
wire MemRead2;//决定最后存回的为执行输出还是数据存储器输出
wire [1:0]Extend2;//用于立即数扩展
output wire branch2;//判断是否分支
output wire Jump2;//判断是否跳转
wire [2:0]Condition2;
wire [2:0]ExResultSrc2;
wire ALUSrcA2;
wire ALUSrcB2;
wire [3:0]ALU_op2;
wire Shift_amountSrc2;
wire [1:0]Shift_op2;
wire [31:0]OperandA2;
wire [31:0]OperandB2;
output wire [31:0]Immediate32_2;
//获取branch_addr和jump_addr模块变量定义
output wire [31:0]branch_addr;
output wire [31:0]jump_addr;
//获取Rd的地址（写回寄存器组的地址）
output wire [4:0]Rd_addr;
output wire [4:0]Rd_addr2;
wire [3:0]Rd_addr3;
//ALU模块变量定义
output [31:0]A_in;//ALU的A_in
output [31:0]B_in;//ALU的B_in
wire [31:0]ALU_out;
output wire Less;
wire Zero;
output Overflow;
//桶形移位器变量定义
output wire [31:0]Shift_out;
//访存流水线段寄存器
wire [3:0]WBtype3;
wire [3:0]Rd_enable2;
wire [3:0]Reg_write;
output wire[31:0]WBdata;
wire [2:0]MemOp3;
wire [2:0]CacheOp3;
wire Choice3;
wire [3:0]Mem_byte_wr_in3;
wire Less2,Overflow2,Zero2;
output wire [31:0]WBdata2;
wire [31:0]Memdata2;
wire MemRead3;//决定最后存回的为执行输出还是数据存储器输出
output wire [31:0]right_answer;//访存阶段得出的最后答案，结合WBdata和存储器输出
//数据存储器变量定义
wire [31:0]data_out;
wire [31:0]Mem_data_in;
output wire Memwrite;//1写入
//数据存储器输出移位器
wire [31:0]Mem_data_shift;
//MEM、WB流水段寄存器
output wire [31:0]right_Mem;
wire [3:0]WBtype4;
//转发单元模块变量定义
wire [4:0]Rd3;
wire [4:0]Rd4;
output wire Regwr3;
output wire Regwr4;
wire Regwr;
wire Regwr2;
output wire [1:0]newOperandB_src;
output wire [31:0]newOperandB;
output wire [1:0]ALU_SrcA,ALU_SrcB;
//冒险检测
output wire [1:0]PC_src;
output wire jishu;//计数标志位
output wire jishu2;//寄存器组计数标志位

get_PC u1(clk,PC_in,PC_out);//获取新PC
//取指
Mem u2(clk,PC_out,Mem_data_out);//指令存储器模块
IF_ID u3(clk,PC_out,Mem_data_out,add_pc,OP,Rs,Rt,Rd,Shamt,Func);//IF、ID流水线段寄存器
//译码
registers_all u4(clk,WBtype4,jishu2,Rs,Rt,WriteReg,WriteData,Rd_write_byte_en,OperandA,OperandB);//调用寄存器组模块
control_all u5(OP,Rs,Rt,Func, 
Regwr,WBtype,regdst,MemOp,CacheOp,Choice,Mem_byte_wr_in,MemRead,Extend,branch,Jump,Condition,ExResultSrc,ALUSrcA,ALUSrcB,ALU_op,Shift_amountSrc,Shift_op);//译码控制器各输出
get_imm32 u6(Rd,Shamt,Func,Extend,Immediate32);//立即数模块
ID_EX u7(clk,PC_src,
Regwr,regdst,MemOp,CacheOp,Choice,Rd,Rs,Rt,Mem_byte_wr_in,MemRead,Extend,branch,Jump,Condition,ExResultSrc,ALUSrcA,ALUSrcB,ALU_op,
Shift_amountSrc,Shift_op,Immediate32,OperandA,OperandB,WBtype,add_pc,
Regwr2,regdst2,MemOp2,CacheOp2,Choice2,Rd2,Rs2,Rt2,Mem_byte_wr_in2,MemRead2,Extend2,branch2,Jump2,Condition2,ExResultSrc2,ALUSrcA2,ALUSrcB2,ALU_op2,
Shift_amountSrc2,Shift_op2,Immediate32_2,OperandA2,OperandB2,WBtype2,add_pc2);//ID、EX流水段寄存器
//执行
get_branch_jump_addr u8(add_pc2,Immediate32_2,Rs2,Rt2,branch_addr,jump_addr);//获取branch_addr和jump_addr
update_input_ALU u9(newOperandB_src,ALUSrcA2,right_answer,WriteData,ALU_SrcA,ALU_SrcB,OperandA2,OperandB2,Immediate32_2,A_in,B_in,newOperandB);//获取ALU的A_in和B_in

ALU_32 u10(A_in,B_in,ALU_op2,ALU_out,Less,Overflow,Zero);//调用ALU模块
Shift_move u11(B_in,Shift_amountSrc2,Immediate32_2[10:6],A_in[4:0],Shift_op2,Shift_out);//调用桶形寄存器模块
out_ALU_Shift u12(add_pc,ALU_out,Shift_out,ExResultSrc2,WBdata);//output ALUshift_out值
choose_Rd u13(regdst2,Rd2,Rt2,Rd_addr);//选择Rd的地址
get_Rd_enable u14(WBtype2,WBdata[1:0],Overflow,Mem_byte_wr_in2,Rd_enable,rig_Mem_byte_wr_in);//得到寄存器组和数据存储器的使能端
EX_MEM u15(clk,WBtype2,Regwr2,Rd_enable,Rd_addr,MemRead2,MemOp2,CacheOp2,Choice2,rig_Mem_byte_wr_in,Less,Overflow,Zero,WBdata,newOperandB,
WBtype3,Regwr3,Rd_enable2,Rd_addr2,MemRead3,MemOp3,CacheOp3,Choice3,Mem_byte_wr_in3,Less2,Overflow2,Zero2,WBdata2,Memdata2);//EX、MEM流水段寄存器
//访存
RegoutputShift u16(MemOp3,Memdata2,WBdata2[1:0],Mem_data_in);//寄存器输出移位器
Read_datacache u17(clk,jishu,WBdata2,Mem_data_in,Mem_byte_wr_in3,data_out);//从数据存储器中读取数据
MemoutputShift u18(CacheOp3,data_out,WBdata2[1:0],Mem_data_shift);//数据存储器输出移位器
get_right_MEM u19(Choice3,data_out,Mem_data_shift,right_Mem);//由Choice选择正确的数据存储器输出
MEM_WB u20(clk,WBtype3,Regwr3,right_Mem,WBdata2,MemRead3,Rd_addr2,Rd_enable2,WriteData,WriteReg,Rd_write_byte_en,Regwr4,WBtype4);//MEM、WB流水段寄存器
Zhuanfa_unit u21(Rs2,Rt2,Rd_addr2,WriteReg,Regwr3,Regwr4,ALUSrcB2,ALU_SrcA,ALU_SrcB,newOperandB_src);//转发单元
return_PC_in u22(PC_out,jump_addr,branch_addr,PC_src,PC_in);//反馈PC_in
test_risk u23(clk,Jump2,branch2,Condition2,Less,Zero,PC_src,Regwrite,Memwrite);//冒险检测
output_fangcun_lastanswer u24(WBdata2,right_Mem,MemRead3,right_answer);//访存阶段最后数据答案
jishu_enable u25(clk,Memwrite,jishu);//用于冒险时锁存的时钟数计数
jishu_r_enable u26(clk,Regwrite,jishu2);//用于冒险的寄存器组的锁的时钟计数
endmodule



module get_PC(clk,PC_in,PC);//程序计数器模块，来获取PC
input clk;
input [31:0]PC_in;
output reg [31:0]PC;
initial PC = 32'b0;
always @(posedge clk)
begin
	PC=PC_in;
end
endmodule





module Mem(clk,PC_out,Mem_data_out);//指令存储器模块
input clk;
input [31:0]PC_out;
output reg [31:0]Mem_data_out;
reg [31:0]mem[200:0];
initial 
begin
 //Mem_data_out[31:0]={6'd0,5'd1,5'd2,5'd3,5'd0,6'b100000};//add
 mem[0][31:0]={6'd0,5'd1,5'd2,5'd3,5'd0,6'b100000};//add
 mem[4][31:0]={6'b001000,5'd1,5'd4,16'd1025};//addi
 mem[8][31:0]={6'b001001,5'd2,5'd5,16'd1022};//addiu
 mem[12][31:0]={6'd0,5'd4,5'd1,5'd6,5'd0,6'b100010};//sub
 mem[16][31:0]={6'd0,5'd6,5'd5,5'd7,5'd0,6'b100011};//subu
 mem[20][31:0]={6'b011111,5'd0,5'd4,5'd8,5'b10000,6'b100000};//seb rd rt
 mem[24][31:0]={6'd0,5'd1,5'd4,5'd9,5'd0,6'b100111};//nor rd,rs,rt
 mem[28][31:0]={6'b001110,5'd1,5'd10,16'd511};//xori rt,rs,imm
 mem[32][31:0]={6'b011100,5'd1,5'd0,5'd11,5'd0,6'b100001};//clo rd,rs
 mem[36][31:0]={6'b011100,5'd1,5'd0,5'd12,5'd0,6'b100000};//clz rd,rs
 mem[40][31:0]={6'd0,5'd12,5'd30,5'd13,5'd0,6'b000111};//srav rd,rt,rs,算术右移22位，（12）为22
 mem[44][31:0]={6'd0,4'd0,1'b1,5'd31,5'd14,5'd5,6'b000010};//rotr rd,rt,shamt，循环右移
 mem[48][31:0]={6'd0,5'd1,5'd5,5'd15,5'd0,6'b101011};//sltu rd,rs,rt
 mem[52][31:0]={6'b001010,5'd4,5'd16,16'd2047};//slti rt,rs,imm
 mem[56][31:0]={6'b000010,26'd18};//j target,跳转到18*4=72的位置
 mem[72][31:0]={6'b001000,5'd30,5'd17,16'h00ff};//addi,检验Overflow
 mem[76][31:0]={6'b011100,5'd1,5'd0,5'd18,5'd0,6'b100000};//clz rd,rs
 mem[80][31:0]={6'b000001,5'd1,5'b10001,16'd4};//bgezal rs,offset，跳转到80+4*4+4=100位置
 mem[100][31:0]={6'b001111,5'd0,5'd19,16'h1f31};//lui rt,imm
 mem[104][31:0]={6'b100010,5'd0,5'd20,16'd4};//lwl rt,offset(base) 0号寄存器内容加上4
 mem[108][31:0]={6'b100011,5'd0,5'd21,16'd8};//lw rt,offset(base) 0号寄存器内容加上8
 mem[112][31:0]={6'b101011,5'd0,5'd20,16'd116};//sw rt,offset(rs)  0号寄存器内容加上116，执行20寄存器内容指令，即为mem[4]指令
 mem[116][31:0]={6'b101110,5'd0,5'd21,16'd124};//swr rt,offset(rs)  0号寄存器内容加上124，执行21寄存器内容指令，即为mem[8]指令
end
always @(negedge clk)begin
	Mem_data_out=mem[PC_out];
end
endmodule




module IF_ID(clk,PC_out,Mem_data_out,add_pc,OP,Rs,Rt,Rd,Shamt,Func);//IF、ID流水线段寄存器
input clk;
input [31:0]PC_out;
input [31:0]Mem_data_out;
output reg [5:0]OP,Func;
output reg [31:0]add_pc;
output reg [5:0]Rs,Rt,Rd,Shamt;
always @(posedge clk)begin
add_pc<=PC_out+4;
OP<=Mem_data_out[31:26];
Func<=Mem_data_out[5:0];
Rs<=Mem_data_out[25:21];
Rt<=Mem_data_out[20:16];
Rd<=Mem_data_out[15:11];
Shamt<=Mem_data_out[10:6];
end
endmodule 



module registers_all(clk,WBtype4,jishu2,rs_addr,rt_addr,rd_addr,rd_in,Rd_write_byte_en,rs_out,rt_out);//调用寄存器组模块
input clk;//Clock
input [3:0]WBtype4;
input jishu2;//写信号
input [4:0]rs_addr,rt_addr,rd_addr;//2个32位读信号，1个32位写信号
input [31:0]rd_in;//32位的数据输入
input [3:0]Rd_write_byte_en;//enable of byte
output reg[31:0]rs_out,rt_out;//output of 32bits data 
reg[31:0]regi[31:0];//Register Group 
initial begin
		regi[0]=32'd0;//R0 register is always zero
		regi[1][31:0]=32'd1022;
		regi[2][31:0]=32'd1;
		regi[30][31:0]=32'h7fffffff;//用于检验Overflow
		regi[31][31:0]=32'h0f1f7f38;//用于rotr
end
always @(negedge clk)
begin //write the data
if(rd_addr!=0&&jishu2&&WBtype4!=4'b0001&&WBtype4!=4'b0101)//Not the register Zero  
begin
/*
regi[rd_addr][31:24]=(Rd_write_byte_en[3]==0)?rd_in[31:24]:regi[rd_addr][31:24];
regi[rd_addr][15:8]=(Rd_write_byte_en[2]==0)?rd_in[23:16]:regi[rd_addr][23:16];
regi[rd_addr][15:8]=(Rd_write_byte_en[1]==0)?rd_in[15:8]:regi[rd_addr][15:8];
regi[rd_addr][7:0]=(Rd_write_byte_en[0]==0)?rd_in[7:0]:regi[rd_addr][7:0];
*/
if(Rd_write_byte_en[3]==0)
	regi[rd_addr][31:24]=rd_in[31:24];
else
	regi[rd_addr][31:24]=regi[rd_addr][31:24];
if(Rd_write_byte_en[2]==0)
	regi[rd_addr][23:16]=rd_in[23:16];
else
	regi[rd_addr][23:16]=regi[rd_addr][23:16];
if(Rd_write_byte_en[1]==0)
	regi[rd_addr][15:8]=rd_in[15:8];
else
	regi[rd_addr][15:8]=regi[rd_addr][15:8];
if(Rd_write_byte_en[0]==0)
	regi[rd_addr][7:0]=rd_in[7:0];
else
	regi[rd_addr][7:0]=regi[rd_addr][7:0];
end
else
	regi[rd_addr]=regi[rd_addr];
end
always @ (rs_addr or rt_addr)
begin
	rs_out=regi[rs_addr];//read the address
	rt_out=regi[rt_addr];//read the address
end
endmodule


module control_all(OP,Rs,Rt,Func,
Regwr,WBtype,regdst,Rt_out_shift_ctr,Mem_data_shift_ctr,Choice,Mem_byte_wr_in,MemRead,Extend,branch,Jump,condition,ExResultSrc,ALUsrcA,ALUsrcB,ALU_op,Shift_amountSrc,Shift_op);//译码控制器各输出
input [5:0]OP;
input [5:0]Func;
input [4:0]Rs,Rt;
output reg Regwr;//1表示可以转发，0表示不可以转发
output reg [3:0]WBtype;
output reg[1:0]regdst;
output reg [2:0]Rt_out_shift_ctr;
output reg [2:0]Mem_data_shift_ctr;
output reg Choice;//0代表不需要数据存储器输出移位器，1需要
output reg [3:0]Mem_byte_wr_in;
output reg MemRead;//0代表执行输出，1代表数据存储器输出
output reg [1:0]Extend;
output reg branch;//1为存在分支
output reg Jump;//1为存在跳转
output reg [2:0]condition;
output reg [2:0]ExResultSrc;
output reg ALUsrcA;//用来控制B可能存在0的B_in
output reg ALUsrcB;
output reg [3:0]ALU_op;
output reg Shift_amountSrc;
output reg [1:0]Shift_op;
reg [31:26]IR;
initial
begin
branch=0;
Jump=0;
end
always @(*)
begin
IR[31:26]=OP[5:0];
Rt_out_shift_ctr[2]=IR[31]&&(!IR[30])&&IR[29]&&(((!IR[28])&&IR[27])||(IR[27]&&(!IR[26])));
Rt_out_shift_ctr[1]=IR[31]&&(!IR[30])&&IR[29]&&(((!IR[28])&&(!IR[27])&&IR[26])||(IR[28]&&IR[27]&&(!IR[26])));
Rt_out_shift_ctr[0]=IR[31]&&(!IR[30])&&IR[29]&&((!IR[28]&&IR[27]&&(!IR[26])));
Mem_data_shift_ctr[2]=IR[31]&&(!IR[30])&&(!IR[29])&&(((!IR[28])&&IR[27])||(IR[27]&&(!IR[26])));
Mem_data_shift_ctr[1]=IR[31]&&(!IR[30])&&(!IR[29])&&(((!IR[27])&&IR[26])||(IR[28]&&IR[27]&&(!IR[26])));
Mem_data_shift_ctr[0]=IR[31]&&(!IR[30])&&(!IR[29])&&((IR[28]&&(!IR[27]))||((!IR[28])&&IR[27]&&(!IR[26])));
case(OP)
6'b000000:
begin
MemRead<=0;
Extend<=2'b00;
Mem_byte_wr_in<=4'b0000;
regdst<=2'b00;
Choice<=0;
Regwr<=1;
case(Func)
6'b100000://add
begin
	WBtype<=4'b0010;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1110;
	Shift_op<=2'b00;//无关
	Shift_amountSrc<=0;
	ExResultSrc<=3'b000;
end
6'b100010://sub
begin
	WBtype<=4'b0100;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1111;
	Shift_op<=2'b00;//无关
	Shift_amountSrc<=0;
	ExResultSrc<=3'b000;
end
6'b100011://subu
begin
	WBtype<=4'b1111;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b0001;
	Shift_op<=2'b00;//无关
	Shift_amountSrc<=0;
	ExResultSrc<=3'b000;
end
6'b100111://nor,或非
begin
	WBtype<=4'b1111;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1000;
	Shift_op<=2'b00;//无关
	Shift_amountSrc<=0;
	ExResultSrc<=3'b000;
end
6'b101011://sltu
begin
	WBtype<=4'b1111;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b0111;
	Shift_op<=2'b00;//无关
	Shift_amountSrc<=0;
	ExResultSrc<=3'b000;
end
6'b000111://srav,算术右移
begin
//无关
	WBtype<=4'b1111;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1110;
//有关
	Shift_op<=2'b10;
	Shift_amountSrc<=1;
	ExResultSrc<=3'b001;
end
6'b000010://rotr,循环右移
begin
//无关
	WBtype<=4'b1111;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1110;
//有关
	Shift_op<=2'b11;
	Shift_amountSrc<=0;
	ExResultSrc<=3'b001;
end
default://采用add
begin
	WBtype<=4'b0010;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1110;
	Shift_op<=2'b00;//无关
	Shift_amountSrc<=0;
	ExResultSrc<=3'b000;
end
endcase
end
6'b000001://bgezal or bgez
begin
	if(Rt==5'b00001)//bgez
		begin
			MemRead<=0;
			Regwr<=0;
			WBtype<=4'b1111;
			Choice<=0;
			regdst<=2'b00;//no use
			Mem_byte_wr_in<=4'b0000;
			branch<=1;
			Jump<=0;
			condition<=3'd3;
			ExResultSrc<=3'b010;
			//无关
			Extend<=2'b00;
			ALUsrcA<=0;
			ALUsrcB<=0;
			ALU_op<=4'b0000;
			Shift_op<=2'b00;
			Shift_amountSrc<=0;
		end
	else if(Rt==5'b10001)//bgezal，先计算PC+offset
		begin
			MemRead<=0;
			Regwr<=0;
			WBtype<=4'b1111;
			Choice<=0;
			regdst<=2'b10;//no use
			Mem_byte_wr_in<=4'b0000;
			branch<=1;
			Jump<=0;
			condition<=3'd3;
			ExResultSrc<=3'b010;
			//无关
			Extend<=2'b00;
			ALUsrcA<=1;
			ALUsrcB<=0;
			ALU_op<=4'b0000;
			Shift_op<=2'b00;
			Shift_amountSrc<=0;
		end
end
6'b000010://j target
begin
	MemRead<=0;
	Regwr<=0;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b00;//no use
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=1;
	condition<=3'b111;
	ExResultSrc<=3'b000;
	//无关
	Extend<=2'b00;
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b0000;
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b001000://addi
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b0011;
	Choice<=0;
	regdst<=2'b01;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b1110;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b001001://addiu
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b01;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b0000;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b001010://slti
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b01;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b0101;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b001110://xori
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b01;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Extend<=2'b00;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b1001;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b011100:
begin
if(Func==6'b100000)//clz,前导零
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b00;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b0010;
	ExResultSrc<=3'b000;
	//无关
	Extend<=2'b00;
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
else if(Func==6'b100001)//clo,前导一
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b00;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b0011;
	ExResultSrc<=3'b000;
	//无关
	Extend<=2'b00;
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
end
6'b011111://seb
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b00;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;//无关
	ALUsrcA<=0;
	ALUsrcB<=0;
	ALU_op<=4'b1010;
	ExResultSrc<=3'b000;
	//无关
	Extend<=2'b00;
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b001111://lui
begin
	MemRead<=0;
	Regwr<=1;
	WBtype<=4'b1111;
	Choice<=0;
	regdst<=2'b01;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Extend<=2'b10;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b0000;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b100010,6'b100011://lwl,lw
begin
	MemRead<=1;
	Regwr<=1;
	WBtype<=4'b0000;
	Choice<=1;
	regdst<=2'b01;
	Mem_byte_wr_in<=4'b0000;
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b1110;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b101011://sw,计算[base]+offset,缓存到AddrReg_out
begin
	Regwr<=0;
	WBtype<=4'b0101;
	Choice<=0;
	regdst<=2'b00;//no use
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Mem_byte_wr_in<=4'b1111;
	MemRead<=1;
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b1110;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
6'b101110://swr
begin
	Regwr<=0;
	WBtype<=4'b0001;
	Choice<=0;
	regdst<=2'b00;//no use
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Mem_byte_wr_in<=4'b1111;
	MemRead<=1;
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b1110;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
default:
begin
	MemRead<=1;
	Regwr<=0;
	WBtype<=4'b0001;
	Choice<=0;
	regdst<=2'b00;//no use
	branch<=0;
	Jump<=0;
	condition<=3'b000;
	//有关
	Mem_byte_wr_in<=4'b0000;//不存入数据存储器
	Extend<=2'b01;
	ALUsrcA<=0;
	ALUsrcB<=1;
	ALU_op<=4'b1110;
	ExResultSrc<=3'b000;
	//无关
	Shift_op<=2'b00;
	Shift_amountSrc<=0;
end
endcase
end
endmodule



module get_imm32(Rd,Shamt,Func,Extend,Immediate32);//立即数模块
input [4:0]Rd;
input [4:0]Shamt;
input [5:0]Func;
input [1:0]Extend;
output reg [31:0]Immediate32;
always @(*)
begin
case(Extend)
2'b00:
	Immediate32={16'd0,Rd,Shamt,Func};
2'b01:
begin
	if(Rd[4]==0)
		Immediate32={16'd0,Rd,Shamt,Func};
	else
		Immediate32={16'hffff,Rd,Shamt,Func};
end
2'b10:
	Immediate32={Rd,Shamt,Func,16'd0};
2'b11://no use
	Immediate32={16'd0,Rd,Shamt,Func};
default:
	Immediate32={16'd0,Rd,Shamt,Func};
endcase
end
endmodule


module ID_EX(clk,PC_src,
Regwr,regdst,MemOp,CacheOp,Choice,Rd,Rs,Rt,Mem_byte_wr_in,MemRead,Extend,branch,Jump,Condition,ExResultSrc,ALUSrcA,ALUSrcB,ALU_op,
Shift_amountSrc,Shift_op,Immediate32,OperandA,OperandB,WBtype,add_pc,
Regwr2,regdst2,MemOp2,CacheOp2,Choice2,Rd2,Rs2,Rt2,Mem_byte_wr_in2,MemRead2,Extend2,branch2,Jump2,Condition2,ExResultSrc2,ALUSrcA2,ALUSrcB2,ALU_op2,
Shift_amountSrc2,Shift_op2,Immediate32_2,OperandA2,OperandB2,WBtype2,add_pc2);//ID、EX流水段寄存器
input clk;
input [1:0]PC_src;
input Regwr;
input [3:0]WBtype;
input [1:0]regdst;
input [2:0]MemOp;
input [2:0]CacheOp;
input Choice;
input [4:0]Rs;
input [4:0]Rt;
input [4:0]Rd;
input [3:0]Mem_byte_wr_in;//用于数据存储器的使能端
input MemRead;//决定最后存回的为执行输出还是数据存储器输出
input [1:0]Extend;//用于立即数扩展
input branch;//判断是否分支
input Jump;//判断是否跳转
input [2:0]Condition;
input [2:0]ExResultSrc;
input ALUSrcA;
input ALUSrcB;
input [3:0]ALU_op;
input Shift_amountSrc;
input [1:0]Shift_op;
input [31:0]OperandA;
input [31:0]OperandB;
input [31:0]Immediate32;
input [31:0]add_pc;
output reg Regwr2;
output reg[3:0]WBtype2;
output reg[1:0]regdst2;
output reg[2:0]MemOp2;
output reg[2:0]CacheOp2;
output reg Choice2;
output reg[4:0]Rs2;
output reg[4:0]Rt2;
output reg[4:0]Rd2;
output reg[3:0]Mem_byte_wr_in2;//用于数据存储器的使能端
output reg MemRead2;//决定最后存回的为执行输出还是数据存储器输出
output reg[1:0]Extend2;//用于立即数扩展
output reg branch2;//判断是否分支
output reg Jump2;//判断是否跳转
output reg[2:0]Condition2;
output reg[2:0]ExResultSrc2;
output reg ALUSrcA2;
output reg ALUSrcB2;
output reg [3:0]ALU_op2;
output reg Shift_amountSrc2;
output reg [1:0]Shift_op2;
output reg [31:0]OperandA2;
output reg [31:0]OperandB2;
output reg [31:0]Immediate32_2;
output reg [31:0]add_pc2;
always @(posedge clk)
begin
Regwr2<=Regwr;
WBtype2<=WBtype;
regdst2<=regdst;
MemOp2<=MemOp;
CacheOp2<=CacheOp;
Choice2<=Choice;
Rs2<=Rs;
Rt2<=Rt;
Rd2<=Rd;
Mem_byte_wr_in2<=Mem_byte_wr_in;//用于数据存储器的使能端
MemRead2<=MemRead;//决定最后存回的为执行输出还是数据存储器输出
Extend2<=Extend;//用于立即数扩展
if(PC_src!=2'b00)
begin
	branch2<=0;
	Jump2<=0;
end
else
begin
	branch2<=branch;//判断是否分支
	Jump2<=Jump;//判断是否跳转
end
Condition2<=Condition;
ExResultSrc2<=ExResultSrc;
ALUSrcA2<=ALUSrcA;
ALUSrcB2<=ALUSrcB;
ALU_op2<=ALU_op;
Shift_amountSrc2<=Shift_amountSrc;
Shift_op2<=Shift_op;
OperandA2<=OperandA;
OperandB2<=OperandB;
Immediate32_2<=Immediate32;
add_pc2<=add_pc;
end
endmodule


module get_branch_jump_addr(add_pc2,Immediate32_2,Rs2,Rt2,branch_addr,jump_addr);//获取branch_addr和jump_addr
input [31:0]add_pc2;
input [31:0]Immediate32_2;
input [4:0]Rs2,Rt2;
output reg [31:0]branch_addr,jump_addr;
always @(*)
begin
	branch_addr<=add_pc2+(Immediate32_2<<2);
	jump_addr<={add_pc2[31:28],Rs2,Rt2,Immediate32_2[15:0],2'b00};
end
endmodule


module update_input_ALU(newOperandB_src,ALUSrcA2,right_answer,WriteData,ALU_SrcA,ALU_SrcB,OperandA2,OperandB2,Immediate32_2,A_in,B_in,newOperandB);//获取ALU的A_in和B_in
input ALUSrcA2;
input [1:0]newOperandB_src;
input [31:0]right_answer,WriteData;
input [1:0]ALU_SrcA,ALU_SrcB;
input [31:0]OperandA2,OperandB2;
input [31:0]Immediate32_2;
reg [31:0]B_middle;
output reg[31:0]newOperandB;
output reg [31:0]A_in,B_in;
always @(*)
begin
case(newOperandB_src)
2'b00:
	newOperandB=OperandB2;
2'b01:
	newOperandB=right_answer;//
2'b10:
	newOperandB=WriteData;
2'b11://没有此种情况
	newOperandB=OperandB2;
endcase
case(ALU_SrcA)
2'b00:
	A_in=OperandA2;
2'b01:
	A_in=right_answer;
2'b10:
	A_in=WriteData;
default:
	A_in=OperandA2;
endcase
case(ALU_SrcB)
2'b00:
	B_middle=OperandB2;
2'b01:
	B_middle=right_answer;
2'b10:
	B_middle=WriteData;
2'b11:
	B_middle=Immediate32_2;
endcase
if(ALUSrcA2)//"1"为0
	B_in=32'd0;
else//0代表非bgezal指令
	B_in=B_middle;
end
endmodule



module ALU_32(A_in,B_in,ALU_op,ALU_out,Less,Overflow_out,Zero);//ALU
input [31:0]A_in,B_in;
input [3:0]ALU_op;
output reg [31:0]ALU_out;
output reg Less,Overflow_out,Zero;
reg [2:0]ALU_ctr;
reg [31:0]O_out;
reg [31:0]B_not;
reg Overflow;//判断有无溢出
reg Negative;//判断正负数
reg Carry;//判断有无进位
integer i;//用于for循环
integer amount;//用于计算前导零和前导一
reg tag;//用于跳出for循环
always@(*)
begin//设置ALU控制器
ALU_ctr[2]=(!ALU_op[3])&(!ALU_op[1])||(!ALU_op[3])&(ALU_op[2])&(ALU_op[0])||ALU_op[3]&ALU_op[1];
ALU_ctr[1]=(!ALU_op[3])&(!ALU_op[2])&(!ALU_op[1])||ALU_op[3]&(!ALU_op[2])&(!ALU_op[0])||ALU_op[2]&ALU_op[1]&(!ALU_op[0])||ALU_op[3]&ALU_op[1];
ALU_ctr[0]=(!ALU_op[2])&(!ALU_op[1])||(!ALU_op[3])&ALU_op[2]&ALU_op[0]||ALU_op[3]&ALU_op[2]&ALU_op[1];
if(ALU_op[0]==0)//做加法
begin
B_not=B_in;
end
else//做减法
begin
B_not=~B_in;
end
{Carry,O_out}=A_in+B_not+ALU_op[0];//实现加法器
if(O_out==0)//output Zero
Zero=1;
else
Zero=0;
Overflow=(!A_in[31]&!B_not[31]&O_out[31])||(A_in[31]&B_not[31]&!O_out[31]);//判断Overflow
if(O_out[31]==0)//set 正负数
Negative=0;
else
Negative=1;
if(ALU_op[3:1]==3'b111)//output Overflow_out
Overflow_out=Overflow;
else
Overflow_out=0;
if(ALU_op[3:0]==4'b0111)//sltu
Less=!Carry;
else
Less=(Overflow&(!Negative))||((!Overflow)&Negative);
case(ALU_ctr)
3'b000://前导零or前导一
begin
tag=0;
if(ALU_op[0]==0)//前导0，对于A_in
begin
amount=0;
for(i=31;i>0&&tag==0;i=i-1)
begin
if(A_in[i]!=0)
begin
ALU_out=amount;
tag=1;
end
else
amount=amount+1;
end
end
else//前导1
begin
amount=0;
for(i=31;i>0&&tag==0;i=i-1)
begin
if(A_in[i]==0)
begin
ALU_out=amount;
tag=1;
end
else
amount=amount+1;
end
end
ALU_out=amount;
end
3'b001://异或
ALU_out[31:0]=A_in[31:0]^B_in[31:0];
3'b010://或
ALU_out[31:0]=A_in[31:0]|B_in[31:0];
3'b011://或非
ALU_out[31:0]=~(A_in[31:0]|B_in[31:0]);
3'b100://与
ALU_out[31:0]=A_in[31:0]&B_in[31:0];
3'b101://sltu or slti
begin
case(Less)//no matter what,Less is the sel
0:ALU_out=32'd0;
1:ALU_out=32'd1;
endcase
end
3'b110://seb or seh
begin
if(ALU_op[0]==0)//seb
begin
if(B_in[7]==0)
ALU_out={24'd0,B_in[7:0]};
else
ALU_out={24'b111111111111111111111111,B_in[7:0]};
end
else//seh
begin
if(B_in[15]==0)
ALU_out={16'd0,B_in[15:0]};
else
ALU_out={16'b1111111111111111,B_in[15:0]};
end
end
3'b111://加减法
ALU_out=O_out;
endcase
end
endmodule





module Shift_move(Shift_in,Shift_amountSrc,IR,Rs_out,Shift_op,Shift_out);//调用桶形寄存器模块
input [31:0]Shift_in;
input Shift_amountSrc;
input [10:6]IR;
input [4:0]Rs_out;
reg [4:0]Shift_amount;
input [1:0]Shift_op;
output reg[31:0]Shift_out;
always @(*)
begin
if(Shift_amountSrc==0)
	Shift_amount=IR[10:6];
else
	Shift_amount=Rs_out[4:0];
case(Shift_op)
2'b00://逻辑左移
begin
case(Shift_amount)
1:
Shift_out={Shift_in[30:0],1'd0};
2:
Shift_out={Shift_in[29:0],2'd0};
3:
Shift_out={Shift_in[28:0],3'd0};
4:
Shift_out={Shift_in[27:0],4'd0};
5:
Shift_out={Shift_in[26:0],5'd0};
6:
Shift_out={Shift_in[25:0],6'd0};
7:
Shift_out={Shift_in[24:0],7'd0};
8:
Shift_out={Shift_in[23:0],8'd0};
9:
Shift_out={Shift_in[22:0],9'd0};
10:
Shift_out={Shift_in[21:0],10'd0};
11:
Shift_out={Shift_in[20:0],11'd0};
12:
Shift_out={Shift_in[19:0],12'd0};
13:
Shift_out={Shift_in[18:0],13'd0};
14:
Shift_out={Shift_in[17:0],14'd0};
15:
Shift_out={Shift_in[16:0],15'd0};
16:
Shift_out={Shift_in[15:0],16'd0};
17:
Shift_out={Shift_in[14:0],17'd0};
18:
Shift_out={Shift_in[13:0],18'd0};
19:
Shift_out={Shift_in[12:0],19'd0};
20:
Shift_out={Shift_in[11:0],20'd0};
21:
Shift_out={Shift_in[10:0],21'd0};
22:
Shift_out={Shift_in[9:0],22'd0};
23:
Shift_out={Shift_in[8:0],23'd0};
24:
Shift_out={Shift_in[7:0],24'd0};
25:
Shift_out={Shift_in[6:0],25'd0};
26:
Shift_out={Shift_in[5:0],26'd0};
27:
Shift_out={Shift_in[4:0],27'd0};
28:
Shift_out={Shift_in[3:0],28'd0};
29:
Shift_out={Shift_in[2:0],29'd0};
30:
Shift_out={Shift_in[1:0],30'd0};
31:
Shift_out={Shift_in[0],31'd0};
default:
Shift_out=Shift_in;
endcase
end 
2'b01://逻辑右移
begin
case(Shift_amount)
1:
Shift_out={1'd0,Shift_in[31:1]};
2:
Shift_out={2'd0,Shift_in[31:2]};
3:
Shift_out={3'd0,Shift_in[31:3]};
4:
Shift_out={4'd0,Shift_in[31:4]};
5:
Shift_out={5'd0,Shift_in[31:5]};
6:
Shift_out={6'd0,Shift_in[31:6]};
7:
Shift_out={7'd0,Shift_in[31:7]};
8:
Shift_out={8'd0,Shift_in[31:8]};
9:
Shift_out={9'd0,Shift_in[31:9]};
10:
Shift_out={10'd0,Shift_in[31:10]};
11:
Shift_out={11'd0,Shift_in[31:11]};
12:
Shift_out={12'd0,Shift_in[31:12]};
13:
Shift_out={13'd0,Shift_in[31:13]};
14:
Shift_out={14'd0,Shift_in[31:14]};
15:
Shift_out={15'd0,Shift_in[31:15]};
16:
Shift_out={16'd0,Shift_in[31:16]};
17:
Shift_out={17'd0,Shift_in[31:17]};
18:
Shift_out={18'd0,Shift_in[31:18]};
19:
Shift_out={19'd0,Shift_in[31:19]};
20:
Shift_out={20'd0,Shift_in[31:20]};
21:
Shift_out={21'd0,Shift_in[31:21]};
22:
Shift_out={22'd0,Shift_in[31:22]};
23:
Shift_out={23'd0,Shift_in[31:23]};
24:
Shift_out={24'd0,Shift_in[31:24]};
25:
Shift_out={25'd0,Shift_in[31:25]};
26:
Shift_out={26'd0,Shift_in[31:26]};
27:
Shift_out={27'd0,Shift_in[31:27]};
28:
Shift_out={28'd0,Shift_in[31:28]};
29:
Shift_out={29'd0,Shift_in[31:29]};
30:
Shift_out={30'd0,Shift_in[31:30]};
31:
Shift_out={31'd0,Shift_in[31]};
default:
Shift_out=Shift_in;
endcase
end
2'b10://算术右移
begin
if(Shift_in[31]==0)
begin
case(Shift_amount)
1:
Shift_out={1'd0,Shift_in[31:1]};
2:
Shift_out={2'd0,Shift_in[31:2]};
3:
Shift_out={3'd0,Shift_in[31:3]};
4:
Shift_out={4'd0,Shift_in[31:4]};
5:
Shift_out={5'd0,Shift_in[31:5]};
6:
Shift_out={6'd0,Shift_in[31:6]};
7:
Shift_out={7'd0,Shift_in[31:7]};
8:
Shift_out={8'd0,Shift_in[31:8]};
9:
Shift_out={9'd0,Shift_in[31:9]};
10:
Shift_out={10'd0,Shift_in[31:10]};
11:
Shift_out={11'd0,Shift_in[31:11]};
12:
Shift_out={12'd0,Shift_in[31:12]};
13:
Shift_out={13'd0,Shift_in[31:13]};
14:
Shift_out={14'd0,Shift_in[31:14]};
15:
Shift_out={15'd0,Shift_in[31:15]};
16:
Shift_out={16'd0,Shift_in[31:16]};
17:
Shift_out={17'd0,Shift_in[31:17]};
18:
Shift_out={18'd0,Shift_in[31:18]};
19:
Shift_out={19'd0,Shift_in[31:19]};
20:
Shift_out={20'd0,Shift_in[31:20]};
21:
Shift_out={21'd0,Shift_in[31:21]};
22:
Shift_out={22'd0,Shift_in[31:22]};
23:
Shift_out={23'd0,Shift_in[31:23]};
24:
Shift_out={24'd0,Shift_in[31:24]};
25:
Shift_out={25'd0,Shift_in[31:25]};
26:
Shift_out={26'd0,Shift_in[31:26]};
27:
Shift_out={27'd0,Shift_in[31:27]};
28:
Shift_out={28'd0,Shift_in[31:28]};
29:
Shift_out={29'd0,Shift_in[31:29]};
30:
Shift_out={30'd0,Shift_in[31:30]};
31:
Shift_out={31'd0,Shift_in[31]};
default:
Shift_out=Shift_in;
endcase
end
else
begin
case(Shift_amount)
1:
Shift_out={1'b1,Shift_in[31:1]};
2:
Shift_out={2'b11,Shift_in[31:2]};
3:
Shift_out={3'b111,Shift_in[31:3]};
4:
Shift_out={4'hf,Shift_in[31:4]};
5:
Shift_out={5'h1f,Shift_in[31:5]};
6:
Shift_out={6'h3f,Shift_in[31:6]};
7:
Shift_out={7'h7f,Shift_in[31:7]};
8:
Shift_out={8'hff,Shift_in[31:8]};
9:
Shift_out={9'h1ff,Shift_in[31:9]};
10:
Shift_out={10'h3ff,Shift_in[31:10]};
11:
Shift_out={11'h7ff,Shift_in[31:11]};
12:
Shift_out={12'hfff,Shift_in[31:12]};
13:
Shift_out={13'h1fff,Shift_in[31:13]};
14:
Shift_out={14'h3fff,Shift_in[31:14]};
15:
Shift_out={15'h7fff,Shift_in[31:15]};
16:
Shift_out={16'hffff,Shift_in[31:16]};
17:
Shift_out={17'h1ffff,Shift_in[31:17]};
18:
Shift_out={18'h3ffff,Shift_in[31:18]};
19:
Shift_out={19'h7ffff,Shift_in[31:19]};
20:
Shift_out={20'hfffff,Shift_in[31:20]};
21:
Shift_out={21'h1fffff,Shift_in[31:21]};
22:
Shift_out={22'h3fffff,Shift_in[31:22]};
23:
Shift_out={23'h7fffff,Shift_in[31:23]};
24:
Shift_out={24'hffffff,Shift_in[31:24]};
25:
Shift_out={25'h1ffffff,Shift_in[31:25]};
26:
Shift_out={26'h3ffffff,Shift_in[31:26]};
27:
Shift_out={27'h7ffffff,Shift_in[31:27]};
28:
Shift_out={28'hfffffff,Shift_in[31:28]};
29:
Shift_out={29'h1fffffff,Shift_in[31:29]};
30:
Shift_out={30'h3fffffff,Shift_in[31:30]};
31:
Shift_out={31'h7fffffff,Shift_in[31]};
default:
Shift_out=Shift_in;
endcase
end
end
2'b11://循环右移
begin
case(Shift_amount)
1:
Shift_out={Shift_in[0],Shift_in[31:1]};
2:
Shift_out={Shift_in[1:0],Shift_in[31:2]};
3:
Shift_out={Shift_in[2:0],Shift_in[31:3]};
4:
Shift_out={Shift_in[3:0],Shift_in[31:4]};
5:
Shift_out={Shift_in[4:0],Shift_in[31:5]};
6:
Shift_out={Shift_in[5:0],Shift_in[31:6]};
7:
Shift_out={Shift_in[6:0],Shift_in[31:7]};
8:
Shift_out={Shift_in[7:0],Shift_in[31:8]};
9:
Shift_out={Shift_in[8:0],Shift_in[31:9]};
10:
Shift_out={Shift_in[9:0],Shift_in[31:10]};
11:
Shift_out={Shift_in[10:0],Shift_in[31:11]};
12:
Shift_out={Shift_in[11:0],Shift_in[31:12]};
13:
Shift_out={Shift_in[12:0],Shift_in[31:13]};
14:
Shift_out={Shift_in[13:0],Shift_in[31:14]};
15:
Shift_out={Shift_in[14:0],Shift_in[31:15]};
16:
Shift_out={Shift_in[15:0],Shift_in[31:16]};
17:
Shift_out={Shift_in[16:0],Shift_in[31:17]};
18:
Shift_out={Shift_in[17:0],Shift_in[31:18]};
19:
Shift_out={Shift_in[18:0],Shift_in[31:19]};
20:
Shift_out={Shift_in[19:0],Shift_in[31:20]};
21:
Shift_out={Shift_in[20:0],Shift_in[31:21]};
22:
Shift_out={Shift_in[21:0],Shift_in[31:22]};
23:
Shift_out={Shift_in[22:0],Shift_in[31:23]};
24:
Shift_out={Shift_in[23:0],Shift_in[31:24]};
25:
Shift_out={Shift_in[24:0],Shift_in[31:25]};
26:
Shift_out={Shift_in[25:0],Shift_in[31:26]};
27:
Shift_out={Shift_in[26:0],Shift_in[31:27]};
28:
Shift_out={Shift_in[27:0],Shift_in[31:28]};
29:
Shift_out={Shift_in[28:0],Shift_in[31:29]};
30:
Shift_out={Shift_in[29:0],Shift_in[31:30]};
31:
Shift_out={Shift_in[30:0],Shift_in[31]};
default:
Shift_out=Shift_in;
endcase
end
endcase
end
endmodule




module out_ALU_Shift(PC_out,ALU_out,Shift_out,ALUShift_sel,ALUShift_out);//
input [2:0]ALUShift_sel;
input [31:0]PC_out;//此时过了2个时钟，为原PC+8
input [31:0]ALU_out,Shift_out;
output reg [31:0]ALUShift_out;
always @(*)
begin
case (ALUShift_sel)
3'b000:
	ALUShift_out=ALU_out;
3'b001:
	ALUShift_out=Shift_out;
3'b010:
	ALUShift_out=PC_out;
default:
	ALUShift_out=ALU_out;
endcase
end
endmodule



module choose_Rd(regdst2,Rd2,Rt2,Rd_addr);//选择Rd的地址
input [1:0]regdst2;
input [4:0]Rd2,Rt2;
output reg [4:0]Rd_addr;
always @(*)
begin
case(regdst2)
2'b00:
	Rd_addr=Rd2;
2'b01:
	Rd_addr=Rt2;
2'b10:
	Rd_addr=5'b11111;
default:
	Rd_addr=Rd2;
endcase
end
endmodule 



module get_Rd_enable(WBtype2,WBdata,Overflow,Mem_byte_wr_in2,Rd_write_byte_en,rig_Mem_byte_wr_in);//得到寄存器组的使能端
input [3:0]WBtype2;
input [1:0]WBdata;
input Overflow;
input [3:0]Mem_byte_wr_in2;
output reg[3:0]Rd_write_byte_en;
output reg[3:0]rig_Mem_byte_wr_in;
always @(*)
begin
case(WBtype2)
4'b0000://lwl
begin
rig_Mem_byte_wr_in=4'b0000;//读取数据存储器的值，高位有效才写
	case(WBdata)
		2'd0:
			Rd_write_byte_en=4'b0000;
		2'd1:
			Rd_write_byte_en=4'b0001;
		2'd2:
			Rd_write_byte_en=4'b0011;
		2'd3:
			Rd_write_byte_en=4'b0111;
	endcase
end
4'b0001://swr,高有效
begin
Rd_write_byte_en=4'b1111;//不写入寄存器组，低有效写入
	case(WBdata)
		2'd0:
			rig_Mem_byte_wr_in=4'b1000;
		2'd1:
			rig_Mem_byte_wr_in=4'b1100;
		2'd2:
			rig_Mem_byte_wr_in=4'b1110;
		2'd3:
			rig_Mem_byte_wr_in=4'b1111;
	endcase
end
4'b0101://sw
begin
	rig_Mem_byte_wr_in=4'b1111;
	Rd_write_byte_en=4'b1111;//不写入寄存器组，低有效写入
end
4'b0010,4'b0011,4'b0100://add,addi,sub
begin
rig_Mem_byte_wr_in=4'b0000;//读取数据存储器的值，高位有效才写
if(Overflow==1)
	Rd_write_byte_en=4'b1111;//不存入寄存器组
else
	Rd_write_byte_en=4'b0000;//存入寄存器组
end
4'b1111://else
begin
	Rd_write_byte_en=4'b0000;//存入寄存器组
	rig_Mem_byte_wr_in=4'b0000;//不存入数据存储器中
end
default:
begin
	Rd_write_byte_en=4'b0000;
	rig_Mem_byte_wr_in=4'b0000;//不存入数据存储器中
end
endcase
end
endmodule


module EX_MEM(clk,WBtype2,Regwr2,Rd_enable,Rd_addr,MemRead2,MemOp2,CacheOp2,Choice2,Mem_byte_wr_in2,Less,Overflow,Zero,WBdata,OperandB2,
WBtype3,Regwr3,Rd_enable2,Rd_addr2,MemRead3,MemOp3,CacheOp3,Choice3,Mem_byte_wr_in3,Less2,Overflow2,Zero2,WBdata2,Memdata2);//EX、MEM流水段寄存器
input clk;
input [3:0]WBtype2;
input Regwr2;
input [3:0]Rd_enable;
input [4:0]Rd_addr;
input MemRead2;
input [2:0]MemOp2;
input [2:0]CacheOp2;
input Choice2;
input [3:0]Mem_byte_wr_in2;
input Less,Overflow,Zero;
input [31:0]WBdata,OperandB2;
output reg [3:0]WBtype3;
output reg Regwr3;
output reg [3:0]Rd_enable2;
output reg [4:0]Rd_addr2;
output reg MemRead3;
output reg [2:0]MemOp3;
output reg [2:0]CacheOp3;
output reg Choice3;
output reg [3:0]Mem_byte_wr_in3;
output reg Less2,Overflow2,Zero2;
output reg [31:0]WBdata2,Memdata2;
always @(posedge clk)
begin
	WBtype3<=WBtype2;
	Regwr3<=Regwr2;
	Rd_enable2<=Rd_enable;
	Rd_addr2<=Rd_addr;
	MemRead3<=MemRead2;
	MemOp3<=MemOp2;
	CacheOp3<=CacheOp2;
	Choice3<=Choice2;
	Mem_byte_wr_in3<=Mem_byte_wr_in2;
	Less2<=Less;
	Overflow2<=Overflow;
	Zero2<=Zero;
	WBdata2<=WBdata;
	Memdata2<=OperandB2;
end
endmodule


module Read_datacache(clk,jishu,WBdata2,Memdata2,Mem_byte_wr_in3,data_out);//从数据存储器中读取数据
input clk;
input jishu;
input [31:0]WBdata2,Memdata2;
input [3:0]Mem_byte_wr_in3;
output reg [31:0]data_out;
reg [31:0]mem[200:0];
initial 
begin
 mem[0][31:0]={6'd0,5'd1,5'd2,5'd3,5'd0,6'b100000};//add
 mem[4][31:0]={6'b001000,5'd1,5'd4,16'd1025};//addi
 mem[8][31:0]={6'b001001,5'd2,5'd5,16'd1022};//addiu
 mem[12][31:0]={6'd0,5'd4,5'd1,5'd6,5'd0,6'b100010};//sub
 mem[16][31:0]={6'd0,5'd6,5'd5,5'd7,5'd0,6'b100011};//subu
 mem[20][31:0]={6'b011111,5'd0,5'd4,5'd8,5'b10000,6'b100000};//seb rd rt
 mem[24][31:0]={6'd0,5'd1,5'd4,5'd9,5'd0,6'b100111};//nor rd,rs,rt
 mem[28][31:0]={6'b001110,5'd1,5'd10,16'd511};//xori rt,rs,imm
 mem[32][31:0]={6'b011100,5'd1,5'd0,5'd11,5'd0,6'b100001};//clo rd,rs
 mem[36][31:0]={6'b011100,5'd1,5'd0,5'd12,5'd0,6'b100000};//clz rd,rs
 mem[40][31:0]={6'd0,5'd12,5'd30,5'd13,5'd0,6'b000111};//srav rd,rt,rs,算术右移22位，（12）为22
 mem[44][31:0]={6'd0,4'd0,1'b1,5'd31,5'd14,5'd5,6'b000010};//rotr rd,rt,shamt，循环右移
 mem[48][31:0]={6'd0,5'd1,5'd5,5'd15,5'd0,6'b101011};//sltu rd,rs,rt
 mem[52][31:0]={6'b001010,5'd4,5'd16,16'd2047};//slti rt,rs,imm
 mem[56][31:0]={6'b000010,26'd18};//j target,跳转到18*4=72的位置
 mem[72][31:0]={6'b001000,5'd30,5'd17,16'h00ff};//addi,检验Overflow
 mem[76][31:0]={6'b011100,5'd1,5'd0,5'd18,5'd0,6'b100000};//clz rd,rs
 mem[80][31:0]={6'b000001,5'd1,5'b10001,16'd4};//bgezal rs,offset，跳转到80+4*4+4=100位置
 mem[100][31:0]={6'b001111,5'd0,5'd19,16'h1f31};//lui rt,imm
 mem[104][31:0]={6'b100010,5'd0,5'd20,16'd4};//lwl rt,offset(base) 0号寄存器内容加上4
 mem[108][31:0]={6'b100011,5'd0,5'd21,16'd8};//lw rt,offset(base) 0号寄存器内容加上8
 mem[112][31:0]={6'b101011,5'd0,5'd20,16'd116};//sw rt,offset(rs)  0号寄存器内容加上116，执行20寄存器内容指令，即为mem[4]指令
 mem[120][31:0]={6'b101110,5'd0,5'd21,16'd124};//swr rt,offset(rs)  0号寄存器内容加上124，执行21寄存器内容指令，即为mem[8]指令
end
always @(negedge clk)
begin
	if(Mem_byte_wr_in3[3]==1&&jishu)//写内容，高有效
		mem[WBdata2][31:24]=Memdata2[31:24];
	else
		data_out[31:24]=mem[WBdata2][31:24];
	if(Mem_byte_wr_in3[2]==1&&jishu)//写内容，高有效
		mem[WBdata2][23:16]=Memdata2[23:16];
	else
		data_out[23:16]=mem[WBdata2][23:16];
	if(Mem_byte_wr_in3[1]==1&&jishu)//写内容，高有效
		mem[WBdata2][15:8]=Memdata2[15:8];
	else
		data_out[15:8]=mem[WBdata2][15:8];
	if(Mem_byte_wr_in3[0]==1&&jishu)//写内容，高有效
		mem[WBdata2][7:0]=Memdata2[7:0];
	else
		data_out[7:0]=mem[WBdata2][7:0];
	data_out=mem[WBdata2];
end
endmodule






module MemoutputShift(CacheOp3,Mem_data_out,Mem_addr_in[1:0],Mem_data_shift);//数据存储器输出移位器
input [2:0]CacheOp3;//控制信号
input [31:0]Mem_data_out;
input [1:0]Mem_addr_in;
reg [31:0]Mem_d_r;//由Mem_addr_in片选出来
reg [31:0]Mem_d_l;//由Mem_addr_in片选出来
output reg [31:0]Mem_data_shift;
always @(*)
begin
case(Mem_addr_in)
2'd0:
begin
Mem_d_l[31:0]=Mem_data_out[31:0];//相当于左移
Mem_d_r[31:0]={24'd0,Mem_data_out[31:24]};//相当于左移
end
2'd1:
begin
Mem_d_l[31:0]={Mem_data_out[23:0],8'd0};
Mem_d_r[31:0]={16'd0,Mem_data_out[31:16]};
end
2'd2:
begin
Mem_d_l[31:0]={Mem_data_out[15:0],16'd0};
Mem_d_r[31:0]={8'd0,Mem_data_out[31:8]};
end
2'd3:
begin
Mem_d_l[31:0]={Mem_data_out[7:0],8'd0};
Mem_d_r[31:0]=Mem_data_out;
end
endcase
case(CacheOp3)
3'd0:
begin
if(Mem_d_l[31]==0)
	Mem_data_shift={24'd0,Mem_d_l[31:24]};
else
	Mem_data_shift={24'd1,Mem_d_l[31:24]};
end
3'd1:
begin
	Mem_data_shift={24'd0,Mem_d_l[31:24]};
end
3'd2:
begin
if(Mem_d_l[31]==0)
	Mem_data_shift={16'd0,Mem_d_l[31:16]};
else
	Mem_data_shift={16'd1,Mem_d_l[31:16]};
end
3'd3:
	Mem_data_shift={16'd0,Mem_d_l[31:16]};
3'd4,3'd5:
	Mem_data_shift=Mem_d_l;
3'd6:
	Mem_data_shift=Mem_d_r;
3'd7:
	Mem_data_shift=32'd0;
endcase
end
endmodule




module get_right_MEM(Choice3,data_out,Mem_data_shift,right_Mem);//由Choice选择正确的数据存储器输出
input Choice3;
input [31:0]data_out;
input [31:0]Mem_data_shift;
output reg [31:0]right_Mem;
always @(*)
begin
if(Choice3==0)
	right_Mem=data_out;
else
	right_Mem=Mem_data_shift;
end
endmodule

module RegoutputShift(MemOp3,Rt_out,Mem_addr_in,Rt_out_shift);//寄存器输出移位器
input [2:0]MemOp3;
input [31:0]Rt_out;
input [1:0]Mem_addr_in;
output reg [31:0]Rt_out_shift;
reg [31:0]Rt_out_r;//由Mem_addr_in片选出来
reg [31:0]Rt_out_l;//由Mem_addr_in片选出来
always @(*)
begin
case(Mem_addr_in)
2'd0:
begin
Rt_out_l[31:0]=Rt_out[31:0];//相当于右移
Rt_out_r[31:0]={Rt_out[7:0],24'd0};//相当于右移
end
2'd1:
begin
Rt_out_l[31:0]={8'd0,Rt_out[31:8]};
Rt_out_r[31:0]={Rt_out[15:0],16'd0};
end
2'd2:
begin
Rt_out_l[31:0]={16'd0,Rt_out[31:16]};
Rt_out_r[31:0]={Rt_out[23:16],8'd0};
end
2'd3:
begin
Rt_out_l[31:0]={24'd0,Rt_out[31:24]};
Rt_out_r[31:0]=Rt_out;
end
endcase
case(MemOp3)
3'd0:
	Rt_out_shift[31:0]={Rt_out[7:0],Rt_out[7:0],Rt_out[7:0],Rt_out[7:0]};
3'd1:
	Rt_out_shift[31:0]=32'd0;
3'd2:
	Rt_out_shift[31:0]={Rt_out[15:8],Rt_out[7:0],Rt_out[15:8],Rt_out[7:0]};
3'd3:
	Rt_out_shift[31:0]=32'd0;
3'd4,3'd5:
	Rt_out_shift[31:0]=Rt_out_l[31:0];
3'd6:
	Rt_out_shift[31:0]=Rt_out_r[31:0];
3'd7:
	Rt_out_shift[31:0]=32'd0;
endcase
end
endmodule


module MEM_WB(clk,WBtype3,Regwr3,right_Mem,WBdata2,MemRead3,Rd_addr2,Rd_enable2,WriteData,WriteReg,Rd_write_byte_en,Regwr4,WBtype4);//MEM、WB流水段寄存器
input clk;
input [3:0]WBtype3;
input [31:0]right_Mem,WBdata2;
input Regwr3;
input MemRead3;
input [4:0]Rd_addr2;
input [3:0]Rd_enable2;
output reg [3:0]WBtype4;
output reg Regwr4;
output reg [4:0]WriteReg;
output reg [31:0]WriteData;
output reg [3:0]Rd_write_byte_en;
always @(posedge clk)
begin
	if(MemRead3==0)
		WriteData=WBdata2;
	else
		WriteData=right_Mem;
	WBtype4=WBtype3;
	Regwr4=Regwr3;
	WriteReg=Rd_addr2;
	Rd_write_byte_en=Rd_enable2;
end
endmodule


module Zhuanfa_unit(Rs2,Rt2,Rd_addr2,WriteReg,Regwr3,Regwr4,ALUSrc,ALUSrcA,ALUSrcB,newOperandB_src);//转发单元
input [4:0]Rs2,Rt2;
input [4:0]Rd_addr2,WriteReg;
input Regwr3,Regwr4;
input ALUSrc;
output reg[1:0]ALUSrcA,ALUSrcB;
output reg [1:0]newOperandB_src;
reg A1,B1,A2,B2;
always @(*)
begin
A1=Regwr3&(Rd_addr2!=5'd0)&(Rd_addr2==Rs2);
B1=Regwr3&(Rd_addr2!=5'd0)&(Rd_addr2==Rt2);
A2=Regwr4&(WriteReg!=5'd0)&(Rd_addr2!=Rs2)&(WriteReg==Rs2);
B2=Regwr4&(WriteReg!=5'd0)&(Rd_addr2!=Rt2)&(WriteReg==Rt2);
if(B1==1)
	newOperandB_src=2'b01;
else if(B2==1)
	newOperandB_src=2'b10;
else
	newOperandB_src=2'b00;
if(A1==1)
	ALUSrcA=2'b01;
else if(A2==1)
	ALUSrcA=2'b10;
else
	ALUSrcA=2'b00;
if(ALUSrc==1)//注意先后顺序，有区别,此时为立即数情况
	ALUSrcB=2'b11;
else if(B1==1)
	ALUSrcB=2'b01;
else if(B2==1)
	ALUSrcB=2'b10;
else
	ALUSrcB=2'b00;
end
endmodule


module return_PC_in(add_pc,Jump_addr,branch_addr2,PC_src,PC_in);//反馈PC_in
input [31:0]add_pc;
input [31:0]Jump_addr,branch_addr2;
input [1:0]PC_src;
output reg[31:0]PC_in;
always @(*)
begin
case(PC_src)
2'b00:
	PC_in=add_pc+4;
2'b01:
	PC_in=Jump_addr;
2'b10:
	PC_in=branch_addr2;
default:
	PC_in=add_pc;
endcase
end
endmodule


module test_risk(clk,Jump2,branch3,Condition2,Less,Zero,PC_src,Regwrite,Memwrite);//冒险检测
input clk;
input Jump2,branch3;
input Less,Zero;
input [2:0]Condition2;
output reg [1:0]PC_src;
output reg Regwrite;
output reg Memwrite;
initial
begin
	PC_src=2'b00;
	Regwrite=1;//1写入
	Memwrite=1;//1写入
end
reg result;
always @(negedge clk)
begin
case(Condition2)
3'd0:
result=0;
3'd1:
result=Zero;
3'd2:
result=!Zero;
3'd3:
result=!Less;
3'd4:
result=!(Less^Zero);
3'd5:
result=(Less^Zero);
3'd6:
result=Less;
3'd7:
result=1;
endcase
if(Jump2==1)
begin
	PC_src=2'b01;
	Regwrite=0;//1写入
	Memwrite=0;//1写入
end
else if(branch3==1&&result)
begin
	PC_src=2'b10;
	Regwrite=0;//1写入
	Memwrite=0;//1写入
end
else
begin
	PC_src=2'b00;
	Regwrite=1;//1写入
	Memwrite=1;//1写入
end
end
endmodule 

module output_fangcun_lastanswer(WBdata2,right_Mem,MemRead3,right_answer);//访存阶段最后数据答案
input [31:0]WBdata2;
input [31:0]right_Mem;
input MemRead3;
output reg [31:0]right_answer;
always @(*)
begin
if(MemRead3==0)
	right_answer=WBdata2;
else
	right_answer=right_Mem;
end
endmodule

module jishu_enable(clk,Memwrite,jishu);//用于冒险时锁存的时钟数计数
input clk;
input Memwrite;
reg [2:0]tag;
output reg jishu;
initial 
begin
	jishu=1;//可写入
	tag=3'd0;
end
always @(posedge clk)
begin
	if(Memwrite==0)
	begin
		tag=3'd3;
	end
	else if(tag>0)
		tag=tag-1;
	else if(tag==0)
		tag=3'd0;
	if(tag==3'd0)
		jishu=1;
	else
		jishu=0;
end
endmodule

module jishu_r_enable(clk,Regwrite,jishu2);//用于冒险的寄存器组的锁的时钟计数
input clk;
input Regwrite;
output reg jishu2;
reg [2:0]tag;
initial 
begin
	jishu2=1;//可写入
	tag=3'd0;
end
always @(posedge clk)
begin
	if(Regwrite==0)
	begin
		tag=3'd1;
	end
	else if(tag>0)
		tag=tag+1;
	else if(tag==0)
		tag=3'd0;
	if(tag>=3'd0&&tag<3'd3)
		jishu2=1;
	else if(tag<3'd5)
		jishu2=0;
	else
		begin
			jishu2=1;
			tag=3'd0;
		end
end
endmodule

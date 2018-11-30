module	skin_detect	(
						//Input
						input					iClk,
						input					iReset_n,
						input					iInput_ready,
						input		[15:0]		iRGB,
						//Output
						output	reg	[12:0]		oAddr_SM,
						output	reg				oWrreq_SM,
						output					oData_out
					);
					
//===================================REGISTERS=======================================
reg		[7:0]	r_reg;
reg		[7:0]	g_reg;
reg		[7:0]	b_reg;
reg		[7:0]	max_reg;
reg		[7:0]	min_reg;
reg		[1:0]	flag;
reg		[6:0]	cond0_reg;
//=====================================WIRES=========================================
wire	[7:0]	r = {iRGB[15:11],3'b0};
wire	[7:0]	g = {iRGB[10:5],2'b0};
wire	[7:0]	b = {iRGB[4:0],3'b0};

wire	[7:0]	max;
wire	[7:0]	min;
wire	[7:0]	max_sub_min;
wire	[7:0]	r_sub_g;
wire	[4:0]	cond0;
wire			cond1;
wire			cond2;
wire			cond3;
wire			cond4;
wire			cond5;
//===================================================================================
assign	cond0[3]	=	r_reg > g_reg;
assign	cond0[4]	=	r_reg > b_reg;
assign	cond1		=	g_reg > b_reg;
assign	cond2		=	cond0[3] & cond0[4];
assign	cond3		=	~(cond0[3] & cond0[4]) & (~cond0[3] & cond1);
assign	max			=	(cond2) ? r_reg : (cond3) ? g_reg : b_reg;
assign	min			=	((cond2 & cond1) || (cond3 & cond0[4])) ? b_reg : (cond0[3]) ? g_reg : r_reg;

assign	max_sub_min	= 	max_reg - min_reg;
assign	r_sub_g		=	(cond0[3]) ? (r_reg - g_reg) : (g_reg - r_reg);

assign	cond0[0]	=	r_reg > 8'd95;
assign	cond0[1]	=	g_reg > 8'd40;
assign	cond0[2]	=	b_reg > 8'd20;

assign	cond4		=	max_sub_min > 8'd15;
assign	cond5		=	r_sub_g > 8'd15;

assign	oData_out	=	&cond0_reg;
//===================================================================================
always	@	(posedge iClk)
if (~iReset_n)
begin
	r_reg		<=	8'b0;
	g_reg		<=	8'b0;
	b_reg		<=	8'b0;
	flag		<=	2'b0;
	oAddr_SM	<=	13'b0;
	oWrreq_SM	<=	1'b0;
end
else
begin
	max_reg			<=	max;
	min_reg			<=	min;
	cond0_reg[4:0]	<=	cond0;
	cond0_reg[5]	<=	cond4;
	cond0_reg[6]	<=	cond5;

	if (iInput_ready)
	begin
		r_reg	<=	r;
		g_reg	<=	g;
		b_reg	<=	b;
	end
	
	flag[0]	<=	iInput_ready;
	flag[1]	<=	flag[0];
	oWrreq_SM	<=	flag[1];

	if (oWrreq_SM)
		oAddr_SM	<=	oAddr_SM + 1'b1;
end
					
endmodule

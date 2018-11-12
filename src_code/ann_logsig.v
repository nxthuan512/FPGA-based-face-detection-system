module	ann_logsig	(
						//Input
						input						iClk,
						input						iReset_n,
						input						iInput_ready,
						input			[31:0]		iData_in,
						//Output
						output	reg					oOutput_ready,
						output	reg		[31:0]		oData_out
					);

//=================================REGISTERS===============================
reg		[31:0]		data_in_reg;
reg		[3:0]		sign_reg;
reg		[9:0]		cond_reg;
reg		[9:0]		cond_reg_0;
reg		[31:0]		pre_data_out_reg;
reg		[2:0]		inputready_reg;
reg		[49:0]		pre_data_out_0_reg;
reg		[50:0]		pre_data_out_1_reg;
reg		[50:0]		pre_data_out_2_reg;
reg		[50:0]		pre_data_out_3_reg;
reg		[50:0]		pre_data_out_4_reg;
reg		[50:0]		pre_data_out_5_reg;
reg		[50:0]		pre_data_out_6_reg;
reg		[50:0]		pre_data_out_7_reg;
reg		[50:0]		pre_data_out_8_reg;
reg		[31:0]		data_out_0_reg;
reg		[31:0]		data_out_1_reg;
reg		[31:0]		data_out_2_reg;
reg		[31:0]		data_out_3_reg;
reg		[31:0]		data_out_4_reg;
reg		[31:0]		data_out_5_reg;
reg		[31:0]		data_out_6_reg;
reg		[31:0]		data_out_7_reg;
reg		[31:0]		data_out_8_reg;
//===================================WIRES=================================
wire	[31:0]		data_in;

wire				cond0;
wire				cond1;
wire				cond2;
wire				cond3;
wire				cond4;
wire				cond5;
wire				cond6;
wire				cond7;
wire				cond8;
wire				cond9;

wire	[49:0]		pre_data_out_0;
wire	[50:0]		pre_data_out_1;
wire	[50:0]		pre_data_out_2;
wire	[50:0]		pre_data_out_3;
wire	[50:0]		pre_data_out_4;
wire	[50:0]		pre_data_out_5;
wire	[50:0]		pre_data_out_6;
wire	[50:0]		pre_data_out_7;
wire	[50:0]		pre_data_out_8;

wire	[31:0]		pre_data_out;
wire	[31:0]		data_out;
wire	[31:0]		data_out_0;
wire	[31:0]		data_out_1;
wire	[31:0]		data_out_2;
wire	[31:0]		data_out_3;
wire	[31:0]		data_out_4;
wire	[31:0]		data_out_5;
wire	[31:0]		data_out_6;
wire	[31:0]		data_out_7;
wire	[31:0]		data_out_8;

wire	[49:0]		idata_shl_18	=	{data_in_reg,18'b0};
wire	[48:0]		idata_shl_17	=	{data_in_reg,17'b0};
wire	[47:0]		idata_shl_16	=	{data_in_reg,16'b0};
wire	[46:0]		idata_shl_15	=	{data_in_reg,15'b0};
wire	[44:0]		idata_shl_13	=	{data_in_reg,13'b0};
wire	[43:0]		idata_shl_12	=	{data_in_reg,12'b0};
wire	[41:0]		idata_shl_10	=	{data_in_reg,10'b0};
wire	[39:0]		idata_shl_8		=	{data_in_reg,8'b0};
wire	[38:0]		idata_shl_7		=	{data_in_reg,7'b0};
wire	[37:0]		idata_shl_6		=	{data_in_reg,6'b0};
wire	[36:0]		idata_shl_5		=	{data_in_reg,5'b0};
wire	[35:0]		idata_shl_4		=	{data_in_reg,4'b0};
wire	[34:0]		idata_shl_3		=	{data_in_reg,3'b0};
wire	[33:0]		idata_shl_2		=	{data_in_reg,2'b0};
wire	[32:0]		idata_shl_1		=	{data_in_reg,1'b0};

wire	[47:0]		idata_15_add_10;
wire	[44:0]		idata_13_sub_6;
wire	[38:0]		idata_6_add_5;
wire	[39:0]		idata_7_add_2;
wire	[49:0]		idata_15_add_13_add_10_sub_6_add_4;
//=========================================================================
assign	idata_15_add_10	=	idata_shl_15 + idata_shl_10;
assign	idata_13_sub_6	=	idata_shl_13 - idata_shl_6;
assign	idata_6_add_5	=	idata_shl_6 + idata_shl_5;
assign	idata_7_add_2	=	idata_shl_7 + idata_shl_2;
assign	idata_15_add_13_add_10_sub_6_add_4	=	(idata_15_add_10 + idata_13_sub_6) + idata_shl_4;

//(0:0.5) 			y=0.25*x + 0.5
assign	pre_data_out_0	=	idata_shl_18;
assign	data_out_0		=	pre_data_out_0_reg[46:16] + 24'h800000;

//(0.5:1)			y=0.2179*x + 0.5156
assign	pre_data_out_1	=	((idata_shl_18 - idata_15_add_10) + (idata_shl_7 + idata_shl_2));
assign	data_out_1		=	pre_data_out_1_reg[46:16] + 24'h83FE5C;

//(1:1.6875)		y=0.164*x + 0.5727
assign	pre_data_out_2	=	((idata_shl_17 + idata_shl_15) + (idata_13_sub_6 + idata_shl_1));
assign	data_out_2		=	pre_data_out_2_reg[46:16] + 24'h929C77;

//(1.6875:2.375)	y=0.1025*x + 0.6758
assign	pre_data_out_3	=	((idata_shl_16 + idata_15_add_13_add_10_sub_6_add_4) + (idata_shl_3 + data_in_reg));
assign	data_out_3		=	pre_data_out_3_reg[46:16] + 24'hAD013A;

//(2.375:3.6875)	y=0.0439*x + 0.8208
assign	pre_data_out_4	=	(idata_15_add_13_add_10_sub_6_add_4 + idata_shl_12);
assign	data_out_4		=	pre_data_out_4_reg[46:16] + 24'hD21FF2;

//(3.6875:5)		y=0.0126*x + 0.9323
assign	pre_data_out_5	=	((idata_shl_13 + idata_shl_12) + (idata_shl_10 - idata_7_add_2)) + idata_shl_5;
assign	data_out_5		=	pre_data_out_5_reg[46:16] + 24'hEEAB36;

//(5:6)				y=0.004*x + 0.9739
assign	pre_data_out_6	=	(idata_shl_12 + idata_6_add_5) + idata_shl_1;
assign	data_out_6		=	pre_data_out_6_reg[46:16] + 24'hF95182;

//(6:7.375)			y=0.0012*x + 0.9906
assign	pre_data_out_7	=	(idata_shl_10 + idata_shl_8) + (idata_shl_3 - idata_shl_5) + idata_shl_1;
assign	data_out_7		=	pre_data_out_7_reg[46:16] + 24'hFD97F6;

//(7.375:10)		y=0.0001*x + 0.9984
assign	pre_data_out_8	=	idata_6_add_5 + idata_shl_3;
assign	data_out_8		=	pre_data_out_8_reg[46:16] + 24'hFF9724;
//=========================================================================
assign	data_in	=	(iData_in[31]) ? (~iData_in + 1) : iData_in;

assign	cond0	=	~|data_in_reg;
assign	cond1	=	~|data_in_reg[31:19];//32'h80000
assign	cond2	=	~|data_in_reg[31:20];//32'h100000
assign	cond3	=	data_in_reg[31:16] <  16'h1B;
assign	cond4	=	data_in_reg[31:16] <  16'h26;
assign	cond5	=	data_in_reg[31:16] <  16'h3B;
assign	cond6	=	data_in_reg[31:20] <  12'h5;
assign	cond7	=	data_in_reg[31:20] <  12'h6;
assign	cond8	=	data_in_reg[31:16] <  16'h76;
assign	cond9	=	data_in_reg[31:20] <  16'hA;

assign	pre_data_out	=	(cond_reg_0[0]) ? 32'h800000
									: (cond_reg_0[1]) ? data_out_0_reg
									: (cond_reg_0[2]) ? data_out_1_reg
									: (cond_reg_0[3]) ? data_out_2_reg
									: (cond_reg_0[4]) ? data_out_3_reg
									: (cond_reg_0[5]) ? data_out_4_reg
									: (cond_reg_0[6]) ? data_out_5_reg
									: (cond_reg_0[7]) ? data_out_6_reg
									: (cond_reg_0[8]) ? data_out_7_reg
									: (cond_reg_0[9]) ? data_out_8_reg : 32'h1000000;
assign	data_out		=	(sign_reg[3]) ? (32'h1000001 + ~pre_data_out_reg) : pre_data_out_reg;
//=========================================================================
always	@ (posedge iClk)
if (~iReset_n)
begin
	data_in_reg			<=	32'b0;
	sign_reg			<=	4'b0;
	inputready_reg		<=	3'b0;
	pre_data_out_reg	<=	32'b0;
	pre_data_out_0_reg	<=	50'b0;
	pre_data_out_1_reg	<=	51'b0;
	pre_data_out_2_reg	<=	51'b0;
	pre_data_out_3_reg	<=	51'b0;
	pre_data_out_4_reg	<=	51'b0;
	pre_data_out_5_reg	<=	51'b0;
	pre_data_out_6_reg	<=	51'b0;
	pre_data_out_7_reg	<=	51'b0;
	pre_data_out_8_reg	<=	51'b0;
	data_out_0_reg		<=	32'b0;
	data_out_1_reg		<=	32'b0;
	data_out_2_reg		<=	32'b0;
	data_out_3_reg		<=	32'b0;
	data_out_4_reg		<=	32'b0;
	data_out_5_reg		<=	32'b0;
	data_out_6_reg		<=	32'b0;
	data_out_7_reg		<=	32'b0;
	data_out_8_reg		<=	32'b0;
	cond_reg			<=	10'b0;
	oData_out			<=	32'b0;
	oOutput_ready		<=	1'b0;
end
else
begin
	pre_data_out_reg	<=	pre_data_out;
	inputready_reg[0]	<=	iInput_ready;
	inputready_reg[1]	<=	inputready_reg[0];
	inputready_reg[2]	<=	inputready_reg[1];
	oOutput_ready		<=	inputready_reg[2];
	
	pre_data_out_0_reg	<=	pre_data_out_0;
	pre_data_out_1_reg	<=	pre_data_out_1;
	pre_data_out_2_reg	<=	pre_data_out_2;
	pre_data_out_3_reg	<=	pre_data_out_3;
	pre_data_out_4_reg	<=	pre_data_out_4;
	pre_data_out_5_reg	<=	pre_data_out_5;
	pre_data_out_6_reg	<=	pre_data_out_6;
	pre_data_out_7_reg	<=	pre_data_out_7;
	pre_data_out_8_reg	<=	pre_data_out_8;
	
	data_out_0_reg	<=	data_out_0;
	data_out_1_reg	<=	data_out_1;
	data_out_2_reg	<=	data_out_2;
	data_out_3_reg	<=	data_out_3;
	data_out_4_reg	<=	data_out_4;
	data_out_5_reg	<=	data_out_5;
	data_out_6_reg	<=	data_out_6;
	data_out_7_reg	<=	data_out_7;
	data_out_8_reg	<=	data_out_8;
	
	sign_reg[1]	<=	sign_reg[0];
	sign_reg[2]	<=	sign_reg[1];
	sign_reg[3]	<=	sign_reg[2];
	
	cond_reg	<=	{cond9,cond8,cond7,cond6,cond5,cond4,cond3,cond2,cond1,cond0};
	cond_reg_0	<=	cond_reg;
	
	if (iInput_ready)
	begin
		data_in_reg		<=	data_in;
		sign_reg[0]		<=	iData_in[31];
	end
		
	if (oOutput_ready)
		oData_out		<=	data_out;
end

endmodule

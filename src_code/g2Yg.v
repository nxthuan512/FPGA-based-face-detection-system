module g2Yg (
				input				iClk,
				input				iReset_n,
				input		[7:0]	iG,
				output		[7:0]	oYG
			);

//====================REGISTERS==================
reg		[7:0]		s1_iG;
//======================WIRES====================
wire	[23:0]		yg;
//===============================================
//	Pre-Calculate
//===============================================
wire	[22:0]		G_shl_15	=	{s1_iG,15'b0};
wire	[19:0]		G_shl_12	=	{s1_iG,12'b0};
wire	[17:0]		G_shl_10	=	{s1_iG,10'b0};
wire	[16:0]		G_shl_9		=	{s1_iG,9'b0};
wire	[13:0]		G_shl_6		=	{s1_iG,6'b0};
wire	[9:0]		G_shl_2		=	{s1_iG,2'b0};
wire	[8:0]		G_shl_1		=	{s1_iG,1'b0};
//===============================================
//	COMBINATION
//===============================================
assign	yg  = ((G_shl_15 + G_shl_12) + (G_shl_10 + G_shl_9)) + ((G_shl_6 + G_shl_2) + G_shl_1);
assign	oYG = yg[23:16];
//===============================================
//	SEQUENCE
//===============================================
always @ (posedge iClk)
	if (~iReset_n)
		s1_iG <= 8'h0;
	else
		s1_iG <= iG;

endmodule

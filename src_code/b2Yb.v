module b2Yb (
				input				iClk,
				input				iReset_n,
				input		[7:0]	iB,
				output		[4:0]	oYB
			);

//====================REGISTERS==================
reg		[7:0]		s1_iB;
//===============================================
//======================WIRES====================
wire	[20:0]		yb;
//	Pre-Calculate
//===============================================
wire	[20:0]		B_shl_13	=	{s1_iB,13'b0};
wire	[17:0]		B_shl_10	=	{s1_iB,10'b0};
wire	[15:0]		B_shl_8		=	{s1_iB,8'b0};
wire	[12:0]		B_shl_5		=	{s1_iB,5'b0};
wire	[11:0]		B_shl_4		=	{s1_iB,4'b0};
wire	[8:0]		B_shl_1		=	{s1_iB,1'b0};
//===============================================
//	COMBINATION
//===============================================
assign	yb  = ((B_shl_13 - B_shl_10) + (B_shl_8 + B_shl_5)) + (B_shl_4 - B_shl_1);
assign	oYB = yb[20:16];
//===============================================
//	SEQUENCE
//===============================================
always @ (posedge iClk)
	if (~iReset_n)
		s1_iB <= 8'h0;
	else
		s1_iB <= iB;

endmodule

module r2Yr (
				input				iClk,
				input				iReset_n,
				input		[7:0]	iR,
				output		[6:0]	oYR
			);

//====================REGISTERS==================
reg		[7:0]		s1_iR;
//======================WIRES====================
wire	[22:0]		yr;
//===============================================
//	Pre-Calculate
//===============================================
wire	[21:0]		R_shl_14	=	{s1_iR,14'b0};
wire	[18:0]		R_shl_11	=	{s1_iR,11'b0};
wire	[17:0]		R_shl_10	=	{s1_iR,10'b0};
wire	[14:0]		R_shl_7		=	{s1_iR,7'b0};
wire	[10:0]		R_shl_3		=	{s1_iR,3'b0};
wire	[8:0]		R_shl_1		=	{s1_iR,1'b0};
//===============================================
//	COMBINATION
//===============================================
assign	yr  = ((R_shl_14 + R_shl_11) + (R_shl_10 + R_shl_7)) + ((R_shl_3 + R_shl_1) + s1_iR);
assign	oYR = yr[22:16];
//===============================================
//	SEQUENCE
//===============================================
always @ (posedge iClk)
	if (~iReset_n)
		s1_iR <= 8'h0;
	else
		s1_iR <= iR;

endmodule

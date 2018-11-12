module	detection_17x17	(
							//Input
							input						iClk,
							input						iReset_n,
							input						iReady_HFG,
							input						iRun_HFG,
							input						iRun_ANN,
							input			[12:0]		iAddr_OM,
							input			[83:0]		i4Rec0,
							input			[83:0]		i4Rec1,
							input			[83:0]		i4Rec2,
							input			[83:0]		i4Rec3,
							input			[83:0]		i4Rec4,
							input			[83:0]		i4Rec5,
							input			[83:0]		i4Rec6,
							input			[83:0]		i4Rec7,
							//Output
							output			[8:0]		oAddr_IIBG,
							output						oRdreq_IIBG,
							output						oFull,
							output						oFull_FBR,
							output						oFinish,
							output						oWrreq_OM,
							output			[12:0]		oAddr_OM,
							output			[31:0]		oData_out,
							output						oFinish_Stage,
							output						oPass
						);

//==================================WIRES===========================================
wire		[6:0]		w_addr_fbram;
wire		[6:0]		r_addr_fbram;
wire					wr_fbram;
wire		[31:0]		w_feature;
wire		[31:0]		r_feature;
//==================================================================================
assign	oAddr_OM	=	iAddr_OM;
//==================================================================================
hfg_17x17	HAAR_FEATURE_GENERATION	(
										//Input
										.iClk					(iClk),
										.iReset_n				(iReset_n),
										.iReady					(iReady_HFG),
										.iRun					(iRun_HFG),
										.i4Rec0					(i4Rec0),
										.i4Rec1					(i4Rec1),	
										.i4Rec2					(i4Rec2),
										.i4Rec3					(i4Rec3),
										.i4Rec4					(i4Rec4),
										.i4Rec5					(i4Rec5),
										.i4Rec6					(i4Rec6),
										.i4Rec7					(i4Rec7),
										//Output
										.oAddr_IIBG				(oAddr_IIBG),
										.oRdreq_IIBG			(oRdreq_IIBG),
										.oFull					(oFull),
										.oFinish				(oFinish),
										.oWrreq_FBR				(wr_fbram),
										.oAddr_FBR				(w_addr_fbram),
										.oFull_FBR				(oFull_FBR),
										.oFeature				(w_feature)
									);

fbram FEATUER_BRAM					(
										.clock					(iClk),
										.data					(w_feature),
										.rdaddress				(r_addr_fbram),
										.wraddress				(w_addr_fbram),
										.wren					(wr_fbram),
										.q						(r_feature)
									);

ann	ANN_CLASSFIER					(
										//Input
										.iClk					(iClk),
										.iReset_n				(iReset_n),
										.iRun_ANN				(iRun_ANN),
										.iFeature				(r_feature),
										//Output
										.oAddr_FBR				(r_addr_fbram),
										.oWrreq_OM				(oWrreq_OM),
										.oData_out				(oData_out),
										.oFinish_Stage			(oFinish_Stage),
										.oPass					(oPass)
									);

endmodule

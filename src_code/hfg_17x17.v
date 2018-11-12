module hfg_17x17	(
						//Input
						input						iClk,
						input						iReset_n,
						input						iReady,
						input						iRun,
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
						output						oFinish,
						output						oWrreq_FBR,
						output			[6:0]		oAddr_FBR,
						output						oFull_FBR,
						output			[31:0]		oFeature
					);
//============================WIRES========================================
wire		[7:0]		Sign;
wire		[20:0]		Rec0;
wire		[20:0]		Rec1;
wire		[20:0]		Rec2;
wire		[20:0]		Rec3;
wire		[20:0]		Rec4;
wire		[20:0]		Rec5;
wire		[20:0]		Rec6;
wire		[20:0]		Rec7;
wire					Wait;
wire		[20:0]		Pre_Feature;
//=========================================================================
assign		oWrreq_FBR = oFinish;
//=========================================================================
hfg_control_17x17	CONTROL_HFG 			(
												//Input
												.iClk						(iClk),
												.iReset_n					(iReset_n),
												.iReady						(iReady),
												.iRun						(iRun),
												//Output
												.oAddr_IIBG					(oAddr_IIBG),
												.oRdreq_IIBG				(oRdreq_IIBG),
												.oFinish					(oFinish),
												.oAddr_FBR					(oAddr_FBR),
												.oSign						(Sign),
												.oWait						(Wait),
												.oFull						(oFull),
												.oFull_FBR					(oFull_FBR)
											);
						
hfg_8wayrec	EIGHTWAYREC						(
												//Input	
												.iClk						(iClk),
												.iReset_n					(iReset_n),
												.iReady						(iReady),
												.iSign						(Sign),
												.i4Rec0						(i4Rec0),
												.i4Rec1						(i4Rec1),
												.i4Rec2						(i4Rec2),
												.i4Rec3						(i4Rec3),
												.i4Rec4						(i4Rec4),
												.i4Rec5						(i4Rec5),
												.i4Rec6						(i4Rec6),
												.i4Rec7						(i4Rec7),
												//Output
												.oRec0						(Rec0),
												.oRec1						(Rec1),
												.oRec2						(Rec2),
												.oRec3						(Rec3),
												.oRec4						(Rec4),
												.oRec5						(Rec5),
												.oRec6						(Rec6),
												.oRec7						(Rec7)
											);
			
hfg_feature_composition COMPOSITION			(
												//Input
												.iClk						(iClk),
												.iReset_n					(iReset_n),
												.iWait						(Wait),
												.iRec0						(Rec0),
												.iRec1						(Rec1),
												.iRec2						(Rec2),
												.iRec3						(Rec3),
												.iRec4						(Rec4),
												.iRec5						(Rec5),
												.iRec6						(Rec6),
												.iRec7						(Rec7),
												//Output
												.oPre_Feature				(Pre_Feature)
											);
						
hfg_normalization_17x17 	NORMALIZATION	(
												//Input
												.iClk						(iClk),
												.iReset_n					(iReset_n),
												.iPre_Feature				(Pre_Feature),
												//Output
												.oFeature					(oFeature)
											);
											
endmodule

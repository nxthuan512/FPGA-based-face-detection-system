module	detection	(
						//Input
						input								iClk,
						input								iReset_n,
						input								iReady_HFG_23,
						input								iRun_HFG_23,
						input								iRun_ANN_23,
						input			[12:0]				iAddr_OM_23,
						input			[83:0]				i4Rec0_23,
						input			[83:0]				i4Rec1_23,
						input			[83:0]				i4Rec2_23,
						input			[83:0]				i4Rec3_23,
						input			[83:0]				i4Rec4_23,
						input			[83:0]				i4Rec5_23,
						input			[83:0]				i4Rec6_23,
						input			[83:0]				i4Rec7_23,
						input								iReady_HFG_19,
						input								iRun_HFG_19,
						input								iRun_ANN_19,
						input			[12:0]				iAddr_OM_19,
						input			[83:0]				i4Rec0_19,
						input			[83:0]				i4Rec1_19,
						input			[83:0]				i4Rec2_19,
						input			[83:0]				i4Rec3_19,
						input			[83:0]				i4Rec4_19,
						input			[83:0]				i4Rec5_19,
						input			[83:0]				i4Rec6_19,
						input			[83:0]				i4Rec7_19,
						input								iReady_HFG_17,
						input								iRun_HFG_17,
						input								iRun_ANN_17,
						input			[12:0]				iAddr_OM_17,
						input			[83:0]				i4Rec0_17,
						input			[83:0]				i4Rec1_17,
						input			[83:0]				i4Rec2_17,
						input			[83:0]				i4Rec3_17,
						input			[83:0]				i4Rec4_17,
						input			[83:0]				i4Rec5_17,
						input			[83:0]				i4Rec6_17,
						input			[83:0]				i4Rec7_17,
						//Output
						output			[9:0]				oAddr_IIBG_23,
						output								oRdreq_IIBG_23,
						output								oFull_23,
						output								oFull_FBR_23,
						output								oFinish_23,
						output								oWrreq_OM_23,
						output			[12:0]				oAddr_OM_23,
						output			[31:0]oData_out_23,
						output								oFinish_Stage_23,
						output								oPass_23,
						output			[8:0]				oAddr_IIBG_19,
						output								oRdreq_IIBG_19,
						output								oFull_19,
						output								oFull_FBR_19,
						output								oFinish_19,
						output								oWrreq_OM_19,
						output			[12:0]				oAddr_OM_19,
						output			[31:0]				oData_out_19,
						output								oFinish_Stage_19,
						output								oPass_19,
						output			[8:0]				oAddr_IIBG_17,
						output								oRdreq_IIBG_17	,
						output								oFull_17,
						output								oFull_FBR_17,
						output								oFinish_17,
						output								oWrreq_OM_17,
						output			[12:0]				oAddr_OM_17,
						output			[31:0]				oData_out_17,
						output								oFinish_Stage_17,
						output								oPass_17
					);

//====================================WIRES========================================

//=================================================================================
detection_23x23	DETECTION_23x23	(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iReady_HFG						(iReady_HFG_23),
									.iRun_HFG						(iRun_HFG_23),
									.iRun_ANN						(iRun_ANN_23),
									.iAddr_OM						(iAddr_OM_23),
									.i4Rec0							(i4Rec0_23),
									.i4Rec1							(i4Rec1_23),
									.i4Rec2							(i4Rec2_23),
									.i4Rec3							(i4Rec3_23),
									.i4Rec4							(i4Rec4_23),
									.i4Rec5							(i4Rec5_23),
									.i4Rec6							(i4Rec6_23),
									.i4Rec7							(i4Rec7_23),
									//Output
									.oAddr_IIBG						(oAddr_IIBG_23),
									.oRdreq_IIBG					(oRdreq_IIBG_23),
									.oFull							(oFull_23),
									.oFull_FBR						(oFull_FBR_23),
									.oFinish						(oFinish_23),
									.oWrreq_OM						(oWrreq_OM_23),
									.oAddr_OM						(oAddr_OM_23),
									.oData_out						(oData_out_23),
									.oFinish_Stage					(oFinish_Stage_23),
									.oPass							(oPass_23)
								);

detection_19x19	DETECTION_19x19	(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iReady_HFG						(iReady_HFG_19),
									.iRun_HFG						(iRun_HFG_19),
									.iRun_ANN						(iRun_ANN_19),
									.iAddr_OM						(iAddr_OM_19),
									.i4Rec0							(i4Rec0_19),
									.i4Rec1							(i4Rec1_19),
									.i4Rec2							(i4Rec2_19),
									.i4Rec3							(i4Rec3_19),
									.i4Rec4							(i4Rec4_19),
									.i4Rec5							(i4Rec5_19),
									.i4Rec6							(i4Rec6_19),
									.i4Rec7							(i4Rec7_19),
									//Output
									.oAddr_IIBG						(oAddr_IIBG_19),
									.oRdreq_IIBG					(oRdreq_IIBG_19),
									.oFull							(oFull_19),
									.oFull_FBR						(oFull_FBR_19),
									.oFinish						(oFinish_19),
									.oWrreq_OM						(oWrreq_OM_19),
									.oAddr_OM						(oAddr_OM_19),
									.oData_out						(oData_out_19),
									.oFinish_Stage					(oFinish_Stage_19),
									.oPass							(oPass_19)
								);
								
detection_17x17	DETECTION_17x17	(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iReady_HFG						(iReady_HFG_17),
									.iRun_HFG						(iRun_HFG_17),
									.iRun_ANN						(iRun_ANN_17),
									.iAddr_OM						(iAddr_OM_17),
									.i4Rec0							(i4Rec0_17),
									.i4Rec1							(i4Rec1_17),
									.i4Rec2							(i4Rec2_17),
									.i4Rec3							(i4Rec3_17),
									.i4Rec4							(i4Rec4_17),
									.i4Rec5							(i4Rec5_17),
									.i4Rec6							(i4Rec6_17),
									.i4Rec7							(i4Rec7_17),
									//Output
									.oAddr_IIBG						(oAddr_IIBG_17),
									.oRdreq_IIBG					(oRdreq_IIBG_17),
									.oFull							(oFull_17),
									.oFull_FBR						(oFull_FBR_17),
									.oFinish						(oFinish_17),
									.oWrreq_OM						(oWrreq_OM_17),
									.oAddr_OM						(oAddr_OM_17),
									.oData_out						(oData_out_17),
									.oFinish_Stage					(oFinish_Stage_17),
									.oPass							(oPass_17)
								);

endmodule

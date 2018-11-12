module	iibg	(
					//Input
					input					iClk,
					input					iReset_n,
					input		[2:0]		iRst_IIBG,
					input					iWrreq_to_IIBG_23x23,
					input					iWrreq_to_IIBG_19x19,
					input					iWrreq_to_IIBG_17x17,
					input					iRdreq_to_IIBG_23x23,
					input					iRdreq_to_IIBG_19x19,
					input					iRdreq_to_IIBG_17x17,
					input					iFull_23x23,
					input					iFull_19x19,
					input					iFull_17x17,
					input		[9:0]		iAddr_read_23x23,
					input		[8:0]		iAddr_read_19x19,
					input		[8:0]		iAddr_read_17x17,
					input		[20:0]		iData_to_IIBG,
					//Output
					output					oOutput_ready_23x23,
					output					oOutput_ready_19x19,
					output					oOutput_ready_17x17,
					output		[83:0]		oData0_23x23,
					output		[83:0]		oData1_23x23,
					output		[83:0]		oData2_23x23,
					output		[83:0]		oData3_23x23,
					output		[83:0]		oData4_23x23,
					output		[83:0]		oData5_23x23,
					output		[83:0]		oData6_23x23,
					output		[83:0]		oData7_23x23,
					output		[83:0]		oData0_19x19,
					output		[83:0]		oData1_19x19,
					output		[83:0]		oData2_19x19,
					output		[83:0]		oData3_19x19,
					output		[83:0]		oData4_19x19,
					output		[83:0]		oData5_19x19,
					output		[83:0]		oData6_19x19,
					output		[83:0]		oData7_19x19,
					output		[83:0]		oData0_17x17,
					output		[83:0]		oData1_17x17,
					output		[83:0]		oData2_17x17,
					output		[83:0]		oData3_17x17,
					output		[83:0]		oData4_17x17,
					output		[83:0]		oData5_17x17,
					output		[83:0]		oData6_17x17,
					output		[83:0]		oData7_17x17
				);
//==================================WIRES=====================================

//============================================================================
iibg_23x23	IIBG_23x23	(
							//Input	
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.iRst					(iRst_IIBG[0]),
							.iRdreq					(iRdreq_to_IIBG_23x23),
							.iFull					(iFull_23x23),
							.iWrreq					(iWrreq_to_IIBG_23x23),
							.iAddr_read				(iAddr_read_23x23),
							.iData_in				(iData_to_IIBG),
							//Output
							.oFull					(),
							.oReady					(oOutput_ready_23x23),
							.oData0					(oData0_23x23),
							.oData1					(oData1_23x23),
							.oData2					(oData2_23x23),
							.oData3					(oData3_23x23),
							.oData4					(oData4_23x23),
							.oData5					(oData5_23x23),
							.oData6					(oData6_23x23),
							.oData7					(oData7_23x23)
						);

iibg_19x19	IIBG_19x19	(
							//Input	
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.iRst					(iRst_IIBG[1]),
							.iRdreq					(iRdreq_to_IIBG_19x19),
							.iFull					(iFull_19x19),
							.iWrreq					(iWrreq_to_IIBG_19x19),
							.iAddr_read				(iAddr_read_19x19),
							.iData_in				(iData_to_IIBG),
							//Output
							.oFull					(),
							.oReady					(oOutput_ready_19x19),
							.oData0					(oData0_19x19),
							.oData1					(oData1_19x19),
							.oData2					(oData2_19x19),
							.oData3					(oData3_19x19),
							.oData4					(oData4_19x19),
							.oData5					(oData5_19x19),
							.oData6					(oData6_19x19),
							.oData7					(oData7_19x19)
						);

iibg_17x17	IIBG_17x17	(
							//Input	
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.iRst					(iRst_IIBG[2]),
							.iRdreq					(iRdreq_to_IIBG_17x17),
							.iFull					(iFull_17x17),
							.iWrreq					(iWrreq_to_IIBG_17x17),
							.iAddr_read				(iAddr_read_17x17),
							.iData_in				(iData_to_IIBG),
							//Output
							.oFull					(),
							.oReady					(oOutput_ready_17x17),
							.oData0					(oData0_17x17),
							.oData1					(oData1_17x17),
							.oData2					(oData2_17x17),
							.oData3					(oData3_17x17),
							.oData4					(oData4_17x17),
							.oData5					(oData5_17x17),
							.oData6					(oData6_17x17),
							.oData7					(oData7_17x17)
						);

endmodule

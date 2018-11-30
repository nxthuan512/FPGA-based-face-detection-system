module mfhwt_PPBuffer_160x4 (
								//Input
								input				iClk,
								input				iRdreq,
								input		[3:0]	iWrreq,
								input		[15:0]	iData,
								//Output
								output		[3:0]	oFull,
								output				oEmpty,
								output		[63:0]	oData
							);

mfhwt_scfifo_160x4	BUF0 	(
								.iClk				(iClk),
								.iWrreq				(iWrreq),
								.iRdreq				(iRdreq),
								.iData				(iData),
								.oFull				(oFull),
								.oEmpty				(oEmpty),
								.oData				(oData)
							);

endmodule

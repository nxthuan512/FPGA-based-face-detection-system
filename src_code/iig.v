module	iig (
				//Input
				input					iClk,
				input					iReset_n,
				input					iRun,
				input					iInput_ready,
				input		[7:0]		iData,
				//Output
				output					oWrreq_to_IIGBRAM,
				output		[12:0]		oAddr_to_IIGBRAM,
				output		[20:0]		oData
			);

pre_iig		IIG 	(
						//Input
						.iClk					(iClk),
						.iReset_n				(iReset_n),
						.iRun					(iRun),
						.iInput_ready			(iInput_ready),
						.iData					(iData),
						//Output
						.oWrreq_to_IIGBRAM		(oWrreq_to_IIGBRAM),
						.oAddr_to_IIGBRAM		(oAddr_to_IIGBRAM),
						.oData					(oData)
					);

endmodule

module	pre_iig (
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

//====================REGISTERS===============================
reg		[7:0]		data_in_MAC;
//======================WIRES=================================
wire	[20:0]		sum;
//MAC
wire				iInt_rst_MAC;
wire				iReady_MAC;
wire	[7:0]		iData_Mac;
wire	[20:0]		oData_MAC;
//BUFFER0		
wire				iSelect_BUF0;
wire				iRdreq_BUF0;
wire				iWrreq_BUF0;
wire				oFull_BUF0;
wire				oEmpty_BUF0;
wire	[20:0]		iData_BUF0;
wire	[20:0]		oData_BUF0;	
//SUM
wire				iEnable_SUM0;				
//============================================================
//	COMBINATION
//============================================================
assign 		iData_Mac	= data_in_MAC;
//============================================================
//	SEQUENCE
//============================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
		data_in_MAC <= 8'b0;
	else
		data_in_MAC <= iData;
end
//============================================================

iig_control		CONTROL_IIG	(
								//Input
								.iClk						(iClk),
								.iReset_n					(iReset_n),
								.iRun						(iRun),
								.iInput_ready				(iInput_ready),
								.iFull_BUF0					(oFull_BUF0),
								.iEmpty_BUF0				(oEmpty_BUF0),
								//Output
								.oInt_rst_MAC				(iInt_rst_MAC),
								.oReady_MAC					(iReady_MAC),
								.oSelect_BUF0				(iSelect_BUF0),
								.oRdreq_BUF0				(iRdreq_BUF0),
								.oWrreq_BUF0				(iWrreq_BUF0),
								.oEnable_SUM0				(iEnable_SUM0),
								.oAddr_IIGBRAM				(oAddr_to_IIGBRAM),
								.oOutput_ready				(oWrreq_to_IIGBRAM)
							);

iig_mac	MAC					(
								//Input
								.iClk						(iClk),
								.iReset_n					(iReset_n),
								.iInt_rst					(iInt_rst_MAC),
								.iReady						(iReady_MAC),
								.iData						(iData_Mac),
								//Output
								.oData						(oData_MAC)
							);

iig_PPBuffer_80x1	BUFFER0	(
								//Input
								.iClk						(iClk),
								.iReset_n					(iReset_n),
								.iSelect					(iSelect_BUF0),
								.iRdreq						(iRdreq_BUF0),
								.iWrreq						(iWrreq_BUF0),
								.iData						(iData_BUF0),
								//Output
								.oFull						(oFull_BUF0),
								.oEmpty						(oEmpty_BUF0),
								.oData						(oData)
							);

iig_sum SUM0				(
								//Input
								.iClk						(iClk),
								.iReset_n					(iReset_n),
								.iEnable					(iEnable_SUM0),
								.iData_from_BUF0			(oData),
								.iData_from_MAC				(oData_MAC),
								//Output
								.oData						(iData_BUF0)
							);
			
endmodule

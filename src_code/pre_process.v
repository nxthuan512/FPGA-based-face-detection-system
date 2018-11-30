module	pre_process	(
						//Input
						input				iClk,
						input				iReset_n,
						input				iRun_IIG,
						input				iInput_ready,
						input		[31:0]	iData_in,
						//Output
						output				oWrreq_to_IIGBRAM,
						output		[12:0]	oAddr_to_IIGBRAM,
						output		[20:0]	oData_to_IIGBRAM,
						output				oWrreq_to_SM,
						output		[12:0]	oAddr_to_SM,
						output				oData_to_SM
					);
//=========================WIRES==================================
wire	[15:0]		data_from_MFHWT_to_GRAYSCALE;
wire				output_ready_from_MFHWT_to_GRAYSCALE;
wire				output_ready_from_GRAYSCALE;
wire				output_ready_to_IIG;
wire	[7:0]		data_from_GRAYSCALE_to_IIG;
//=======================REGISTERS================================
reg					out_ready_reg;
//================================================================
//	COMBINATIONS
//================================================================
assign	output_ready_to_IIG	=	out_ready_reg;
//================================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
		out_ready_reg <= 1'b0;
	else
		out_ready_reg <= output_ready_from_GRAYSCALE;
end

mfhwt	HAAR_TRANSFORM		(
								//Input
								.iClk					(iClk),
								.iReset_n				(iReset_n),
								.iInput_ready			(iInput_ready),
								.iData_in				(iData_in),
								//Output
								.oOutput_ready			(output_ready_from_MFHWT_to_GRAYSCALE),
								.oData_out				(data_from_MFHWT_to_GRAYSCALE)
							);
							
skin_detect	SKIN_DETECT		(
								//Input
								.iClk					(iClk),
								.iReset_n				(iReset_n),
								.iInput_ready			(output_ready_from_MFHWT_to_GRAYSCALE),
								.iRGB					(data_from_MFHWT_to_GRAYSCALE),
								//Output
								.oAddr_SM				(oAddr_to_SM),
								.oWrreq_SM				(oWrreq_to_SM),
								.oData_out				(oData_to_SM)
							);
						
rgb2grayscale	GRAYSCALE	(
								//Input
								.iClk					(iClk),
								.iReset_n				(iReset_n),
								.iInput_ready			(output_ready_from_MFHWT_to_GRAYSCALE),
								.iRGB					(data_from_MFHWT_to_GRAYSCALE),
								//Output
								.oOutput_ready			(output_ready_from_GRAYSCALE),
								.oY						(data_from_GRAYSCALE_to_IIG)
							);

iig	IIG						(
								//Input
								.iClk					(iClk),
								.iReset_n				(iReset_n),
								.iRun					(iRun_IIG),
								.iInput_ready			(output_ready_to_IIG),
								.iData					(data_from_GRAYSCALE_to_IIG),
								//Output
								.oWrreq_to_IIGBRAM		(oWrreq_to_IIGBRAM),
								.oAddr_to_IIGBRAM		(oAddr_to_IIGBRAM),
								.oData					(oData_to_IIGBRAM)
							);
endmodule

module iig_mac (
					//Input
					input					iClk,
					input					iReset_n,
					input					iInt_rst,
					input					iReady,
					input		[7:0]		iData,
					//Output
					output		[20:0]		oData
				);

//==================REGISTERS===========================
reg		[20:0]		pre_data;
//======================================================
//	COMBINATION
//======================================================
assign		oData	= pre_data + iData;
//======================================================
//	SEQUENCE
//======================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		pre_data <= 21'b0;
	end
	else
	begin
		if (iReady)
			pre_data <= oData;
		if (iInt_rst)
			pre_data <= 21'b0;
	end
end

endmodule

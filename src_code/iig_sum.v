module iig_sum (
				//Input
				input				iClk,
				input				iReset_n,
				input				iEnable,
				input		[20:0]	iData_from_BUF0,
				input		[20:0]	iData_from_MAC,
				//Output
				output	reg	[20:0]	oData
			);
//============================REGISTERS========================================
wire		[20:0]		pre_data;
//=============================================================================
assign	pre_data = (iEnable) ? (iData_from_BUF0 + iData_from_MAC) : (iData_from_MAC);

always @ (posedge iClk)
begin
	if (~iReset_n)
		oData	<= 20'b0;
	else
		oData	<= pre_data;
end

endmodule

module mfhwt_avg (
					//Input
					input					iClk,
					input					iReset_n,
					input			[63:0]	idata,
					//Output
					output reg		[15:0]	odata
				);
//======================WIRES===================================
wire	[7:0]		RSum;
wire	[7:0]		GSum;
wire	[7:0]		BSum;
//==============================================================
//	COMBINATION
//==============================================================
assign		RSum = ( idata[63:59] + idata[47:43] ) + ( idata[31:27] + idata[15:11] ) ;
assign		GSum = ( idata[58:53] + idata[42:37] ) + ( idata[26:21] + idata[10:5] ) ;
assign		BSum = ( idata[52:48] + idata[36:32] ) + ( idata[20:16] + idata[4:0] ) ;
//==============================================================
//	SEQUENCE
//==============================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
		odata <= 16'b0;
	else
		odata <= {RSum[6:2],GSum[7:2],BSum[6:2]};
end

endmodule

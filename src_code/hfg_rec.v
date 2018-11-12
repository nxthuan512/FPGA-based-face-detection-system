module	hfg_rec (
					//Input
					input						iClk,
					input						iReset_n,
					input						iSign,
					input			[20:0]		iA,
					input			[20:0]		iB,
					input			[20:0]		iC,
					input			[20:0]		iD,
					//Output
					output	reg		[20:0]		oRec
				);
//======================REGISTERS==========================
wire		[20:0]		rec;
wire		[20:0]		sign_rec;
//=========================================================
assign		rec		 =	(iD + iA) - (iB + iC);
assign		sign_rec =	(iSign) ? (~rec + 1'b1) : rec;
//=========================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
		oRec <= 21'b0;
	else
		oRec <= sign_rec;
end
				
endmodule

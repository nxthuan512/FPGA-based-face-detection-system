module	set_om	(
					//Input
					input						iClk,
					input						iReset_n,
					input						iRun,
					//Output
					output						oFinish,
					output	reg		[12:0]		oAddr_OM,
					output	reg					oWrreq_OM,
					output	reg		[31:0]		oData_to_OM
				);
//=============================REGISTERS=============================
reg					state;
//==================================================================
assign	oFinish	=	oAddr_OM == 13'd4799;
//===================================================================
always	@	(posedge	iClk)
if (~iReset_n || oFinish)
begin
	oAddr_OM		<=	13'b0;
	oWrreq_OM		<=	1'b0;
	oData_to_OM		<=	32'b0;
	state			<=	1'b0;
end
else
begin
	case (state)
	0:
		if (iRun)
		begin
			oData_to_OM	<=	32'h11EB85;
			oWrreq_OM	<=	1'b1;
			state		<=	1'b1;
		end
	1:
		oAddr_OM	<=	oAddr_OM + 1'b1;
	endcase
end
				
endmodule

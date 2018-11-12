module	hfg_feature_composition (
									//Input
									input							iClk,
									input							iReset_n,
									input							iWait,
									input			[20:0]			iRec0,
									input			[20:0]			iRec1,
									input			[20:0]			iRec2,
									input			[20:0]			iRec3,
									input			[20:0]			iRec4,
									input			[20:0]			iRec5,
									input			[20:0]			iRec6,
									input			[20:0]			iRec7,
									//Output
									output	reg		[20:0]			oPre_Feature
								);
//========================REGISTERS=================================
reg			[20:0]		pre_sum;
//==========================WIRES===================================
wire		[20:0]		sum;
//===================================================================
//	COMBINATIONS
//===================================================================
assign		sum	  =	(((iRec0 + iRec1) + (iRec2 + iRec3)) + ((iRec4 + iRec5) + (iRec6 + iRec7))) + pre_sum;
//===================================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		oPre_Feature 	<= 21'b0;
		pre_sum 		<= 21'b0;
	end
	else
	begin
		oPre_Feature 	<= sum;
		if (iWait)
			pre_sum 	<= sum;
		else
			pre_sum 	<= 21'b0;
	end
end					
					
endmodule

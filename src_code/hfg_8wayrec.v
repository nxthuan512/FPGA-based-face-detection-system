module hfg_8wayrec  (
						//Input	
						input							iClk,
						input							iReset_n,
						input							iReady,
						input			[7:0]			iSign,
						input			[83:0]			i4Rec0,
						input			[83:0]			i4Rec1,
						input			[83:0]			i4Rec2,
						input			[83:0]			i4Rec3,
						input			[83:0]			i4Rec4,
						input			[83:0]			i4Rec5,
						input			[83:0]			i4Rec6,
						input			[83:0]			i4Rec7,
						//Output
						output			[20:0]			oRec0,
						output			[20:0]			oRec1,
						output			[20:0]			oRec2,
						output			[20:0]			oRec3,
						output			[20:0]			oRec4,
						output			[20:0]			oRec5,
						output			[20:0]			oRec6,
						output			[20:0]			oRec7
					);
//==============================REGISTERS=================================
reg		[7:0]		sign;
reg		[83:0]		reg_4rec0;
reg		[83:0]		reg_4rec1;
reg		[83:0]		reg_4rec2;
reg		[83:0]		reg_4rec3;
reg		[83:0]		reg_4rec4;
reg		[83:0]		reg_4rec5;
reg		[83:0]		reg_4rec6;
reg		[83:0]		reg_4rec7;
//========================================================================
always @ (posedge iClk)
begin
	if (~iReset_n || !iReady)
	begin
		sign		<=	8'b0;
		reg_4rec0	<=	84'b0;
		reg_4rec1	<=	84'b0;
		reg_4rec2	<=	84'b0;
		reg_4rec3	<=	84'b0;
		reg_4rec4	<=	84'b0;
		reg_4rec5	<=	84'b0;
		reg_4rec6	<=	84'b0;
		reg_4rec7	<=	84'b0;
	end
	else
		if (iReady)
		begin
			sign		<=	iSign;
			reg_4rec0	<=	i4Rec0;
			reg_4rec1	<=	i4Rec1;
			reg_4rec2	<=	i4Rec2;
			reg_4rec3	<=	i4Rec3;
			reg_4rec4	<=	i4Rec4;
			reg_4rec5	<=	i4Rec5;
			reg_4rec6	<=	i4Rec6;
			reg_4rec7	<=	i4Rec7;
		end
end
//========================================================================
hfg_rec	REC0	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[0]),
					.iA						(reg_4rec0[20:0]),
					.iB						(reg_4rec0[41:21]),
					.iC						(reg_4rec0[62:42]),
					.iD						(reg_4rec0[83:63]),
					//Output
					.oRec					(oRec0)
				);

hfg_rec	REC1	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[1]),
					.iA						(reg_4rec1[20:0]),
					.iB						(reg_4rec1[41:21]),
					.iC						(reg_4rec1[62:42]),
					.iD						(reg_4rec1[83:63]),
					//Output
					.oRec					(oRec1)
				);

hfg_rec	REC2	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[2]),
					.iA						(reg_4rec2[20:0]),
					.iB						(reg_4rec2[41:21]),
					.iC						(reg_4rec2[62:42]),
					.iD						(reg_4rec2[83:63]),
					//Output
					.oRec					(oRec2)
				);

hfg_rec	REC3	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[3]),
					.iA						(reg_4rec3[20:0]),
					.iB						(reg_4rec3[41:21]),
					.iC						(reg_4rec3[62:42]),
					.iD						(reg_4rec3[83:63]),
					//Output
					.oRec					(oRec3)
				);

hfg_rec	REC4	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[4]),
					.iA						(reg_4rec4[20:0]),
					.iB						(reg_4rec4[41:21]),
					.iC						(reg_4rec4[62:42]),
					.iD						(reg_4rec4[83:63]),
					//Output
					.oRec					(oRec4)
				);

hfg_rec	REC5	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[5]),
					.iA						(reg_4rec5[20:0]),
					.iB						(reg_4rec5[41:21]),
					.iC						(reg_4rec5[62:42]),
					.iD						(reg_4rec5[83:63]),
					//Output
					.oRec					(oRec5)
				);

hfg_rec	REC6	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[6]),
					.iA						(reg_4rec6[20:0]),
					.iB						(reg_4rec6[41:21]),
					.iC						(reg_4rec6[62:42]),
					.iD						(reg_4rec6[83:63]),
					//Output
					.oRec					(oRec6)
				);

hfg_rec	REC7	(
					//Input
					.iClk					(iClk),
					.iReset_n				(iReset_n),
					.iSign					(sign[7]),
					.iA						(reg_4rec7[20:0]),
					.iB						(reg_4rec7[41:21]),
					.iC						(reg_4rec7[62:42]),
					.iD						(reg_4rec7[83:63]),
					//Output
					.oRec					(oRec7)
				);
				
endmodule

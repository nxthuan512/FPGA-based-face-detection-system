module	ann_mux_20to1	(
							//Input
							input			[4:0]		iSel,
							input			[31:0]		iMac_0,
							input			[31:0]		iMac_1,
							input			[31:0]		iMac_2,
							input			[31:0]		iMac_3,
							input			[31:0]		iMac_4,
							input			[31:0]		iMac_5,
							input			[31:0]		iMac_6,
							input			[31:0]		iMac_7,
							input			[31:0]		iMac_8,
							input			[31:0]		iMac_9,
							input			[31:0]		iMac_10,
							input			[31:0]		iMac_11,
							input			[31:0]		iMac_12,
							input			[31:0]		iMac_13,
							input			[31:0]		iMac_14,
							input			[31:0]		iMac_15,
							input			[31:0]		iMac_16,
							input			[31:0]		iMac_17,
							input			[31:0]		iMac_18,
							input			[31:0]		iMac_19,
							//Output
							output			[31:0]		oData_out
						);

assign	oData_out	=	(iSel == 5'd0)  ? iMac_0
										:	(iSel == 5'd1)  ? iMac_1
										:	(iSel == 5'd2)  ? iMac_2
										:	(iSel == 5'd3)  ? iMac_3
										:	(iSel == 5'd4)  ? iMac_4
										:	(iSel == 5'd5)  ? iMac_5
										:	(iSel == 5'd6)  ? iMac_6
										:	(iSel == 5'd7)  ? iMac_7
										:	(iSel == 5'd8)  ? iMac_8
										:	(iSel == 5'd9)  ? iMac_9
										:	(iSel == 5'd10)  ? iMac_10
										:	(iSel == 5'd11)  ? iMac_11
										:	(iSel == 5'd12)  ? iMac_12
										:	(iSel == 5'd13)  ? iMac_13
										:	(iSel == 5'd14)  ? iMac_14
										:	(iSel == 5'd15)  ? iMac_15
										:	(iSel == 5'd16)  ? iMac_16
										:	(iSel == 5'd17)  ? iMac_17
										:	(iSel == 5'd18)  ? iMac_18 : iMac_19;

endmodule

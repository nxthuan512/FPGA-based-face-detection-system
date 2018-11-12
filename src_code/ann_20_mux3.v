module	ann_20_mux3	(
						//Input
						input			[1:0]		iSel,
						input			[31:0]		iFeature,
						input			[31:0]		iOutput_Logsig,
						//Output
						output			[31:0]		oData_out_0,
						output			[31:0]		oData_out_1,
						output			[31:0]		oData_out_2,
						output			[31:0]		oData_out_3,
						output			[31:0]		oData_out_4,
						output			[31:0]		oData_out_5,
						output			[31:0]		oData_out_6,
						output			[31:0]		oData_out_7,
						output			[31:0]		oData_out_8,
						output			[31:0]		oData_out_9,
						output			[31:0]		oData_out_10,
						output			[31:0]		oData_out_11,
						output			[31:0]		oData_out_12,
						output			[31:0]		oData_out_13,
						output			[31:0]		oData_out_14,
						output			[31:0]		oData_out_15,
						output			[31:0]		oData_out_16,
						output			[31:0]		oData_out_17,
						output			[31:0]		oData_out_18,
						output			[31:0]		oData_out_19
					);

ann_mux_3to1	MUX3_0	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_0)
						);

ann_mux_3to1	MUX3_1	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_1)
						);

ann_mux_3to1	MUX3_2	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_2)
						);
						
ann_mux_3to1	MUX3_3	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_3)
						);
				
ann_mux_3to1	MUX3_4	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_4)
						);

ann_mux_3to1	MUX3_5	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_5)
						);

ann_mux_3to1	MUX3_6	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_6)
						);

ann_mux_3to1	MUX3_7	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_7)
						);
						
ann_mux_3to1	MUX3_8	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_8)
						);
				
ann_mux_3to1	MUX3_9	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_9)
						);
						
ann_mux_3to1	MUX3_10	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_10)
						);

ann_mux_3to1	MUX3_11	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_11)
						);

ann_mux_3to1	MUX3_12	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_12)
						);
						
ann_mux_3to1	MUX3_13	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_13)
						);
				
ann_mux_3to1	MUX3_14	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_14)
						);
						
ann_mux_3to1	MUX3_15	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_15)
						);

ann_mux_3to1	MUX3_16	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_16)
						);

ann_mux_3to1	MUX3_17	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_17)
						);
						
ann_mux_3to1	MUX3_18	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_18)
						);
				
ann_mux_3to1	MUX3_19	(
							//Input
							.iSel					(iSel),
							.iFeature				(iFeature),
							.iOutput_Logsig			(iOutput_Logsig),
							//Output
							.oData_out				(oData_out_19)
						);
						
endmodule

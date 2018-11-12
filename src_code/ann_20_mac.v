module	ann_20_mac	(
						//Input
						input						iClk,
						input						iReset_n,
						input			[19:0]		iInput_ready,
						input						iFinish,
						input			[31:0]		iData_in_0,
						input			[31:0]		iData_in_1,
						input			[31:0]		iData_in_2,
						input			[31:0]		iData_in_3,
						input			[31:0]		iData_in_4,
						input			[31:0]		iData_in_5,
						input			[31:0]		iData_in_6,
						input			[31:0]		iData_in_7,
						input			[31:0]		iData_in_8,
						input			[31:0]		iData_in_9,
						input			[31:0]		iData_in_10,
						input			[31:0]		iData_in_11,
						input			[31:0]		iData_in_12,
						input			[31:0]		iData_in_13,
						input			[31:0]		iData_in_14,
						input			[31:0]		iData_in_15,
						input			[31:0]		iData_in_16,
						input			[31:0]		iData_in_17,
						input			[31:0]		iData_in_18,
						input			[31:0]		iData_in_19,
						input			[31:0]		iWeight_0,
						input			[31:0]		iWeight_1,
						input			[31:0]		iWeight_2,
						input			[31:0]		iWeight_3,
						input			[31:0]		iWeight_4,
						input			[31:0]		iWeight_5,
						input			[31:0]		iWeight_6,
						input			[31:0]		iWeight_7,
						input			[31:0]		iWeight_8,
						input			[31:0]		iWeight_9,
						input			[31:0]		iWeight_10,
						input			[31:0]		iWeight_11,
						input			[31:0]		iWeight_12,
						input			[31:0]		iWeight_13,
						input			[31:0]		iWeight_14,
						input			[31:0]		iWeight_15,
						input			[31:0]		iWeight_16,
						input			[31:0]		iWeight_17,
						input			[31:0]		iWeight_18,
						input			[31:0]		iWeight_19,
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
					
ann_mac	MAC_0		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[0]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_0),
						.iWeight					(iWeight_0),
						//Output
						.oData_out					(oData_out_0)
					);

ann_mac	MAC_1		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[1]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_1),
						.iWeight					(iWeight_1),
						//Output
						.oData_out					(oData_out_1)
					);

ann_mac	MAC_2		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[2]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_2),
						.iWeight					(iWeight_2),
						//Output
						.oData_out					(oData_out_2)
					);

ann_mac	MAC_3		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[3]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_3),
						.iWeight					(iWeight_3),
						//Output
						.oData_out					(oData_out_3)
					);

ann_mac	MAC_4		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[4]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_4),
						.iWeight					(iWeight_4),
						//Output
						.oData_out					(oData_out_4)
					);	

ann_mac	MAC_5		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[5]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_5),
						.iWeight					(iWeight_5),
						//Output
						.oData_out					(oData_out_5)
					);

ann_mac	MAC_6		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[6]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_6),
						.iWeight					(iWeight_6),
						//Output
						.oData_out					(oData_out_6)
					);

ann_mac	MAC_7		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[7]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_7),
						.iWeight					(iWeight_7),
						//Output
						.oData_out					(oData_out_7)
					);

ann_mac	MAC_8		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[8]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_8),
						.iWeight					(iWeight_8),
						//Output
						.oData_out					(oData_out_8)
					);

ann_mac	MAC_9		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[9]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_9),
						.iWeight					(iWeight_9),
						//Output
						.oData_out					(oData_out_9)
					);	

ann_mac	MAC_10		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[10]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_10),
						.iWeight					(iWeight_10),
						//Output
						.oData_out					(oData_out_10)
					);

ann_mac	MAC_11		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[11]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_11),
						.iWeight					(iWeight_11),
						//Output
						.oData_out					(oData_out_11)
					);

ann_mac	MAC_12		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[12]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_12),
						.iWeight					(iWeight_12),
						//Output
						.oData_out					(oData_out_12)
					);

ann_mac	MAC_13		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[13]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_13),
						.iWeight					(iWeight_13),
						//Output
						.oData_out					(oData_out_13)
					);

ann_mac	MAC_14		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[14]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_14),
						.iWeight					(iWeight_14),
						//Output
						.oData_out					(oData_out_14)
					);	

ann_mac	MAC_15		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[15]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_15),
						.iWeight					(iWeight_15),
						//Output
						.oData_out					(oData_out_15)
					);

ann_mac	MAC_16		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[16]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_16),
						.iWeight					(iWeight_16),
						//Output
						.oData_out					(oData_out_16)
					);

ann_mac	MAC_17		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[17]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_17),
						.iWeight					(iWeight_17),
						//Output
						.oData_out					(oData_out_17)
					);

ann_mac	MAC_18		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[18]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_18),
						.iWeight					(iWeight_18),
						//Output
						.oData_out					(oData_out_18)
					);

ann_mac	MAC_19		(
						//Input
						.iClk						(iClk),
						.iReset_n					(iReset_n),
						.iInput_ready				(iInput_ready[19]),
						.iFinish					(iFinish),
						.iData_in					(iData_in_19),
						.iWeight					(iWeight_19),
						//Output
						.oData_out					(oData_out_19)
					);	
					
endmodule

module	ann	(
				//Input
				input						iClk,
				input						iReset_n,
				input						iRun_ANN,
				input			[31:0]		iFeature,
				//Output
				output			[6:0]		oAddr_FBR,
				output						oWrreq_OM,
				output			[31:0]		oData_out,
				output						oFinish_Stage,
				output						oPass
			);

//==============================WIRES======================================
wire		[9:0]		addr_rom_0;
wire		[8:0]		addr_rom_1;
wire		[8:0]		addr_rom_2;
wire		[8:0]		addr_rom_3;
wire		[8:0]		addr_rom_4;
wire		[8:0]		addr_rom_5;
wire		[8:0]		addr_rom_6;
wire		[8:0]		addr_rom_7;
wire		[8:0]		addr_rom_8;
wire		[8:0]		addr_rom_9;
wire		[8:0]		addr_rom_10;
wire		[8:0]		addr_rom_11;
wire		[8:0]		addr_rom_12;
wire		[8:0]		addr_rom_13;
wire		[8:0]		addr_rom_14;
wire		[8:0]		addr_rom_15;
wire		[8:0]		addr_rom_16;
wire		[8:0]		addr_rom_17;
wire		[8:0]		addr_rom_18;
wire		[8:0]		addr_rom_19;
wire		[31:0]		q_rom_0;
wire		[31:0]		q_rom_1;
wire		[31:0]		q_rom_2;
wire		[31:0]		q_rom_3;
wire		[31:0]		q_rom_4;
wire		[31:0]		q_rom_5;
wire		[31:0]		q_rom_6;
wire		[31:0]		q_rom_7;
wire		[31:0]		q_rom_8;
wire		[31:0]		q_rom_9;
wire		[31:0]		q_rom_10;
wire		[31:0]		q_rom_11;
wire		[31:0]		q_rom_12;
wire		[31:0]		q_rom_13;
wire		[31:0]		q_rom_14;
wire		[31:0]		q_rom_15;
wire		[31:0]		q_rom_16;
wire		[31:0]		q_rom_17;
wire		[31:0]		q_rom_18;
wire		[31:0]		q_rom_19;
wire		[31:0]		data_to_mac_0;
wire		[31:0]		data_to_mac_1;
wire		[31:0]		data_to_mac_2;
wire		[31:0]		data_to_mac_3;
wire		[31:0]		data_to_mac_4;
wire		[31:0]		data_to_mac_5;
wire		[31:0]		data_to_mac_6;
wire		[31:0]		data_to_mac_7;
wire		[31:0]		data_to_mac_8;
wire		[31:0]		data_to_mac_9;
wire		[31:0]		data_to_mac_10;
wire		[31:0]		data_to_mac_11;
wire		[31:0]		data_to_mac_12;
wire		[31:0]		data_to_mac_13;
wire		[31:0]		data_to_mac_14;
wire		[31:0]		data_to_mac_15;
wire		[31:0]		data_to_mac_16;
wire		[31:0]		data_to_mac_17;
wire		[31:0]		data_to_mac_18;
wire		[31:0]		data_to_mac_19;
wire		[31:0]		data_from_mac_0;
wire		[31:0]		data_from_mac_1;
wire		[31:0]		data_from_mac_2;
wire		[31:0]		data_from_mac_3;
wire		[31:0]		data_from_mac_4;
wire		[31:0]		data_from_mac_5;
wire		[31:0]		data_from_mac_6;
wire		[31:0]		data_from_mac_7;
wire		[31:0]		data_from_mac_8;
wire		[31:0]		data_from_mac_9;
wire		[31:0]		data_from_mac_10;
wire		[31:0]		data_from_mac_11;
wire		[31:0]		data_from_mac_12;
wire		[31:0]		data_from_mac_13;
wire		[31:0]		data_from_mac_14;
wire		[31:0]		data_from_mac_15;
wire		[31:0]		data_from_mac_16;
wire		[31:0]		data_from_mac_17;
wire		[31:0]		data_from_mac_18;
wire		[31:0]		data_from_mac_19;
wire					output_ready_from_logsig;
wire					output_ready_from_threshold;
wire					flag_from_threshold;
wire					empty_ff_stage9;
wire		[1:0]		sel_mux3;
wire		[4:0]		sel_mux20;
wire		[19:0]		input_ready_mac;
wire					finish_mac;
wire					input_ready_logsig;
wire					input_ready_threshold;
wire					wrreq_ff_stage9;
wire					rdreq_ff_stage9;
wire		[31:0]		data_out_mux20;	
wire		[31:0]		data_out_logsig;
wire		[31:0]		data_in_mux3;
wire		[31:0]		data_out_ff;
//=========================================================================
assign	data_in_mux3	=	(rdreq_ff_stage9) ? data_out_ff : iFeature;
//=========================================================================
ann_control	CONTROL			(
								//Input
								.iClk								(iClk),
								.iReset_n							(iReset_n),
								.iRun_ANN							(iRun_ANN),
								.iOutput_ready_from_LOGSIG			(output_ready_from_logsig),
								.iOutput_ready_from_THRESHOLD		(output_ready_from_threshold),
								.iFlag_from_THRESHOLD				(flag_from_threshold),
								.iEmpty_FF_Stage9					(empty_ff_stage9),
								//Output
								.oSel_Mux3							(sel_mux3),
								.oSel_Mux20							(sel_mux20),
								.oInput_ready_to_MAC				(input_ready_mac),
								.oFinish_to_MAC						(finish_mac),
								.oInput_ready_to_LOGSIG				(input_ready_logsig),
								.oInput_ready_to_THRESHOLD			(input_ready_threshold),
								.oAddr_FBR							(oAddr_FBR),
								.oWrreq_FF_Stage9					(wrreq_ff_stage9),
								.oRdreq_FF_Stage9					(rdreq_ff_stage9),
								.oWrreq_OM							(oWrreq_OM),
								.oPass								(oPass),
								.oFinish_Stage						(oFinish_Stage),
								.oAddr_ROM_0						(addr_rom_0),
								.oAddr_ROM_1						(addr_rom_1),
								.oAddr_ROM_2						(addr_rom_2),
								.oAddr_ROM_3						(addr_rom_3),
								.oAddr_ROM_4						(addr_rom_4),
								.oAddr_ROM_5						(addr_rom_5),
								.oAddr_ROM_6						(addr_rom_6),
								.oAddr_ROM_7						(addr_rom_7),
								.oAddr_ROM_8						(addr_rom_8),
								.oAddr_ROM_9						(addr_rom_9),
								.oAddr_ROM_10						(addr_rom_10),
								.oAddr_ROM_11						(addr_rom_11),
								.oAddr_ROM_12						(addr_rom_12),
								.oAddr_ROM_13						(addr_rom_13),
								.oAddr_ROM_14						(addr_rom_14),
								.oAddr_ROM_15						(addr_rom_15),
								.oAddr_ROM_16						(addr_rom_16),
								.oAddr_ROM_17						(addr_rom_17),
								.oAddr_ROM_18						(addr_rom_18),
								.oAddr_ROM_19						(addr_rom_19)
							);

ann_20_mac	MAC				(
								//Input
								.iClk								(iClk),
								.iReset_n							(iReset_n),
								.iInput_ready						(input_ready_mac),
								.iFinish							(finish_mac),
								.iData_in_0							(data_to_mac_0),
								.iData_in_1							(data_to_mac_1),
								.iData_in_2							(data_to_mac_2),
								.iData_in_3							(data_to_mac_3),
								.iData_in_4							(data_to_mac_4),
								.iData_in_5							(data_to_mac_5),
								.iData_in_6							(data_to_mac_6),
								.iData_in_7							(data_to_mac_7),
								.iData_in_8							(data_to_mac_8),
								.iData_in_9							(data_to_mac_9),
								.iData_in_10						(data_to_mac_10),
								.iData_in_11						(data_to_mac_11),
								.iData_in_12						(data_to_mac_12),
								.iData_in_13						(data_to_mac_13),
								.iData_in_14						(data_to_mac_14),
								.iData_in_15						(data_to_mac_15),
								.iData_in_16						(data_to_mac_16),
								.iData_in_17						(data_to_mac_17),
								.iData_in_18						(data_to_mac_18),
								.iData_in_19						(data_to_mac_19),
								.iWeight_0							(q_rom_0),
								.iWeight_1							(q_rom_1),
								.iWeight_2							(q_rom_2),
								.iWeight_3							(q_rom_3),
								.iWeight_4							(q_rom_4),
								.iWeight_5							(q_rom_5),
								.iWeight_6							(q_rom_6),
								.iWeight_7							(q_rom_7),
								.iWeight_8							(q_rom_8),
								.iWeight_9							(q_rom_9),
								.iWeight_10							(q_rom_10),
								.iWeight_11							(q_rom_11),
								.iWeight_12							(q_rom_12),
								.iWeight_13							(q_rom_13),
								.iWeight_14							(q_rom_14),
								.iWeight_15							(q_rom_15),
								.iWeight_16							(q_rom_16),
								.iWeight_17							(q_rom_17),
								.iWeight_18							(q_rom_18),
								.iWeight_19							(q_rom_19),
								//Output
								.oData_out_0						(data_from_mac_0),
								.oData_out_1						(data_from_mac_1),
								.oData_out_2						(data_from_mac_2),
								.oData_out_3						(data_from_mac_3),
								.oData_out_4						(data_from_mac_4),
								.oData_out_5						(data_from_mac_5),
								.oData_out_6						(data_from_mac_6),
								.oData_out_7						(data_from_mac_7),
								.oData_out_8						(data_from_mac_8),
								.oData_out_9						(data_from_mac_9),
								.oData_out_10						(data_from_mac_10),
								.oData_out_11						(data_from_mac_11),
								.oData_out_12						(data_from_mac_12),
								.oData_out_13						(data_from_mac_13),
								.oData_out_14						(data_from_mac_14),
								.oData_out_15						(data_from_mac_15),
								.oData_out_16						(data_from_mac_16),
								.oData_out_17						(data_from_mac_17),
								.oData_out_18						(data_from_mac_18),
								.oData_out_19						(data_from_mac_19)
							);

ann_20_mux3	MUX3			(
								//Input
								.iSel								(sel_mux3),
								.iFeature							(data_in_mux3),
								.iOutput_Logsig						(data_out_logsig),
								//Output
								.oData_out_0						(data_to_mac_0),
								.oData_out_1						(data_to_mac_1),
								.oData_out_2						(data_to_mac_2),
								.oData_out_3						(data_to_mac_3),
								.oData_out_4						(data_to_mac_4),
								.oData_out_5						(data_to_mac_5),
								.oData_out_6						(data_to_mac_6),
								.oData_out_7						(data_to_mac_7),
								.oData_out_8						(data_to_mac_8),
								.oData_out_9						(data_to_mac_9),
								.oData_out_10						(data_to_mac_10),
								.oData_out_11						(data_to_mac_11),
								.oData_out_12						(data_to_mac_12),
								.oData_out_13						(data_to_mac_13),
								.oData_out_14						(data_to_mac_14),
								.oData_out_15						(data_to_mac_15),
								.oData_out_16						(data_to_mac_16),
								.oData_out_17						(data_to_mac_17),
								.oData_out_18						(data_to_mac_18),
								.oData_out_19						(data_to_mac_19)
							);

ann_mux_20to1	MUX20		(
								//Input
								.iSel								(sel_mux20),
								.iMac_0								(data_from_mac_0),
								.iMac_1								(data_from_mac_1),
								.iMac_2								(data_from_mac_2),
								.iMac_3								(data_from_mac_3),
								.iMac_4								(data_from_mac_4),
								.iMac_5								(data_from_mac_5),
								.iMac_6								(data_from_mac_6),
								.iMac_7								(data_from_mac_7),
								.iMac_8								(data_from_mac_8),
								.iMac_9								(data_from_mac_9),
								.iMac_10							(data_from_mac_10),
								.iMac_11							(data_from_mac_11),
								.iMac_12							(data_from_mac_12),	
								.iMac_13							(data_from_mac_13),
								.iMac_14							(data_from_mac_14),
								.iMac_15							(data_from_mac_15),
								.iMac_16							(data_from_mac_16),
								.iMac_17							(data_from_mac_17),
								.iMac_18							(data_from_mac_18),
								.iMac_19							(data_from_mac_19),
								//Output
								.oData_out							(data_out_mux20)
							);					

ann_logsig	LOGSIG			(
								//Input
								.iClk								(iClk),
								.iReset_n							(iReset_n),
								.iInput_ready						(input_ready_logsig),
								.iData_in							(data_out_mux20),
								//Output
								.oOutput_ready						(output_ready_from_logsig),
								.oData_out							(data_out_logsig)
							);

ann_threshold	THRESHOLD	(
								//Input
								.iClk								(iClk),
								.iReset_n							(iReset_n),
								.iInput_ready						(input_ready_threshold),
								.iOutput_Logsig						(data_out_logsig),
								//Output
								.oFlag								(flag_from_threshold),
								.oOutput_ready						(output_ready_from_threshold),
								.oData_out							(oData_out)
							);

weight_rom	WEIGHT_ROM		(
								//Input
								.iClk								(iClk),
								.Addr_ROM_0							(addr_rom_0),
								.Addr_ROM_1							(addr_rom_1),
								.Addr_ROM_2							(addr_rom_2),
								.Addr_ROM_3							(addr_rom_3),
								.Addr_ROM_4							(addr_rom_4),
								.Addr_ROM_5							(addr_rom_5),
								.Addr_ROM_6							(addr_rom_6),
								.Addr_ROM_7							(addr_rom_7),
								.Addr_ROM_8							(addr_rom_8),
								.Addr_ROM_9							(addr_rom_9),
								.Addr_ROM_10						(addr_rom_10),
								.Addr_ROM_11						(addr_rom_11),
								.Addr_ROM_12						(addr_rom_12),
								.Addr_ROM_13						(addr_rom_13),
								.Addr_ROM_14						(addr_rom_14),
								.Addr_ROM_15						(addr_rom_15),
								.Addr_ROM_16						(addr_rom_16),
								.Addr_ROM_17						(addr_rom_17),
								.Addr_ROM_18						(addr_rom_18),	
								.Addr_ROM_19						(addr_rom_19),
								//Output
								.Q_ROM_0							(q_rom_0),
								.Q_ROM_1							(q_rom_1),
								.Q_ROM_2							(q_rom_2),
								.Q_ROM_3							(q_rom_3),
								.Q_ROM_4							(q_rom_4),
								.Q_ROM_5							(q_rom_5),
								.Q_ROM_6							(q_rom_6),
								.Q_ROM_7							(q_rom_7),
								.Q_ROM_8							(q_rom_8),
								.Q_ROM_9							(q_rom_9),
								.Q_ROM_10							(q_rom_10),
								.Q_ROM_11							(q_rom_11),
								.Q_ROM_12							(q_rom_12),
								.Q_ROM_13							(q_rom_13),
								.Q_ROM_14							(q_rom_14),
								.Q_ROM_15							(q_rom_15),
								.Q_ROM_16							(q_rom_16),
								.Q_ROM_17							(q_rom_17),
								.Q_ROM_18							(q_rom_18),
								.Q_ROM_19							(q_rom_19)
							);

fifo_stage9 FIFO_STAGE9		(
								.clock								(iClk),
								.data								(data_out_logsig),
								.rdreq								(rdreq_ff_stage9),
								.wrreq								(wrreq_ff_stage9),
								.empty								(empty_ff_stage9),
								.full								(),
								.q									(data_out_ff)
							);
							
endmodule

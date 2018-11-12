module	face_detection	(
							//Input
							input						iClk,
							input						iReset_n,
							input						iInput_ready,
							input			[31:0]		iData_in,
							input						iWrite_wait_request,
							//Output
							output			[31:0]		oAddr_OI,
							output						oWrreq_OI,
							output			[31:0]		oData_out,
							output						oFinish
						);
						
//=================================WIRES=======================================
wire			full_sm;
wire			full_iib;
wire	[1:0]	finish_iib;
wire			end_iib;
wire			end_iib_n;
wire			full_fbr_23;
wire			finish_hfg_23;
wire			pass_ann_23;
wire			finish_ann_23;
wire			full_fbr_19;
wire			finish_hfg_19;
wire			pass_ann_19;
wire			finish_ann_19;
wire			full_fbr_17;
wire			finish_hfg_17;
wire			pass_ann_17;
wire			finish_ann_17;
wire			end_om;
wire			finish_postp;
wire			run_iig;
wire			run_iib;
wire			run_hfg_23;
wire			run_hfg_19;
wire			run_hfg_17;
wire			run_ann_23;
wire			run_ann_19;
wire			run_ann_17;
wire			run_postp;
wire			wr_om_23;
wire			wr_om_19;
wire			wr_om_17;
wire	[12:0]	w_addr_om_23;
wire	[12:0]	w_addr_om_19;
wire	[12:0]	w_addr_om_17;
wire			wr_iib;
wire	[12:0]	addr_iib;
wire	[20:0]	data_in_iib;
wire			wr_iibg_23;
wire			wr_iibg_19;
wire			wr_iibg_17;
wire	[20:0]	data_in_iibg;
wire	[9:0]	r_addr_iibg_23;
wire	[8:0]	r_addr_iibg_19;
wire	[8:0]	r_addr_iibg_17;
wire			rd_iibg_23;
wire			rd_iibg_19;
wire			rd_iibg_17;
wire			full_f_23;
wire			full_f_19;
wire			full_f_17;
wire			outputready_23;
wire			outputready_19;
wire			outputready_17;
wire	[83:0]	odata0_23;
wire	[83:0]	odata1_23;
wire	[83:0]	odata2_23;
wire	[83:0]	odata3_23;
wire	[83:0]	odata4_23;
wire	[83:0]	odata5_23;
wire	[83:0]	odata6_23;
wire	[83:0]	odata7_23;
wire	[83:0]	odata0_19;
wire	[83:0]	odata1_19;
wire	[83:0]	odata2_19;
wire	[83:0]	odata3_19;
wire	[83:0]	odata4_19;
wire	[83:0]	odata5_19;
wire	[83:0]	odata6_19;
wire	[83:0]	odata7_19;
wire	[83:0]	odata0_17;
wire	[83:0]	odata1_17;
wire	[83:0]	odata2_17;
wire	[83:0]	odata3_17;
wire	[83:0]	odata4_17;
wire	[83:0]	odata5_17;
wire	[83:0]	odata6_17;
wire	[83:0]	odata7_17;
wire	[31:0]	data_detect_23;
wire	[31:0]	data_detect_19;
wire	[31:0]	data_detect_17;
wire	[12:0]	wr_addr_om_23;
wire	[12:0]	wr_addr_om_19;
wire	[12:0]	wr_addr_om_17;
wire			wr_zr_om_23;
wire			wr_zr_om_19;
wire			wr_zr_om_17;
wire	[31:0]	data_zr_om_23;
wire	[31:0]	data_zr_om_19;
wire	[31:0]	data_zr_om_17;
wire	[31:0]	data_to_postp_23;
wire	[31:0]	data_to_postp_19;
wire	[31:0]	data_to_postp_17;
wire			wr_sm;
wire	[12:0]	addr_sm;
wire			data_in_sm;
wire	[12:0]	addr_om;
wire	[2:0]	finish_stage;
wire	[2:0]	rst_iibg;
wire			run_set_om;
wire			finish_set_om;
wire	[12:0]	addr_set_om;
wire			wr_set_om;
wire	[31:0]	data_set_om;
//=============================================================================
assign		finish_ann_23	=	wr_om_23;
assign		finish_ann_19	=	wr_om_19;
assign		finish_ann_17	=	wr_om_17;
assign		rst_iibg[0]		=	run_hfg_23;
assign		rst_iibg[1]		=	run_hfg_19;
assign		rst_iibg[2]		=	run_hfg_17;
assign		oFinish			=	finish_postp;
//=============================================================================
top_control	TOP_CONTROL			(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iInput_ready_from_DMA			(iInput_ready),
									.iFull_SM						(full_sm),
									.iFull_IIB						(full_iib),
									.iFinish_IIB					(finish_iib),
									.iEnd_IIB						(end_iib),
									.iEnd_IIB_n						(end_iib_n),
									.iFull_FBR_23x23				(full_fbr_23),
									.iFinish_HFG_23x23				(finish_hfg_23),
									.iPass_ANN_23x23				(pass_ann_23),
									.iFinish_ANN_23x23				(finish_ann_23),
									.iFull_FBR_19x19				(full_fbr_19),
									.iFinish_HFG_19x19				(finish_hfg_19),
									.iPass_ANN_19x19				(pass_ann_19),
									.iFinish_ANN_19x19				(finish_ann_19),
									.iFull_FBR_17x17				(full_fbr_17),
									.iFinish_HFG_17x17				(finish_hfg_17),
									.iPass_ANN_17x17				(pass_ann_17),
									.iFinish_ANN_17x17				(finish_ann_17),
									.iFinish_Stage					(finish_stage),
									.iEnd_OM						(end_om),
									.iFinish_PostP					(finish_postp),
									.iFinish_Set_OM					(finish_set_om),
									//Output
									.oRun_IIG						(run_iig),
									.oRun_IIB						(run_iib),
									.oRun_HFG_23x23					(run_hfg_23),
									.oRun_ANN_23x23					(run_ann_23),
									.oRun_HFG_19x19					(run_hfg_19),
									.oRun_ANN_19x19					(run_ann_19),
									.oRun_HFG_17x17					(run_hfg_17),
									.oRun_ANN_17x17					(run_ann_17),
									.oRun_PostP						(run_postp),
									.oRun_Set_OM					(run_set_om)
								);
					
pre_process	PRE_PROCESS			(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iRun_IIG						(run_iig),
									.iInput_ready					(iInput_ready),
									.iData_in						(iData_in),
									//Output
									.oWrreq_to_IIGBRAM				(wr_iib),
									.oAddr_to_IIGBRAM				(addr_iib),
									.oData_to_IIGBRAM				(data_in_iib),
									.oWrreq_to_SM					(wr_sm),
									.oAddr_to_SM					(addr_sm),
									.oData_to_SM					(data_in_sm)
								);

iib	INTEGRAL_IMAGE_BRAM			(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iRun							(run_iib),
									.iRst							(finish_ann_17),
									.iWrreq_SM						(wr_sm),
									.iAddr_SM						(addr_sm),
									.iData_to_SM					(data_in_sm),
									.iWrreq_IIB						(wr_iib),
									.iAddr_IIB						(addr_iib),
									.iData_to_IIB					(data_in_iib),
									//Output
									.oFull_SM						(full_sm),
									.oFull_IIB						(full_iib),
									.oAddr_OM						(addr_om),
									.oWrreq_to_IIBG_23x23			(wr_iibg_23),
									.oWrreq_to_IIBG_19x19			(wr_iibg_19),
									.oWrreq_to_IIBG_17x17			(wr_iibg_17),
									.oData_to_IIBG					(data_in_iibg),
									.oFinish						(finish_iib),
									.oEnd							(end_iib),
									.oEnd_n							(end_iib_n)
								);

iibg	IIBRAM_GROUP			(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iRst_IIBG						(rst_iibg),
									.iWrreq_to_IIBG_23x23			(wr_iibg_23),
									.iWrreq_to_IIBG_19x19			(wr_iibg_19),
									.iWrreq_to_IIBG_17x17			(wr_iibg_17),
									.iRdreq_to_IIBG_23x23			(rd_iibg_23),
									.iRdreq_to_IIBG_19x19			(rd_iibg_19),
									.iRdreq_to_IIBG_17x17			(rd_iibg_17),
									.iFull_23x23					(full_f_23),
									.iFull_19x19					(full_f_19),
									.iFull_17x17					(full_f_17),
									.iAddr_read_23x23				(r_addr_iibg_23),
									.iAddr_read_19x19				(r_addr_iibg_19),
									.iAddr_read_17x17				(r_addr_iibg_17),
									.iData_to_IIBG					(data_in_iibg),
									//Output
									.oOutput_ready_23x23			(outputready_23),
									.oOutput_ready_19x19			(outputready_19),
									.oOutput_ready_17x17			(outputready_17),
									.oData0_23x23					(odata0_23),
									.oData1_23x23					(odata1_23),
									.oData2_23x23					(odata2_23),
									.oData3_23x23					(odata3_23),
									.oData4_23x23					(odata4_23),
									.oData5_23x23					(odata5_23),
									.oData6_23x23					(odata6_23),
									.oData7_23x23					(odata7_23),
									.oData0_19x19					(odata0_19),
									.oData1_19x19					(odata1_19),
									.oData2_19x19					(odata2_19),
									.oData3_19x19					(odata3_19),
									.oData4_19x19					(odata4_19),
									.oData5_19x19					(odata5_19),
									.oData6_19x19					(odata6_19),
									.oData7_19x19					(odata7_19),
									.oData0_17x17					(odata0_17),
									.oData1_17x17					(odata1_17),
									.oData2_17x17					(odata2_17),
									.oData3_17x17					(odata3_17),
									.oData4_17x17					(odata4_17),
									.oData5_17x17					(odata5_17),
									.oData6_17x17					(odata6_17),
									.oData7_17x17					(odata7_17)
								);

detection	DETECTION			(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iReady_HFG_23					(outputready_23),
									.iRun_HFG_23					(run_hfg_23),
									.iRun_ANN_23					(run_ann_23),
									.iAddr_OM_23					(addr_om),
									.i4Rec0_23						(odata0_23),
									.i4Rec1_23						(odata1_23),
									.i4Rec2_23						(odata2_23),
									.i4Rec3_23						(odata3_23),
									.i4Rec4_23						(odata4_23),
									.i4Rec5_23						(odata5_23),
									.i4Rec6_23						(odata6_23),
									.i4Rec7_23						(odata7_23),
									.iReady_HFG_19					(outputready_19),
									.iRun_HFG_19					(run_hfg_19),
									.iRun_ANN_19					(run_ann_19),
									.iAddr_OM_19					(addr_om),
									.i4Rec0_19						(odata0_19),
									.i4Rec1_19						(odata1_19),
									.i4Rec2_19						(odata2_19),
									.i4Rec3_19						(odata3_19),
									.i4Rec4_19						(odata4_19),
									.i4Rec5_19						(odata5_19),
									.i4Rec6_19						(odata6_19),
									.i4Rec7_19						(odata7_19),
									.iReady_HFG_17					(outputready_17),
									.iRun_HFG_17					(run_hfg_17),
									.iRun_ANN_17					(run_ann_17),
									.iAddr_OM_17					(addr_om),
									.i4Rec0_17						(odata0_17),
									.i4Rec1_17						(odata1_17),
									.i4Rec2_17						(odata2_17),
									.i4Rec3_17						(odata3_17),
									.i4Rec4_17						(odata4_17),
									.i4Rec5_17						(odata5_17),
									.i4Rec6_17						(odata6_17),
									.i4Rec7_17						(odata7_17),
									//Output
									.oAddr_IIBG_23					(r_addr_iibg_23),
									.oRdreq_IIBG_23					(rd_iibg_23),
									.oFull_23						(full_f_23),
									.oFull_FBR_23					(full_fbr_23),
									.oFinish_23						(finish_hfg_23),
									.oWrreq_OM_23					(wr_om_23),
									.oAddr_OM_23					(w_addr_om_23),
									.oData_out_23					(data_detect_23),
									.oFinish_Stage_23				(finish_stage[0]),
									.oPass_23						(pass_ann_23),
									.oAddr_IIBG_19					(r_addr_iibg_19),
									.oRdreq_IIBG_19					(rd_iibg_19),
									.oFull_19						(full_f_19),
									.oFull_FBR_19					(full_fbr_19),
									.oFinish_19						(finish_hfg_19),
									.oWrreq_OM_19					(wr_om_19),
									.oAddr_OM_19					(w_addr_om_19),
									.oData_out_19					(data_detect_19),
									.oFinish_Stage_19				(finish_stage[1]),
									.oPass_19						(pass_ann_19),
									.oAddr_IIBG_17					(r_addr_iibg_17),
									.oRdreq_IIBG_17					(rd_iibg_17),
									.oFull_17						(full_f_17),
									.oFull_FBR_17					(full_fbr_17),
									.oFinish_17						(finish_hfg_17),
									.oWrreq_OM_17					(wr_om_17),
									.oAddr_OM_17					(w_addr_om_17),
									.oData_out_17					(data_detect_17),
									.oFinish_Stage_17				(finish_stage[2]),
									.oPass_17						(pass_ann_17)
								);
								
om	OBJECT_MAP					(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iRun_PostP						(run_postp),
									.iAddr_ANN_OM_23x23				(w_addr_om_23),
									.iAddr_PostP_OM_23x23			(wr_addr_om_23),
									.iWrreq_ANN_OM_23x23			(wr_om_23),
									.iWrreq_PostP_OM_23x23			(wr_zr_om_23),
									.iData_to_OM_23x23				(data_detect_23),
									.iZr_to_OM_23x23				(data_zr_om_23),
									.iAddr_ANN_OM_19x19				(w_addr_om_19),
									.iAddr_PostP_OM_19x19			(wr_addr_om_19),
									.iWrreq_ANN_OM_19x19			(wr_om_19),
									.iWrreq_PostP_OM_19x19			(wr_zr_om_19),
									.iData_to_OM_19x19				(data_detect_19),
									.iZr_to_OM_19x19				(data_zr_om_19),
									.iAddr_ANN_OM_17x17				(w_addr_om_17),
									.iAddr_PostP_OM_17x17			(wr_addr_om_17),
									.iWrreq_ANN_OM_17x17			(wr_om_17),
									.iWrreq_PostP_OM_17x17			(wr_zr_om_17),
									.iData_to_OM_17x17				(data_detect_17),	
									.iZr_to_OM_17x17				(data_zr_om_17),
									.iRun_Set_OM					(run_set_om),
									.iFinish_Set_OM					(finish_set_om),
									.iAddr_Set_OM					(addr_set_om),
									.iWrreq_Set_OM					(wr_set_om),
									.iData_Set_OM					(data_set_om),
									//Output
									.oData_from_OM_23x23			(data_to_postp_23),
									.oData_from_OM_19x19			(data_to_postp_19),
									.oData_from_OM_17x17			(data_to_postp_17),
									.oEnd							(end_om)
								);

post_process	POST_PROCESS	(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iRun							(run_postp),
									.iSet							(run_set_om),
									.iData_from_OM_23x23			(data_to_postp_23),
									.iData_from_OM_19x19			(data_to_postp_19),
									.iData_from_OM_17x17			(data_to_postp_17),
									.iWrite_wait_request			(iWrite_wait_request),
									//Output
									.oAddr_OM_23x23					(wr_addr_om_23),
									.oZero_OM_23x23					(data_zr_om_23),
									.oWrreq_OM_23x23				(wr_zr_om_23),
									.oAddr_OM_19x19					(wr_addr_om_19),
									.oZero_OM_19x19					(data_zr_om_19),
									.oWrreq_OM_19x19				(wr_zr_om_19),
									.oAddr_OM_17x17					(wr_addr_om_17),
									.oZero_OM_17x17					(data_zr_om_17),
									.oWrreq_OM_17x17				(wr_zr_om_17),
									.oAddr_OI						(oAddr_OI),
									.oWrreq_OI						(oWrreq_OI),
									.oData_to_OI					(oData_out),
									.oPostP_Finish					(finish_postp)
								);
								
set_om	SET_OM					(
									//Input
									.iClk							(iClk),
									.iReset_n						(iReset_n),
									.iRun							(run_set_om),
									//Output
									.oFinish						(finish_set_om),
									.oAddr_OM						(addr_set_om),
									.oWrreq_OM						(wr_set_om),
									.oData_to_OM					(data_set_om)
								);
						
endmodule

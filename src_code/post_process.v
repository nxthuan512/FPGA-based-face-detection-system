module	post_process	(
							//Input
							input					iClk,
							input					iReset_n,
							input					iRun,
							input					iSet,
							input		[31:0]		iData_from_OM_23x23,
							input		[31:0]		iData_from_OM_19x19,
							input		[31:0]		iData_from_OM_17x17,
							input					iWrite_wait_request,
							//Output
							output		[12:0]		oAddr_OM_23x23,
							output		[31:0]		oZero_OM_23x23,
							output					oWrreq_OM_23x23,
							output		[12:0]		oAddr_OM_19x19,
							output		[31:0]		oZero_OM_19x19,
							output					oWrreq_OM_19x19,
							output		[12:0]		oAddr_OM_17x17,
							output		[31:0]		oZero_OM_17x17,
							output					oWrreq_OM_17x17,
							output		[31:0]		oAddr_OI,
							output					oWrreq_OI,
							output		[31:0]		oData_to_OI,
							output					oPostP_Finish
						);

//================================REGISTERS===============================
reg		[2:0]		flag_reg;
reg					run_reg;
reg					fl_finish_reg;
reg					wr_oi_reg;
reg		[2:0]		end_reg;
reg					finish;
//==================================WIRES=================================
wire	[12:0]		position_23x23;
wire	[12:0]		position_19x19;
wire	[12:0]		position_17x17;
wire				outputready_23x23;
wire				outputready_19x19;
wire				outputready_17x17;
wire				end_23x23;
wire				end_19x19;
wire				end_17x17;
wire				olp_outputready;
wire	[1:0]		size;
wire	[20:0]		face_pos;
wire	[12:0]		mv_addr_23x23;
wire	[12:0]		mv_addr_19x19;
wire	[12:0]		mv_addr_17x17;
wire	[12:0]		zs_addr_23x23;
wire	[12:0]		zs_addr_19x19;
wire	[12:0]		zs_addr_17x17;
wire				zs_finish;
wire	[2:0]		flag;
wire				olp_finish;
wire				fl_finish;
wire				run_mv;
wire				end_face_cond;
//========================================================================
assign		oAddr_OM_23x23	=	(flag[0]) ? zs_addr_23x23 : mv_addr_23x23;
assign		oAddr_OM_19x19	=	(flag[1]) ? zs_addr_19x19 : mv_addr_19x19;
assign		oAddr_OM_17x17	=	(flag[2]) ? zs_addr_17x17 : mv_addr_17x17;
assign		flag[0]			=	(outputready_23x23) ? 1'b1 : (zs_finish) ? 1'b0 : flag_reg[0];
assign		flag[1]			=	(outputready_19x19) ? 1'b1 : (zs_finish) ? 1'b0 : flag_reg[1];
assign		flag[2]			=	(outputready_17x17) ? 1'b1 : (zs_finish) ? 1'b0 : flag_reg[2];
assign		run_mv			=	(zs_finish || ~run_reg) & iRun;
assign		oPostP_Finish	=	olp_finish & fl_finish_reg;
assign		end_face_cond	=	(~end_reg[0] & end_23x23) & (~end_reg[1] & end_19x19) & (~end_reg[2] & end_17x17);
//========================================================================
always @ (posedge iClk)
if (~iReset_n || finish)
begin
	flag_reg		<=	3'b0;
	run_reg			<=	1'b0;
	fl_finish_reg	<=	1'b0;
	wr_oi_reg		<=	1'b0;
	end_reg			<=	3'b0;
	finish			<=	1'b0;
end
else
begin
	flag_reg		<=	flag;
	run_reg			<=	iRun;
	wr_oi_reg		<=	oWrreq_OI;
	end_reg			<=	{end_17x17,end_19x19,end_23x23};
	finish			<=	oPostP_Finish;
	fl_finish_reg	<=	(fl_finish || end_face_cond) ? 1'b1 : (oWrreq_OI & ~wr_oi_reg) ? 1'b0 : fl_finish_reg;
end
//========================================================================
max_val_23x23	MAX_VAL_23x23	(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iRun_MV				(run_mv),
									.iData_in				(iData_from_OM_23x23),
									.iFinish				(finish),
									//Output
									.oRd_OM					(),
									.oAddr_OM				(mv_addr_23x23),
									.oOutput_ready			(outputready_23x23),
									.oPosition				(position_23x23),
									.oEnd					(end_23x23)
								);

max_val_19x19	MAX_VAL_19x19	(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iRun_MV				(run_mv),
									.iData_in				(iData_from_OM_19x19),
									.iFinish				(finish),
									//Output
									.oRd_OM					(),
									.oAddr_OM				(mv_addr_19x19),
									.oOutput_ready			(outputready_19x19),
									.oPosition				(position_19x19),
									.oEnd					(end_19x19)
								);

max_val_17x17	MAX_VAL_17x17	(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iRun_MV				(run_mv),
									.iData_in				(iData_from_OM_17x17),
									.iFinish				(finish),
									//Output
									.oRd_OM					(),
									.oAddr_OM				(mv_addr_17x17),
									.oOutput_ready			(outputready_17x17),
									.oPosition				(position_17x17),
									.oEnd					(end_17x17)
								);

olp	OVERLAP_PROCESS				(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iSet					(iSet),
									.iInput_ready_23x23		(outputready_23x23),
									.iEnd_23x23				(end_23x23),
									.iPosition_23x23		(position_23x23),
									.iInput_ready_19x19		(outputready_19x19),
									.iEnd_19x19				(end_19x19),
									.iPosition_19x19		(position_19x19),
									.iInput_ready_17x17		(outputready_17x17),
									.iEnd_17x17				(end_17x17),
									.iPosition_17x17		(position_17x17),
									//Output
									.oOutput_ready			(olp_outputready),
									.oSize					(size),
									.oFace_Pos				(face_pos),
									.oFinish				(olp_finish)
								);
								
zs	ZERO_SETTING					(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iInput_ready_23x23		(outputready_23x23),
									.iPosition_23x23		(position_23x23),
									.iInput_ready_19x19		(outputready_19x19),
									.iPosition_19x19		(position_19x19),
									.iInput_ready_17x17		(outputready_17x17),
									.iPosition_17x17		(position_17x17),
									//Output
									.oAddr_OM_23x23			(zs_addr_23x23),
									.oZero_OM_23x23			(oZero_OM_23x23),
									.oWrreq_OM_23x23		(oWrreq_OM_23x23),
									.oAddr_OM_19x19			(zs_addr_19x19),
									.oZero_OM_19x19			(oZero_OM_19x19),
									.oWrreq_OM_19x19		(oWrreq_OM_19x19),
									.oAddr_OM_17x17			(zs_addr_17x17),
									.oZero_OM_17x17			(oZero_OM_17x17),
									.oWrreq_OM_17x17		(oWrreq_OM_17x17),
									.oFinish				(zs_finish)
								);
								
fl	FACE_LOCALIZATION			(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iInput_ready			(olp_outputready),
									.iWrite_wait_request	(iWrite_wait_request),
									.iSize					(size),
									.iFace_Pos				(face_pos),
									//Output
									.oAddr_OI				(oAddr_OI),
									.oWrreq_OI				(oWrreq_OI),
									.oData_to_OI			(oData_to_OI),
									.oFinish_Draw			(fl_finish)
								);
								
endmodule

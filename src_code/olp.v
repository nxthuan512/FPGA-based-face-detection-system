module olp	(
				//Input
				input				iClk,
				input				iReset_n,
				input				iSet,
				input				iInput_ready_23x23,
				input				iEnd_23x23,
				input		[12:0]	iPosition_23x23,
				input				iInput_ready_19x19,
				input				iEnd_19x19,
				input		[12:0]	iPosition_19x19,
				input				iInput_ready_17x17,
				input				iEnd_17x17,
				input		[12:0]	iPosition_17x17,
				//Output
				output				oOutput_ready,
				output		[1:0]	oSize,
				output		[20:0]	oFace_Pos,
				output				oFinish
			);
//===========================WIRES===========================
wire	[12:0]		position_19x19;
wire	[12:0]		position_17x17;
wire				run_implement;
wire	[12:0]		position;
wire	[1:0]		size;
wire	[1:0]		pass;
wire	[2:0]		sel;
wire				empty_19x19;
wire				empty_17x17;
wire				rd_19x19;
wire				rd_17x17;
wire				finish;
//===========================================================
olp_control	CONTROLLER			(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iInput_ready_23x23		(iInput_ready_23x23),
									.iEnd_23x23				(iEnd_23x23),
									.iInput_ready_19x19		(iInput_ready_19x19),
									.iEnd_19x19				(iEnd_19x19	),
									.iInput_ready_17x17		(iInput_ready_17x17),
									.iEnd_17x17				(iEnd_17x17),
									.iEmpty_FF_17x17		(empty_17x17),
									.iEmpty_FF_19x19		(empty_19x19),
									.iPass					(pass),
									.iFinish				(finish),
									//Output
									.oRd_FF_17x17			(rd_17x17),
									.oRd_FF_19x19			(rd_19x19),
									.oSel_Mux				(sel),
									.oRun_Implement			(run_implement),
									.oSize					(size),
									.oOutput_ready			(oOutput_ready),
									.oFinish				(oFinish)
								);

olp_implement	IMPLEMENT		(
									//Input
									.iClk					(iClk),
									.iReset_n				(iReset_n),
									.iRun					(run_implement),
									.iSet					(iSet),
									.iPosition				(position),
									.iSize					(size),
									//Output	
									.oPass					(pass),
									.oFinish				(finish),
									.oSize					(oSize),
									.oFace_Pos				(oFace_Pos)
								);
								
scfifo_pos_19x19	FIFO_19x19	(
									.clock					(iClk),
									.data					(iPosition_19x19),
									.rdreq					(rd_19x19),
									.wrreq					(iInput_ready_19x19),
									.empty					(empty_19x19),
									.full					(),
									.q						(position_19x19)
								);

scfifo_pos_17x17	FIFO_17x17	(
									.clock					(iClk),
									.data					(iPosition_17x17),
									.rdreq					(rd_17x17),
									.wrreq					(iInput_ready_17x17),
									.empty					(empty_17x17),
									.full					(),
									.q						(position_17x17)
								);

olp_mux_3to1	MUX_3to1		(
									.isel					(sel),
									.idata0					(iPosition_23x23),
									.idata1					(position_19x19),
									.idata2					(position_17x17),
									.odata					(position)
								);
								
endmodule

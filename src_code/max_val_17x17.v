module max_val_17x17 	(
							//Input
							input				iClk,
							input				iReset_n,
							input				iRun_MV,
							input		[31:0]	iData_in,
							input				iFinish,
							//Output
							output				oRd_OM,
							output		[12:0]	oAddr_OM,
							output				oOutput_ready,
							output		[12:0]	oPosition,
							output				oEnd
						);
//========================REGISTERS=====================================
reg		flag_reg;
//==========================WIRES=======================================
wire	[31:0]	sum_5x5;
wire			sum_finish;
wire			run_sum;
wire	[4:0]	rd_ff;
wire	[4:0]	wr_ff;
wire	[4:0]	ff_full;
wire	[12:0]	i_position;
wire	[12:0]	o_position;
wire	[31:0]	max_val;
wire			data_ready;
wire			rst_reg;
wire	[12:0]	addr_om_th;
wire	[12:0]	addr_om_ct;
wire			flag;
//======================================================================
assign	flag		=	(data_ready) ? 1'b1 : (oOutput_ready) ? 1'b0 : flag_reg;
assign	oAddr_OM	=	(flag) ? addr_om_th : addr_om_ct;
//======================================================================
always	@ (posedge iClk)
if (~iReset_n)
	flag_reg	<=	1'b0;
else
	flag_reg	<=	flag;
//======================================================================
mv_control	CONTROLLER		(
								//Input
								.iClk				(iClk),
								.iReset_n			(iReset_n),
								.iRun_MV			(iRun_MV),
								.iFF_full			(ff_full),
								.iSum_finish		(sum_finish),
								//Output
								.oRun_sum			(run_sum),
								.oRst_reg			(rst_reg),
								.oRdreq_FF			(rd_ff),
								.oWrreq_FF			(wr_ff),
								.oRd_OM				(oRd_OM),
								.oAddr_OM			(addr_om_ct),
								.oPosition			(i_position),
								.oOutput_ready		(data_ready)
							);

mv_sum_5x5	SUM5x5			(
								//Input
								.iClk				(iClk),
								.iReset_n			(iReset_n),
								.iRun				(run_sum),
								.iRdreq				(rd_ff),
								.iWrreq				(wr_ff),
								.iData_in			(iData_in),
								//Output
								.oFF_full			(ff_full),
								.oFinish			(sum_finish),
								.oData_out			(sum_5x5)
							);

mv_find_max	FINDMAX			(
								//Input
								.iClk				(iClk),
								.iReset_n			(iReset_n),
								.iRst_reg			(rst_reg),
								.iPosition			(i_position),
								.iData_in			(sum_5x5),
								//Output
								.oPosition			(o_position),
								.oMax_val			(max_val)
							);

threshold_17x17	THRESHOLD	(
								//Input
								.iClk				(iClk),
								.iReset_n			(iReset_n),
								.iInput_ready		(data_ready),
								.iPosition			(o_position),
								.iMax_val			(max_val),
								.iFinish			(iFinish),
								.iData_from_OM		(iData_in),
								//Output
								.oAddr_OM			(addr_om_th),
								.oPosition			(oPosition),
								.oOutput_ready		(oOutput_ready),
								.oEnd				(oEnd)
							);						

endmodule

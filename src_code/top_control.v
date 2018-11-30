module	top_control	(
						//Input
						input						iClk,
						input						iReset_n,
						input						iInput_ready_from_DMA,
						input						iFull_SM,
						input						iFull_IIB,
						input			[1:0]		iFinish_IIB,
						input						iEnd_IIB,
						input						iEnd_IIB_n,
						input						iFull_FBR_23x23,
						input						iFinish_HFG_23x23,
						input						iPass_ANN_23x23,
						input						iFinish_ANN_23x23,
						input						iFull_FBR_19x19,
						input						iFinish_HFG_19x19,
						input						iPass_ANN_19x19,
						input						iFinish_ANN_19x19,
						input						iFull_FBR_17x17,
						input						iFinish_HFG_17x17,
						input						iPass_ANN_17x17,
						input						iFinish_ANN_17x17,
						input			[2:0]		iFinish_Stage,
						input						iEnd_OM,
						input						iFinish_PostP,
						input						iFinish_Set_OM,
						//Output
						output		reg				oRun_IIG,
						output		reg				oRun_IIB,
						output		reg				oRun_HFG_23x23,
						output		reg				oRun_ANN_23x23,
						output		reg				oRun_HFG_19x19,
						output		reg				oRun_ANN_19x19,
						output		reg				oRun_HFG_17x17,
						output		reg				oRun_ANN_17x17,
						output		reg				oRun_PostP,
						output						oRun_Set_OM
					);

parameter		CLASSIFIER_1 = 7'd3,
				CLASSIFIER_2 = 7'd9,
				CLASSIFIER_3 = 7'd15,
				CLASSIFIER_4 = 7'd21,
				CLASSIFIER_5 = 7'd33,
				CLASSIFIER_6 = 7'd49,
				CLASSIFIER_7 = 7'd61,
				CLASSIFIER_8 = 7'd81,
				CLASSIFIER_9 = 7'd115;
//=================================REGISTERS===================================
reg		[6:0]		counter_23;
reg		[6:0]		counter_19;
reg		[6:0]		counter_17;
reg		[1:0]		counter;
reg		[3:0]		en_ann_23_reg;
reg		[3:0]		en_ann_19_reg;
reg		[3:0]		en_ann_17_reg;
reg		[2:0]		finish_hfg;
reg					end_iib_reg;
reg		[2:0]		end_hfg_reg;
reg		[1:0]		finish_iib_reg;
//===================================WIRES=====================================
wire				run_iig;
wire				run_iib;
wire				run_hfg_23;
wire				run_ann_23;
wire				run_hfg_19;
wire				run_ann_19;
wire				run_hfg_17;
wire				run_ann_17;
wire				run_postp;
wire	[1:0]		cond;
wire	[3:0]		en_ann_23;
wire	[3:0]		en_ann_19;
wire	[3:0]		en_ann_17;
wire				cond_23;
wire				cond_19;
wire				cond_17;
wire				end_iib;
wire	[2:0]		end_hfg;
wire 				counter_cond;
wire	[1:0]		finish_iib;
//=============================================================================
assign	run_iig		=	(iInput_ready_from_DMA) ? 1'b1 : (iFull_IIB) ? 1'b0 : oRun_IIG;
assign	run_iib		=	((iFull_IIB || counter_cond) & ~end_iib) ? 1'b1 : ((|iFinish_IIB) || iEnd_IIB_n) ? 1'b0 : oRun_IIB;
assign	run_hfg_23	=	((&iFinish_IIB) & ~end_hfg[0]) ? 1'b1 : (iFull_FBR_23x23 || iFinish_ANN_23x23) ? 1'b0 : oRun_HFG_23x23;
assign	run_hfg_19	=	(iFinish_IIB[1] & ~end_hfg[1]) ? 1'b1 : (iFull_FBR_19x19 || iFinish_ANN_19x19) ? 1'b0 : oRun_HFG_19x19;
assign	run_hfg_17	=	((|iFinish_IIB) & ~end_hfg[2]) ? 1'b1 : (iFull_FBR_17x17 || iFinish_ANN_17x17) ? 1'b0 : oRun_HFG_17x17;
assign	run_postp	=	(iEnd_OM || iEnd_IIB_n) ? 1'b1 : (iFinish_PostP) ? 1'b0 : oRun_PostP;
assign	oRun_Set_OM	=	iFinish_PostP;

assign	counter_cond	=	((counter == 2'd3) & (&finish_iib)) || ((counter == 2'd2) & finish_iib[1] & ~finish_iib[0]) || ((counter == 2'd1) & finish_iib[0] & ~finish_iib[1]);
assign	finish_iib		=	(&iFinish_IIB) ? 2'd3 : (iFinish_IIB[1]) ? 2'd2 : (iFinish_IIB[0]) ? 2'd1 : (oRun_IIB) ? 2'b0 : finish_iib_reg;

assign	end_iib		=	(iEnd_IIB || iEnd_IIB_n) ? 1'b1 : (iFinish_PostP) ? 1'b0 : end_iib_reg;
assign	end_hfg[0]	=	((end_iib & iFinish_ANN_23x23) || iEnd_IIB_n) ? 1'b1 : end_hfg_reg[0];
assign	end_hfg[1]	=	((end_iib & iFinish_ANN_19x19) || iEnd_IIB_n) ? 1'b1 : end_hfg_reg[1];
assign	end_hfg[2]	=	((end_iib & iFinish_ANN_17x17) || iEnd_IIB_n) ? 1'b1 : end_hfg_reg[2];

assign	cond		=	(iFinish_ANN_23x23 + iFinish_ANN_19x19) + iFinish_ANN_17x17;

assign	cond_23		=	((counter_23 == CLASSIFIER_1) || (counter_23 == CLASSIFIER_2) || (counter_23 == CLASSIFIER_3) || (counter_23 == CLASSIFIER_4) || (counter_23 == CLASSIFIER_5) || (counter_23 == CLASSIFIER_6) || (counter_23 == CLASSIFIER_7) || (counter_23 == CLASSIFIER_8) || (counter_23 == CLASSIFIER_9)) & finish_hfg[0];
assign	en_ann_23	=	(cond_23) ? (en_ann_23_reg + 1'b1) : (iFinish_ANN_23x23 || iFinish_Stage[0]) ? (en_ann_23_reg + 4'hF) : en_ann_23_reg;
assign	run_ann_23		=	|en_ann_23;

assign	cond_19		=	((counter_19 == CLASSIFIER_1) || (counter_19 == CLASSIFIER_2) || (counter_19 == CLASSIFIER_3) || (counter_19 == CLASSIFIER_4) || (counter_19 == CLASSIFIER_5) || (counter_19 == CLASSIFIER_6) || (counter_19 == CLASSIFIER_7) || (counter_19 == CLASSIFIER_8) || (counter_19 == CLASSIFIER_9)) & finish_hfg[1];
assign	en_ann_19	=	(cond_19) ? (en_ann_19_reg + 1'b1) : (iFinish_ANN_19x19 || iFinish_Stage[1]) ? (en_ann_19_reg + 4'hF) : en_ann_19_reg;
assign	run_ann_19		=	|en_ann_19;

assign	cond_17		=	((counter_17 == CLASSIFIER_1) || (counter_17 == CLASSIFIER_2) || (counter_17 == CLASSIFIER_3) || (counter_17 == CLASSIFIER_4) || (counter_17 == CLASSIFIER_5) || (counter_17 == CLASSIFIER_6) || (counter_17 == CLASSIFIER_7) || (counter_17 == CLASSIFIER_8) || (counter_17 == CLASSIFIER_9)) & finish_hfg[2];
assign	en_ann_17	=	(cond_17) ? (en_ann_17_reg + 1'b1) : (iFinish_ANN_17x17 || iFinish_Stage[2]) ? (en_ann_17_reg + 4'hF) : en_ann_17_reg;
assign	run_ann_17		=	|en_ann_17;
//=============================================================================
always	@ (posedge iClk)
if (~iReset_n || iFinish_Set_OM)
begin
	oRun_IIG		<=	1'b0;
	oRun_IIB		<=	1'b0;
	oRun_HFG_23x23	<=	1'b0;
	oRun_ANN_23x23	<=	1'b0;
	oRun_HFG_19x19	<=	1'b0;
	oRun_ANN_19x19	<=	1'b0;
	oRun_HFG_17x17	<=	1'b0;
	oRun_ANN_17x17	<=	1'b0;
	oRun_PostP		<=	1'b0;
	en_ann_23_reg	<=	4'b0;
	en_ann_19_reg	<=	4'b0;
	en_ann_17_reg	<=	4'b0;
	counter_23		<=	7'b0;
	counter_19		<=	7'b0;
	counter_17		<=	7'b0;
	counter			<=	2'b0;
	finish_hfg		<=	3'b0;
	end_iib_reg		<=	1'b0;
	end_hfg_reg		<=	3'b0;
	finish_iib_reg	<=	1'b0;
end
else
begin
	oRun_IIG		<=	run_iig;
	oRun_IIB		<=	run_iib;
	oRun_HFG_23x23	<=	run_hfg_23;
	oRun_ANN_23x23	<=	run_ann_23;
	oRun_PostP		<=	run_postp;
	en_ann_23_reg	<=	en_ann_23;
	oRun_HFG_19x19	<=	run_hfg_19;
	oRun_ANN_19x19	<=	run_ann_19;
	en_ann_19_reg	<=	en_ann_19;
	oRun_HFG_17x17	<=	run_hfg_17;
	oRun_ANN_17x17	<=	run_ann_17;
	en_ann_17_reg	<=	en_ann_17;
	finish_hfg[0]	<=	iFinish_HFG_23x23;
	finish_hfg[1]	<=	iFinish_HFG_19x19;
	finish_hfg[2]	<=	iFinish_HFG_17x17;
	end_iib_reg		<=	end_iib;
	end_hfg_reg		<=	end_hfg;
	finish_iib_reg	<=	finish_iib;
	
	if (iFinish_HFG_23x23)
		counter_23	<= counter_23 + 1'b1;
	if (iFinish_HFG_19x19)
		counter_19	<= counter_19 + 1'b1;
	if (iFinish_HFG_17x17)
		counter_17	<= counter_17 + 1'b1;
	if (~run_iib & oRun_IIB)
	begin
		counter_23	<= 7'b0;
		counter_19	<= 7'b0;
		counter_17	<= 7'b0;
	end
	if (|cond)
		counter		<=	counter + cond;
	if (counter_cond)
		counter		<=	2'b0;
end

endmodule

module	olp_control	(
						//Input
						input				iClk,
						input				iReset_n,
						input				iInput_ready_23x23,
						input				iEnd_23x23,
						input				iInput_ready_19x19,
						input				iEnd_19x19,
						input				iInput_ready_17x17,
						input				iEnd_17x17,
						input				iEmpty_FF_17x17,
						input				iEmpty_FF_19x19,
						input		[1:0]	iPass,
						input				iFinish,
						//Output
						output				oRd_FF_17x17,
						output				oRd_FF_19x19,
						output		[2:0]	oSel_Mux,
						output				oRun_Implement,
						output		[1:0]	oSize,
						output				oOutput_ready,
						output	reg			oFinish
					);

//==========================REGISTERS=======================================
reg				en_23x23_reg;
reg				en_19x19_reg;
reg				en_17x17_reg;
reg				run_reg;
reg				end_23x23_delay;
reg				end_23x23;
reg				end_19x19_delay;
reg				end_19x19;
reg				rd_19x19;
reg				rd_17x17;
reg		[2:0]	sel;
reg		[1:0]	size;
reg		[1:0]	flag_reg;
reg		[1:0]	cond3_reg;
reg		[1:0]	cond4_reg;
reg		[1:0]	neg_end_23_reg;
reg				inputready_19;
reg		[1:0]	inputready_17;
//============================WIRES=========================================
wire			en_23x23;
wire			en_19x19;
wire			en_17x17;
wire			cond1;
wire			cond2;
wire			cond3;
wire			cond4;
wire			cond5;
wire			neg_end_23;
wire	[1:0]	flag;
//==========================================================================
assign	flag[0]			=	(en_23x23_reg) ? 1'b1 : flag_reg[0];
assign	flag[1]			=	(en_19x19_reg) ? 1'b1 : flag_reg[1];
	
assign	en_23x23		=	(iInput_ready_23x23 & ~iEnd_23x23) ? 1'b1 : (iEnd_23x23) ? 1'b0 : en_23x23_reg;
assign	cond1			=	(flag[0]) ? (iEmpty_FF_19x19 & iFinish) : iEnd_19x19;
assign	en_19x19		=	(~en_23x23_reg & ~iEmpty_FF_19x19) ? 1'b1 : (cond1) ? 1'b0 : en_19x19_reg;
assign	cond2			=	(flag[1]) ? (iEmpty_FF_17x17 & iFinish) : iEnd_17x17;
assign	en_17x17		=	(~en_23x23_reg & ~en_19x19_reg & ~iEmpty_FF_17x17) ? 1'b1 : (cond2) ? 1'b0 : en_17x17_reg;

assign	neg_end_23		=	iEnd_23x23 & ~end_23x23;
assign	cond3			=	(inputready_19 & ~flag[0]) || (iFinish & flag[0] & ~iEmpty_FF_19x19) || neg_end_23;
assign	oRd_FF_19x19	=	en_19x19_reg & cond3_reg[1];
assign	cond4			=	((inputready_17[1] || (neg_end_23_reg[1] & flag[0])) & ~flag[1]) || (iFinish & flag[1] & ~iEmpty_FF_17x17) || (iEnd_19x19 & ~end_19x19);
assign	oRd_FF_17x17	=	en_17x17_reg & cond4_reg[1];
assign	oOutput_ready	=	(iPass == 2'b11);
assign	oRun_Implement	=	(en_23x23_reg || (en_19x19_reg & rd_19x19) || (en_17x17_reg & rd_17x17)) ? 1'b1 : (iFinish) ? 1'b0 : run_reg;
assign	oSel_Mux		=	(en_23x23_reg) ? 3'b001 : (en_19x19_reg) ? 3'b010 : (en_17x17_reg) ? 3'b100 : sel;
assign	oSize			=	(en_23x23_reg) ? 2'd0 : (en_19x19_reg) ? 2'd1 : (en_17x17_reg) ? 2'd2 : size;
assign	cond5			=	~en_23x23_reg & ~en_19x19_reg & ~en_17x17_reg;
//==========================================================================
always @ (posedge iClk)
if (~iReset_n)
begin
	en_23x23_reg	<=	1'b0;
	en_19x19_reg	<=	1'b0;
	en_17x17_reg	<=	1'b0;
	run_reg			<=	1'b0;
	end_23x23_delay	<=	1'b0;
	end_23x23		<=	1'b0;
	end_19x19_delay	<=	1'b0;
	end_19x19		<=	1'b0;
	rd_19x19		<=	1'b0;
	rd_17x17		<=	1'b0;
	sel				<=	3'b0;
	size			<=	2'b0;
	flag_reg		<=	2'b0;
	cond3_reg		<=	2'b0;
	cond4_reg		<=	2'b0;
	inputready_19	<=	1'b0;
	inputready_17	<=	2'b0;
	neg_end_23_reg	<=	2'b0;
	oFinish			<=	1'b0;
end
else
begin
	en_23x23_reg		<=	en_23x23;
	en_19x19_reg		<=	en_19x19;
	en_17x17_reg		<=	en_17x17;
	end_23x23_delay		<=	iEnd_23x23;
	end_19x19_delay		<=	iEnd_19x19;
	end_23x23			<=	end_23x23_delay;
	end_19x19			<=	end_19x19_delay;
	rd_19x19			<=	oRd_FF_19x19;
	rd_17x17			<=	oRd_FF_17x17;
	run_reg				<=	oRun_Implement;
	sel					<=	oSel_Mux;
	size				<=	oSize;
	flag_reg[0]			<=	(~cond5) ? flag[0] : 1'b0;
	flag_reg[1]			<=	(~cond5) ? flag[1] : 1'b0;
	inputready_17[0]	<=	iInput_ready_17x17;
	inputready_17[1]	<=	inputready_17[0];
	inputready_19		<=	iInput_ready_19x19;
	cond3_reg[0]		<=	cond3;
	cond3_reg[1]		<=	cond3_reg[0];
	cond4_reg[0]		<=	cond4;
	cond4_reg[1]		<=	cond4_reg[0];
	neg_end_23_reg[0]	<=	neg_end_23;
	neg_end_23_reg[1]	<=	neg_end_23_reg[0];
	oFinish				<=	cond5;
end					

endmodule

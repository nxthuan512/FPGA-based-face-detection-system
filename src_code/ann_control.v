module	ann_control	(
						//Input
						input						iClk,
						input						iReset_n,
						input						iRun_ANN,
						input						iOutput_ready_from_LOGSIG,
						input						iOutput_ready_from_THRESHOLD,
						input						iFlag_from_THRESHOLD,
						input						iEmpty_FF_Stage9,
						//Output
						output	reg		[1:0]		oSel_Mux3,
						output	reg		[4:0]		oSel_Mux20,
						output	reg		[19:0]		oInput_ready_to_MAC,
						output	reg					oFinish_to_MAC,
						output	reg					oInput_ready_to_LOGSIG,
						output	reg					oInput_ready_to_THRESHOLD,
						output	reg		[6:0]		oAddr_FBR,
						output	reg					oWrreq_FF_Stage9,
						output	reg					oRdreq_FF_Stage9,
						output						oWrreq_OM,
						output						oPass,
						output	reg					oFinish_Stage,
						output			[9:0]		oAddr_ROM_0,
						output			[8:0]		oAddr_ROM_1,
						output			[8:0]		oAddr_ROM_2,
						output			[8:0]		oAddr_ROM_3,
						output			[8:0]		oAddr_ROM_4,
						output			[8:0]		oAddr_ROM_5,
						output			[8:0]		oAddr_ROM_6,
						output			[8:0]		oAddr_ROM_7,
						output			[8:0]		oAddr_ROM_8,
						output			[8:0]		oAddr_ROM_9,
						output			[8:0]		oAddr_ROM_10,
						output			[8:0]		oAddr_ROM_11,
						output			[8:0]		oAddr_ROM_12,
						output			[8:0]		oAddr_ROM_13,
						output			[8:0]		oAddr_ROM_14,
						output			[8:0]		oAddr_ROM_15,
						output			[8:0]		oAddr_ROM_16,
						output			[8:0]		oAddr_ROM_17,
						output			[8:0]		oAddr_ROM_18,
						output			[8:0]		oAddr_ROM_19
					);
	
//=================================REGISTERS====================================
reg		[2:0]		state;
reg		[19:0]		incr_addr_rom;
reg		[3:0]		stage;
reg		[6:0]		counter;
reg		[1:0]		counter_logsig;
reg		[1:0]		flag;
reg					rst_rom_g0_reg;
reg					rst_rom_g1_reg;
reg					rst_rom_g2_reg;
reg					rst_rom_g3_reg;
reg					rst_rom_g4_reg;
reg					rst_rom_g5_reg;

reg		[9:0]		addr_rom_0_reg;
reg		[8:0]		addr_rom_1_reg;
reg		[8:0]		addr_rom_2_reg;
reg		[8:0]		addr_rom_3_reg;
reg		[8:0]		addr_rom_4_reg;
reg		[8:0]		addr_rom_5_reg;
reg		[8:0]		addr_rom_6_reg;
reg		[8:0]		addr_rom_7_reg;
reg		[8:0]		addr_rom_8_reg;
reg		[8:0]		addr_rom_9_reg;
reg		[8:0]		addr_rom_10_reg;
reg		[8:0]		addr_rom_11_reg;
reg		[8:0]		addr_rom_12_reg;
reg		[8:0]		addr_rom_13_reg;
reg		[8:0]		addr_rom_14_reg;
reg		[8:0]		addr_rom_15_reg;
reg		[8:0]		addr_rom_16_reg;
reg		[8:0]		addr_rom_17_reg;
reg		[8:0]		addr_rom_18_reg;
reg		[8:0]		addr_rom_19_reg;
//===================================WIRES======================================
wire				cond0;
wire				cond1;
wire				cond2;
wire				cond3;
wire				cond4;
wire				cond5;
wire				cond6;
wire				cond7;
wire				cond8;
wire				cond9;
wire				cond10;
wire				rst_rom_g0;
wire				rst_rom_g1;
wire				rst_rom_g2;
wire				rst_rom_g3;
wire				rst_rom_g4;
wire				rst_rom_g5;
wire				cond_group;
wire				end_feature;
wire				end_output_logsig;
wire				wr_om;
wire				en_use_ff;
wire				use_ff;
wire	[19:0]		incr_val;
//==============================================================================
assign	oAddr_ROM_0		=	(rst_rom_g0_reg) ? 10'b0 : (incr_addr_rom[0]) ? (addr_rom_0_reg + 1'b1) : addr_rom_0_reg;
assign	oAddr_ROM_1		=	(rst_rom_g1_reg) ? 9'b0 : (incr_addr_rom[1]) ? (addr_rom_1_reg + 1'b1) : addr_rom_1_reg;
assign	oAddr_ROM_2		=	(rst_rom_g1_reg) ? 9'b0 : (incr_addr_rom[2]) ? (addr_rom_2_reg + 1'b1) : addr_rom_2_reg;
assign	oAddr_ROM_3		=	(rst_rom_g1_reg) ? 9'b0 : (incr_addr_rom[3]) ? (addr_rom_3_reg + 1'b1) : addr_rom_3_reg;
assign	oAddr_ROM_4		=	(rst_rom_g1_reg) ? 9'b0 : (incr_addr_rom[4]) ? (addr_rom_4_reg + 1'b1) : addr_rom_4_reg;
assign	oAddr_ROM_5		=	(rst_rom_g2_reg) ? 9'b0 : (incr_addr_rom[5]) ? (addr_rom_5_reg + 1'b1) : addr_rom_5_reg;
assign	oAddr_ROM_6		=	(rst_rom_g2_reg) ? 9'b0 : (incr_addr_rom[6]) ? (addr_rom_6_reg + 1'b1) : addr_rom_6_reg;
assign	oAddr_ROM_7		=	(rst_rom_g2_reg) ? 9'b0 : (incr_addr_rom[7]) ? (addr_rom_7_reg + 1'b1) : addr_rom_7_reg;
assign	oAddr_ROM_8		=	(rst_rom_g2_reg) ? 9'b0 : (incr_addr_rom[8]) ? (addr_rom_8_reg + 1'b1) : addr_rom_8_reg;
assign	oAddr_ROM_9		=	(rst_rom_g2_reg) ? 9'b0 : (incr_addr_rom[9]) ? (addr_rom_9_reg + 1'b1) : addr_rom_9_reg;
assign	oAddr_ROM_10	=	(rst_rom_g3_reg) ? 9'b0 : (incr_addr_rom[10]) ? (addr_rom_10_reg + 1'b1) : addr_rom_10_reg;
assign	oAddr_ROM_11	=	(rst_rom_g4_reg) ? 9'b0 : (incr_addr_rom[11]) ? (addr_rom_11_reg + 1'b1) : addr_rom_11_reg;
assign	oAddr_ROM_12	=	(rst_rom_g4_reg) ? 9'b0 : (incr_addr_rom[12]) ? (addr_rom_12_reg + 1'b1) : addr_rom_12_reg;
assign	oAddr_ROM_13	=	(rst_rom_g4_reg) ? 9'b0 : (incr_addr_rom[13]) ? (addr_rom_13_reg + 1'b1) : addr_rom_13_reg;
assign	oAddr_ROM_14	=	(rst_rom_g4_reg) ? 9'b0 : (incr_addr_rom[14]) ? (addr_rom_14_reg + 1'b1) : addr_rom_14_reg;
assign	oAddr_ROM_15	=	(rst_rom_g5_reg) ? 9'b0 : (incr_addr_rom[15]) ? (addr_rom_15_reg + 1'b1) : addr_rom_15_reg;
assign	oAddr_ROM_16	=	(rst_rom_g5_reg) ? 9'b0 : (incr_addr_rom[16]) ? (addr_rom_16_reg + 1'b1) : addr_rom_16_reg;
assign	oAddr_ROM_17	=	(rst_rom_g5_reg) ? 9'b0 : (incr_addr_rom[17]) ? (addr_rom_17_reg + 1'b1) : addr_rom_17_reg;
assign	oAddr_ROM_18	=	(rst_rom_g5_reg) ? 9'b0 : (incr_addr_rom[18]) ? (addr_rom_18_reg + 1'b1) : addr_rom_18_reg;
assign	oAddr_ROM_19	=	(rst_rom_g5_reg) ? 9'b0 : (incr_addr_rom[19]) ? (addr_rom_19_reg + 1'b1) : addr_rom_19_reg;

assign	cond0		=	counter == 7'd3;
assign	cond1		=	counter == 7'd9;
assign	cond2		=	counter == 7'd15;
assign	cond3		=	counter == 7'd21;
assign	cond4		=	counter == 7'd33;
assign	cond5		=	counter == 7'd49;
assign	cond6		=	counter == 7'd61;
assign	cond7		=	counter == 7'd81;
assign	cond8		=	counter == 7'd115;
assign	cond9		=	counter == 7'd20;
assign	cond10		=	counter == 7'd10;
assign	end_feature	=	(stage == 4'd0) ? cond0 
										: (stage == 4'd1) ? cond1
										: (stage == 4'd2) ? cond2
										: (stage == 4'd3) ? cond3
										: (stage == 4'd4) ? cond4
										: (stage == 4'd5) ? cond5
										: (stage == 4'd6) ? cond6
										: (stage == 4'd7) ? cond7
										: (stage == 4'd8) ? cond7
										: (stage == 4'd9) ? cond8
										: (stage == 4'd10) ? cond9
										: (stage == 4'd11) ? cond10 : 1'b0;

assign	cond_group	= 	(stage == 4'd2 || stage == 4'd3) || stage == 4'd10;
									
assign	end_output_logsig	=	(cond_group) ?  (oSel_Mux20 == 5'd9)
										: (stage == 4'd4) ? (oSel_Mux20 == 5'd14)
										: (stage == 4'd11) ? (oSel_Mux20 == 5'd4) 
										: (stage == 4'd8) ? (oSel_Mux20 == 5'd10) : (oSel_Mux20 == 5'd19);
assign	wr_om		=	iFlag_from_THRESHOLD || (stage == 4'd11);
assign	oWrreq_OM	=	wr_om  & iOutput_ready_from_THRESHOLD;
assign	oPass		=	iFlag_from_THRESHOLD;
assign	incr_val	=	(cond_group) ? 20'h003FF : (stage == 4'd4) ? 20'h07FFF : (stage == 4'd11) ? 20'h0001F : 20'hFFFFF; 
assign	en_use_ff	=	stage == 4'd9 || stage == 4'd10;
assign	use_ff		=	stage == 4'd10 || stage == 4'd11;

assign	rst_rom_g0	=	oAddr_ROM_0 == 10'd586;
assign	rst_rom_g1	=	oAddr_ROM_1 == 9'd509;
assign	rst_rom_g2	=	oAddr_ROM_5 == 9'd498;
assign	rst_rom_g3	=	oAddr_ROM_10 == 9'd439;
assign	rst_rom_g4	=	oAddr_ROM_11 == 9'd357;
assign	rst_rom_g5	=	oAddr_ROM_15 == 9'd323;
//==============================================================================
always	@ (posedge iClk)
if (~iReset_n || oWrreq_OM)
begin
	oSel_Mux3					<=	2'b0;
	oSel_Mux20					<=	5'b0;
	oInput_ready_to_MAC			<=	20'b0;
	oFinish_to_MAC				<=	1'b0;
	oInput_ready_to_LOGSIG		<=	1'b0;
	oInput_ready_to_THRESHOLD	<=	1'b0;
	oAddr_FBR					<=	7'b0;
	oWrreq_FF_Stage9			<=	1'b0;
	oFinish_Stage				<=	1'b0;
	oRdreq_FF_Stage9			<=	1'b0;
	state						<=	3'b0;
	incr_addr_rom				<=	20'b0;
	stage						<=	4'b0;
	counter						<=	7'b0;
	counter_logsig				<=	2'b0;
	flag						<=	2'b0;
	addr_rom_0_reg				<=	10'b0;
	addr_rom_1_reg				<=	9'b0;
	addr_rom_2_reg				<=	9'b0;
	addr_rom_3_reg				<=	9'b0;
	addr_rom_4_reg				<=	9'b0;
	addr_rom_5_reg				<=	9'b0;
	addr_rom_6_reg				<=	9'b0;
	addr_rom_7_reg				<=	9'b0;
	addr_rom_8_reg				<=	9'b0;
	addr_rom_9_reg				<=	9'b0;
	addr_rom_10_reg				<=	9'b0;
	addr_rom_11_reg				<=	9'b0;
	addr_rom_12_reg				<=	9'b0;
	addr_rom_13_reg				<=	9'b0;
	addr_rom_14_reg				<=	9'b0;
	addr_rom_15_reg				<=	9'b0;
	addr_rom_16_reg				<=	9'b0;
	addr_rom_17_reg				<=	9'b0;
	addr_rom_18_reg				<=	9'b0;
	addr_rom_19_reg				<=	9'b0;
	rst_rom_g0_reg				<=	1'b0;
	rst_rom_g1_reg				<=	1'b0;
	rst_rom_g2_reg				<=	1'b0;
	rst_rom_g3_reg				<=	1'b0;
	rst_rom_g4_reg				<=	1'b0;
	rst_rom_g5_reg				<=	1'b0;
end
else
begin
	addr_rom_0_reg	<=	oAddr_ROM_0;
	addr_rom_1_reg	<=	oAddr_ROM_1;
	addr_rom_2_reg	<=	oAddr_ROM_2;
	addr_rom_3_reg	<=	oAddr_ROM_3;
	addr_rom_4_reg	<=	oAddr_ROM_4;
	addr_rom_5_reg	<=	oAddr_ROM_5;
	addr_rom_6_reg	<=	oAddr_ROM_6;
	addr_rom_7_reg	<=	oAddr_ROM_7;
	addr_rom_8_reg	<=	oAddr_ROM_8;
	addr_rom_9_reg	<=	oAddr_ROM_9;
	addr_rom_10_reg	<=	oAddr_ROM_10;
	addr_rom_11_reg	<=	oAddr_ROM_11;
	addr_rom_12_reg	<=	oAddr_ROM_12;
	addr_rom_13_reg	<=	oAddr_ROM_13;
	addr_rom_14_reg	<=	oAddr_ROM_14;
	addr_rom_15_reg	<=	oAddr_ROM_15;
	addr_rom_16_reg	<=	oAddr_ROM_16;
	addr_rom_17_reg	<=	oAddr_ROM_17;
	addr_rom_18_reg	<=	oAddr_ROM_18;
	addr_rom_19_reg	<=	oAddr_ROM_19;
	
	rst_rom_g0_reg	<=	rst_rom_g0;
	rst_rom_g1_reg	<=	rst_rom_g1;
	rst_rom_g2_reg	<=	rst_rom_g2;
	rst_rom_g3_reg	<=	rst_rom_g3;
	rst_rom_g4_reg	<=	rst_rom_g4;
	rst_rom_g5_reg	<=	rst_rom_g5;
	
	case (state)
	0:
		begin
			oFinish_Stage	<=	1'b0;
			if (iRun_ANN & (~|stage || ~oFinish_Stage))
			begin
				oSel_Mux3			<=	2'd0;
				oWrreq_FF_Stage9	<=	1'b0;
				if (stage == 4'd8)
				begin
					oInput_ready_to_MAC		<=	20'h007FE;
					incr_addr_rom			<=	20'h007FE;
				end
				else
				begin
					oInput_ready_to_MAC	<=	incr_val;
					incr_addr_rom		<=	incr_val;
				end
				state				<=	3'd1;
				if (use_ff)
					oRdreq_FF_Stage9	<=	1'b1;
			end	
		end
	1:
		begin
			oSel_Mux3				<=	2'd1;
			
			if (end_feature)
			begin
				state					<=	3'd2;
				oInput_ready_to_MAC		<=	20'b0;
				oRdreq_FF_Stage9		<=	1'b0;
				incr_addr_rom			<=	20'b0;
				counter					<=	7'b0;
				flag					<=	2'b0;
				oAddr_FBR				<=	7'b0;
			end
			else
			begin
				if (~use_ff)
					oAddr_FBR	<=	(oAddr_FBR == 7'd114) ? 7'b0 : (oAddr_FBR + 1'b1);
				counter		<=	counter	+ 1'b1;
			end
		end
	2:
		begin
			if (flag[0])
			begin
				oInput_ready_to_LOGSIG	<=	1'b1;
				if (stage != 4'd8)
					oFinish_to_MAC	<=	1'b1;
				else
					oSel_Mux20	<=	5'd1;
				state					<=	3'd3;
				flag					<=	2'b0;
			end
			else
				flag	<=	2'b1;
		end
	3:
		begin
			oFinish_to_MAC		<=	1'b0;
			oSel_Mux3			<=	2'd2;
			if (flag[0])
			begin
				if (en_use_ff)
				begin
					state	<=	3'd0;
					stage	<=	stage + 1'b1;
				end
				else
				begin
					if (stage == 4'd7)
					begin
						state		<=	3'd0;
						stage		<=	stage + 1'b1;
					end
					else
						state				<=	3'd4;
					oInput_ready_to_MAC		<=	20'h0001;
					incr_addr_rom			<=	20'h0001;
				end
				flag			<=	2'b0;
				oSel_Mux20		<=	5'b0;
				counter_logsig	<=	2'b0;
			end
			else
			begin
				if (end_output_logsig)
				begin
					oInput_ready_to_LOGSIG	<=	1'b0;
					if (&counter_logsig)
						flag	<=	2'b1;
					else
						counter_logsig	<=	counter_logsig + 1'b1;
				end
				else
					oSel_Mux20	<=	oSel_Mux20 + 1'b1;
					
				if (iOutput_ready_from_LOGSIG)
				begin
					if (en_use_ff)
						oWrreq_FF_Stage9	<=	1'b1;
					else
					begin
						oInput_ready_to_MAC	<=	20'h0001;
						incr_addr_rom		<=	20'h0001;
					end
				end
				else
				begin
					incr_addr_rom		<=	20'h0000;
					oInput_ready_to_MAC	<=	20'b0;
				end
			end
		end
	4:
		begin
			oSel_Mux3	<=	2'b0;
			state		<=	3'd5;
		end
	5:
		begin	
			incr_addr_rom			<=	20'h0000;
			oInput_ready_to_MAC		<=	20'h0000;
			if (flag[1])
			begin
				if (oInput_ready_to_LOGSIG)
				begin
					oInput_ready_to_LOGSIG		<=	1'b0;
					oFinish_to_MAC				<=	1'b1;
					flag						<=	2'b0;
					state						<=	3'd6;
				end
				else
					oInput_ready_to_LOGSIG	<=	1'b1;
			end
			else
				flag	<=	flag + 1'b1;
		end
	6:
		begin
			if (flag[0])
			begin
				if (iOutput_ready_from_THRESHOLD)
				begin
					if (~iFlag_from_THRESHOLD)
						stage		<=	stage + 1'b1;
					else
						stage		<=	4'b0;

					state			<=	4'd0;
					flag			<=	2'b0;
					oFinish_Stage	<=	1'b1;
				end
				else
					oInput_ready_to_THRESHOLD	<=	1'b0;
			end
			else
			begin
				oFinish_to_MAC				<=	1'b0;
				if (iOutput_ready_from_LOGSIG)
				begin
					oInput_ready_to_THRESHOLD	<=	1'b1;
					flag						<=	2'b1;
				end
			end
			oAddr_FBR	<=	7'b0;
		end
		
	endcase
end

endmodule

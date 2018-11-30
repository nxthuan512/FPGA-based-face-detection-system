module mv_control 	(
						//Input
						input				iClk,
						input				iReset_n,
						input				iRun_MV,
						input		[4:0]	iFF_full,
						input				iSum_finish,
						//Output
						output	reg			oRun_sum,
						output				oRst_reg,
						output	reg	[4:0]	oRdreq_FF,
						output	reg	[4:0]	oWrreq_FF,
						output	reg			oRd_OM,
						output	reg	[12:0]	oAddr_OM,
						output		[12:0]	oPosition,
						output	reg			oOutput_ready
					);

parameter	OUT_READY_VAL	=	13'd4800,
			FULL_VAL		=	7'd78;
//=======================REGISTERS============================
reg		[12:0]	counter1;
reg		[6:0]	counter2;
reg				en_counter2;
reg				state;
reg		[2:0]	no_ff_full_reg;
reg				rst_counter2;
reg				pre_sum_finish;
reg				en_wr_0;
//=========================WIRES==============================
wire			out_ready;
wire	[4:0]	wr_ff;
wire	[4:0]	rd_ff;
wire	[2:0]	no_ff_full;
wire			rd_cond;
wire			pre_ff_full;
wire			end_row;
wire	[2:0]	w1;
//============================================================
assign		out_ready	= counter1 == OUT_READY_VAL;
assign		oRst_reg	= oOutput_ready;
assign		pre_ff_full	= counter2 == FULL_VAL;
assign		w1			= no_ff_full_reg;
assign		no_ff_full	= (pre_ff_full) ? (w1 + 1'b1) : w1;
assign		rd_cond		= oAddr_OM != 13'd4799;
assign		oPosition	= counter1;

assign		rd_ff[0]	=	(no_ff_full_reg == 3'd1) ? 1'b1 : oRdreq_FF[0];				
assign		rd_ff[1]	=	(no_ff_full_reg == 3'd2) ? 1'b1 : oRdreq_FF[1];
assign		rd_ff[2]	=	(no_ff_full_reg == 3'd3) ? 1'b1 : oRdreq_FF[2];
assign		rd_ff[3]	=	(no_ff_full_reg == 3'd4) ? 1'b1 : oRdreq_FF[3];
assign		rd_ff[4]	=	(no_ff_full_reg == 3'd5) ? 1'b1 : oRdreq_FF[4];

assign		wr_ff[0]	=	1'b1;
assign		wr_ff[1]	=	(oRdreq_FF[0]) ? 1'b1 : oWrreq_FF[1];
assign		wr_ff[2]	=	(oRdreq_FF[1]) ? 1'b1 : oWrreq_FF[2];
assign		wr_ff[3]	=	(oRdreq_FF[2]) ? 1'b1 : oWrreq_FF[3];
assign		wr_ff[4]	=	(oRdreq_FF[3]) ? 1'b1 : oWrreq_FF[4];

assign		end_row		=	pre_sum_finish & ~iSum_finish;
//============================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		state			<= 1'b0;
		oAddr_OM		<= 13'b0;
		oRd_OM			<= 1'b0;
		oRun_sum		<= 1'b0;
		counter1 		<= 13'b0;
		counter2		<= 7'b0;
		en_counter2		<= 1'b0;
		no_ff_full_reg	<= 3'b0;
		rst_counter2	<= 1'b0;
		oRdreq_FF		<= 5'b0;
		oWrreq_FF		<= 5'b0;
		oOutput_ready	<= 1'b0;
		pre_sum_finish	<= 1'b0;
	end
	else
	begin
		no_ff_full_reg	<=	(oOutput_ready) ? 3'b0 : no_ff_full;
		rst_counter2	<=	pre_ff_full;
		pre_sum_finish	<=	iSum_finish;
		counter1 		<=	(iSum_finish) ? (counter1 + 1'b1) : (end_row) ? (counter1 + 3'd4) : counter1;
		en_wr_0			<=	rd_cond;
		case (state)
		0:
			begin
				oRdreq_FF		<=	5'b0;
				oWrreq_FF		<=	5'b0;
				oAddr_OM		<= 	13'b0;
				oRd_OM			<= 	1'b0;
				oOutput_ready	<=	1'b0;
				counter1		<=	13'b0;
				en_counter2		<=	1'b1;
				oRun_sum		<=	1'b0;
				if (iRun_MV)
					state <= 1'b1;
				else
					state <= 1'b0;
			end
		1:
			begin
				oRd_OM			<= 1'b1;

				oRdreq_FF[0]	<=	rd_ff[0];				
				oRdreq_FF[1]	<=	rd_ff[1];
				oRdreq_FF[2]	<=	rd_ff[2];
				oRdreq_FF[3]	<=	rd_ff[3];
				oRdreq_FF[4]	<=	rd_ff[4];
			
				oWrreq_FF[1]	<=	wr_ff[1];
				oWrreq_FF[2]	<=	wr_ff[2];
				oWrreq_FF[3]	<=	wr_ff[3];
				oWrreq_FF[4]	<=	wr_ff[4];
				
				oRun_sum		<= 	oRdreq_FF[4];
				en_counter2		<=	(rd_ff[4]) ? 1'b0 : en_counter2;
					
				if (oRd_OM)
				begin
					if (rd_cond)
					begin
						oAddr_OM	<= oAddr_OM + 1'b1;
						if (~rst_counter2)
							counter2	<= (en_counter2) ? (counter2 + 1'b1) : counter2;
						else
							counter2	<=	7'b0;
					end
					oWrreq_FF[0]	<= (en_wr_0) ? wr_ff[0] : 1'b0;
				end
					
				if (out_ready)
				begin
					oOutput_ready	<=	1'b1;
					state			<=	1'b0;
				end
				else
					state		<=	1'b1;
			end
		endcase
	end
end

endmodule

module	iib	(
				//Input
				input						iClk,
				input						iReset_n,
				input						iRun,
				input						iRst,
				input						iWrreq_SM,
				input			[12:0]		iAddr_SM,
				input						iData_to_SM,
				input						iWrreq_IIB,
				input			[12:0]		iAddr_IIB,
				input			[20:0]		iData_to_IIB,
				//Output
				output						oFull_SM,
				output						oFull_IIB,
				output	reg		[12:0]		oAddr_OM,
				output	reg					oWrreq_to_IIBG_23x23,
				output	reg					oWrreq_to_IIBG_19x19,
				output	reg					oWrreq_to_IIBG_17x17,
				output			[20:0]		oData_to_IIBG,
				output	reg		[1:0]		oFinish,
				output						oEnd,
				output						oEnd_n
			);

parameter	END_IIB_VAL		=	13'd4799;
//=================================REGISTERS=============================
reg		[12:0]		addr_sm_reg;
reg		[12:0]		addr_iib_reg;
reg		[1:0]		state;
reg		[12:0]		begin_addr_23_reg;
reg		[12:0]		begin_addr_19_reg;
reg		[12:0]		begin_addr_17_reg;
reg		[12:0]		begin_addr_reg;
reg		[2:0]		en_incr_addr_reg;
reg		[1:0]		delay;
reg		[1:0]		end_iib_reg;
reg		[6:0]		col_reg;
reg		[5:0]		row_reg;
reg		[1:0]		en_reg;
reg					end_reg;
//===================================WIRES===============================
wire	[12:0]		addr_sm;
wire	[12:0]		addr_iib;
wire	[12:0]		end_addr_23;
wire	[12:0]		end_addr_19;
wire	[12:0]		end_addr_17;
wire	[12:0]		end_23;
wire	[12:0]		end_19;
wire	[12:0]		end_17;
wire				end_tl;
wire				q_sm;
wire				wr_23;
wire				wr_19;
wire				wr_17;
wire	[2:0]		flag;
wire	[2:0]		en_incr_addr;
wire				en_wr_23;
wire				en_wr_19;
wire				en_wr_17;
wire				dis_wr_23;
wire				dis_wr_19;
wire				dis_wr_17;
wire				en_state_2;
wire				end_iib;
wire				end_state_2;
wire				end_row;
wire				en_23;
wire				en_19;
wire	[12:0]		pre_addr_iib;
wire	[12:0]		pre_addr_23;
wire	[12:0]		pre_addr_19;
wire	[1:0]		finish;
wire	[12:0]		incr_addr_begin_23;
wire	[12:0]		incr_addr_begin_19;
wire	[12:0]		incr_addr_begin_17;
wire	[12:0]		incr_addr_iib;
wire				rst_iib;
//=======================================================================
assign	addr_sm		=	(iWrreq_SM) ? iAddr_SM : addr_sm_reg;
assign	addr_iib	=	(iWrreq_IIB) ? iAddr_IIB : addr_iib_reg;
assign	oFull_SM	=	iAddr_SM	==	END_IIB_VAL;
assign	oFull_IIB	=	iAddr_IIB	==	END_IIB_VAL;

assign	end_addr_23		=	begin_addr_23_reg + 5'd24;
assign	end_addr_19		=	begin_addr_19_reg + 5'd20;
assign	end_addr_17		=	begin_addr_17_reg + 5'd18;
assign	end_23			=	begin_addr_reg + 11'd1620;
assign	end_19			=	begin_addr_reg + 11'd1458;
assign	end_17			=	begin_addr_reg + 11'd1377;

assign	end_tl			=	col_reg == 7'd72;

assign	flag[0]	=	addr_iib_reg == end_addr_23;
assign	flag[1]	=	addr_iib_reg == end_addr_19;
assign	flag[2]	=	addr_iib_reg == end_addr_17;

assign	wr_23	= 	(en_wr_23 & en_reg[0]) ? 1'b1 : (flag[0]) ? 1'b0 : oWrreq_to_IIBG_23x23;
assign	wr_19	=	(en_wr_19 & en_reg[1]) ? 1'b1 : (flag[1]) ? 1'b0 : oWrreq_to_IIBG_19x19;
assign	wr_17	=	(en_wr_17) ? 1'b1 : (flag[2] || end_iib_reg[1]) ? 1'b0 : oWrreq_to_IIBG_17x17;

assign	oEnd_n	=	addr_sm_reg == 13'd4169;
assign	end_iib	=	(addr_iib_reg == END_IIB_VAL) & wr_17;
assign	oEnd	=	end_iib_reg[1] & (|oFinish);

assign	en_wr_17	=	addr_iib_reg == begin_addr_17_reg;
assign	en_wr_19	=	addr_iib_reg == begin_addr_19_reg;
assign	en_wr_23	=	addr_iib_reg == begin_addr_23_reg;
assign	dis_wr_17	=	addr_iib_reg == end_17;
assign	dis_wr_19	=	addr_iib_reg == end_19;
assign	dis_wr_23	=	addr_iib_reg == end_23;

assign	en_incr_addr[0]	=	(en_wr_23) ? 1'b1 : (dis_wr_23) ? 1'b0 : en_incr_addr_reg[0];
assign	en_incr_addr[1]	=	(en_wr_19) ? 1'b1 : (dis_wr_19) ? 1'b0 : en_incr_addr_reg[1];
assign	en_incr_addr[2]	=	(en_wr_17) ? 1'b1 : (dis_wr_17) ? 1'b0 : en_incr_addr_reg[2];

assign	en_state_2	=	(q_sm & ~end_tl) & ~delay[1];

assign	en_23		=	(col_reg > 7'd11) & (row_reg > 6'd11) & (col_reg < 7'd69) & (row_reg < 6'd49);
assign	en_19		=	(col_reg > 7'd9) & (row_reg > 6'd9) & (col_reg < 7'd71) & (row_reg < 6'd51);
assign	end_state_2	=	(en_reg[0]) ? dis_wr_23 : (en_reg[1]) ? dis_wr_19 : dis_wr_17;
assign	end_row		=	(en_reg[0]) ? flag[0] : (en_reg[1]) ? flag[1] : flag[2];

assign	pre_addr_23	=	begin_addr_reg + 13'd7949;
assign	pre_addr_19	=	begin_addr_reg + 13'd8111;

assign	pre_addr_iib	=	(en_reg[0]) ? pre_addr_23 : (en_reg[1]) ? pre_addr_19 : begin_addr_reg;

assign	finish	=	(en_reg[0]) ? 2'd3 : (en_reg[1]) ? 2'd2 : 2'd1;

assign	incr_addr_begin_23	=	begin_addr_23_reg + 7'd80;
assign	incr_addr_begin_19	=	begin_addr_19_reg + 7'd80;
assign	incr_addr_begin_17	=	begin_addr_17_reg + 7'd80;
assign	incr_addr_iib		=	(en_incr_addr[0]) ? incr_addr_begin_23 : (en_incr_addr[1]) ? incr_addr_begin_19 : incr_addr_begin_17;

assign	rst_iib	=	(iRst & end_reg) || oEnd_n;
//=======================================================================
always @ (posedge iClk)
if (~iReset_n || rst_iib)
begin
	oWrreq_to_IIBG_23x23	<=	1'b0;
	oWrreq_to_IIBG_19x19	<=	1'b0;
	oWrreq_to_IIBG_17x17	<=	1'b0;
	oFinish					<=	2'b0;
	oAddr_OM				<=	13'b0;
	addr_sm_reg				<=	13'b0;
	addr_iib_reg			<=	13'b0;
	state					<=	2'b0;
	begin_addr_23_reg		<=	13'b0;
	begin_addr_19_reg		<=	13'b0;
	begin_addr_17_reg		<=	13'b0;
	begin_addr_reg			<=	13'b0;
	en_incr_addr_reg		<=	3'b0;
	delay					<=	2'b0;
	end_iib_reg				<=	2'b0;
	col_reg					<=	7'b0;
	row_reg					<=	6'b0;
	en_reg					<=	2'b0;
	end_reg					<=	1'b0;
end
else
begin
	end_iib_reg[0]	<=	end_iib;
	end_iib_reg[1]	<=	end_iib_reg[0];
	end_reg			<=	(oEnd) ? 1'b1 : end_reg;
	case(state)
	0:
		begin
			if (iRun & ~|oFinish)
			begin
				state		<=	2'd1;
				en_reg[0]	<=	en_23;
				en_reg[1]	<=	en_19;
			end
			
			if (~|addr_iib_reg)
			begin
				addr_sm_reg	<=	13'd729;
				col_reg		<=	7'd9;
				row_reg		<=	6'd9;
			end
			oFinish			<=	2'b0;
		end
	1:
		begin
			if (en_state_2)
			begin
				state				<=	2'd2;
				begin_addr_17_reg	<= 	begin_addr_reg;
				begin_addr_19_reg	<=	pre_addr_19;
				begin_addr_23_reg	<=	pre_addr_23;
				addr_iib_reg		<=	pre_addr_iib;
				delay				<=	2'b0;
			end
			else
			begin
				delay[0]	<=	~delay[0];
				en_reg[0]	<=	en_23;
				en_reg[1]	<=	en_19;
				if (delay[1])
					delay[1]	<=	1'b0;
			end
			
			if (~delay[0])
			begin
				if (end_tl)
				begin
					begin_addr_reg		<=	begin_addr_reg + 5'd17;
					addr_sm_reg			<=	addr_sm_reg + 5'd17;
					delay[1]			<=	1'b1;
					col_reg				<=	7'd9;
					row_reg				<=	row_reg + 1'b1;
				end
				else
				begin
					begin_addr_reg	<= 	begin_addr_reg + 1'b1;
					addr_sm_reg		<=	(oEnd_n) ? addr_sm_reg : (addr_sm_reg + 1'b1);
					col_reg			<=	col_reg + 1'b1;
					oAddr_OM		<=	addr_sm_reg;
				end
			end
		end
	2:
		begin
			en_incr_addr_reg		<=	en_incr_addr;
			oWrreq_to_IIBG_23x23	<=	wr_23;
			oWrreq_to_IIBG_19x19	<=	wr_19;
			oWrreq_to_IIBG_17x17	<=	wr_17;
			
			if (end_state_2 || end_iib_reg[0])
			begin
				state	<=	2'd0;
				oFinish	<=	finish;
			end
			else
				if (end_row)
				begin
					begin_addr_23_reg	<=	(en_incr_addr[0]) ? incr_addr_begin_23 : begin_addr_23_reg;
					begin_addr_19_reg	<=	(en_incr_addr[1]) ? incr_addr_begin_19 : begin_addr_19_reg;
					begin_addr_17_reg	<=	(en_incr_addr[2]) ? incr_addr_begin_17 : begin_addr_17_reg;
					addr_iib_reg		<=	incr_addr_iib;
				end
				else
					addr_iib_reg	<=	(end_iib) ? addr_iib_reg : (addr_iib_reg + 1'b1);
		end
	endcase
end
//=======================================================================
spram_sm	SEARCH_MAP	(
							.address		(addr_sm),
							.clock			(iClk),
							.data			(iData_to_SM),
							.wren			(iWrreq_SM),
							.q				(q_sm)
						);

spram_iib	IIBRAM		(
							.address		(addr_iib),
							.clock			(iClk),
							.data			(iData_to_IIB),
							.wren			(iWrreq_IIB),
							.q				(oData_to_IIBG)
						);

endmodule

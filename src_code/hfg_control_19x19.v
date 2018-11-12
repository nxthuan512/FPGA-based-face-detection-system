module hfg_control_19x19  	(
								//Input
								input						iClk,
								input						iReset_n,
								input						iReady,
								input						iRun,
								//Output
								output  reg		[7:0]		oSign,
								output	reg					oWait,
								output	reg					oFull,
								output			[8:0]		oAddr_IIBG,
								output	reg					oRdreq_IIBG,
								output	reg					oFinish,
								output	reg		[6:0]		oAddr_FBR,
								output	reg					oFull_FBR
							);

//========================REGISTERS====================================
reg		[6:0]		addr_no_feature;
reg		[11:0]		addr_feature;
reg		[2:0]		state;
reg		[11:0]		no_pre_begin;
reg		[11:0]		no_begin;
reg		[11:0]		no_end;
reg		[3:0]		pos;
reg					en_count;
reg		[1:0]		counter;
reg					en_cont;
reg		[2:0]		cont_counter;
reg					delay;
//=========================WIRES=======================================
wire	[6:0]		mem_no_rec;
wire	[8:0]		mem_rec;
wire				pre_bof;
wire				bof;
wire				eof;
wire				waitreq;
wire				finish;
wire				cont;
wire				full_fbr;
wire				end_no_f_mem;
wire				end_f_mem;
wire	[11:0]		pre_no_end;
wire				flag;
//=====================================================================
assign	pre_bof		= addr_feature == no_pre_begin;
assign	bof			= addr_feature == no_begin;
assign	eof			= addr_feature == no_end;
assign	waitreq     = pos == 4'd8;
assign	finish		= counter == 2'd3;
assign	oAddr_IIBG	= mem_rec;
assign	cont		= cont_counter == 3'd4;
assign	full_fbr	= (oAddr_FBR == 7'd114) & oFinish;

assign	end_no_f_mem	= addr_no_feature == 7'd114;
assign	end_f_mem		= addr_feature == 12'd3884;
assign	pre_no_end		= (no_end == 12'd3865) ? 12'd3884 : (no_end + mem_no_rec);
assign	flag			= addr_feature == 12'd3884;
//=====================================================================
always @ (posedge iClk)
begin
	if (~iReset_n || ~iRun)
	begin
		addr_no_feature	<= 7'b0;
		addr_feature	<= 12'b0;
		state			<= 3'b0;
		no_pre_begin	<= 12'b0;
		no_begin		<= 12'b0;
		no_end			<= 12'b0;
		pos				<= 4'b0;
		delay			<= 1'b0;
		en_count		<= 1'b0;
		counter			<= 2'b0;
		en_cont			<= 1'b0;
		cont_counter	<= 3'b0;
		oSign			<= 8'b0;
		oWait			<= 1'b0;
		oFull			<= 1'b0;
		oRdreq_IIBG		<= 1'b0;
		oFinish			<= 1'b0;
		oAddr_FBR		<= 7'b0;
		oFull_FBR		<= 1'b0;
	end
	else
	begin
		en_count  	<= (iReady & eof) ? 1'b1 : (finish) ? 1'b0 : en_count;
		oFinish		<=	finish;
		if (oFinish)
			oAddr_FBR	<=	oAddr_FBR + 1'b1;
		
		if (full_fbr)
		begin
			oFull_FBR	<=	1'b1;
			oAddr_FBR	<=	7'b0;
		end
		else
			oFull_FBR	<=	1'b0;
		
		if (en_count)
			counter  	<= counter + 1'b1;
		else
			counter		<= 2'b0;
		
		if (en_cont)
			cont_counter 	<= cont_counter + 1'b1;
		else
			cont_counter	<= 3'b0;
			
		case (state)
		0:
			if (iRun)
				state	<=	3'd2;
		1:
			if (iReady)
			begin
				oSign	<=	8'b0;
				if (oWait & ~eof)
					state	<=	3'd4;
				else
					state	<=	3'd2;
			end
			else
			begin
				oFull		<=	1'b0;
				state		<=	3'd1;
				en_cont	 	<=	1'b0;
			end
		2:
			begin
				addr_no_feature	<=	(end_no_f_mem) ? 7'b0 : (addr_no_feature + 1'b1);
				no_end			<=	pre_no_end;
				oWait			<=	1'b0;
				pos				<=	4'b0;
				state			<=	3'd4;
			end
		3:
			begin
				oSign[0]	<=	(pos == 0) ? mem_rec[0] : oSign[0];
				oSign[1]	<=	(pos == 1) ? mem_rec[0] : oSign[1];
				oSign[2]	<=	(pos == 2) ? mem_rec[0] : oSign[2];
				oSign[3]	<=	(pos == 3) ? mem_rec[0] : oSign[3];
				oSign[4]	<=	(pos == 4) ? mem_rec[0] : oSign[4];
				oSign[5]	<=	(pos == 5) ? mem_rec[0] : oSign[5];
				oSign[6]	<=	(pos == 6) ? mem_rec[0] : oSign[6];
				oSign[7]	<=	(pos == 7) ? mem_rec[0] : oSign[7];
				pos			<=	pos + 1'b1;
				no_begin	<=	no_begin + 3'd5;
				no_pre_begin<=	(no_begin == 12'b0) ? 12'd4 : no_pre_begin + 3'd5;
				oFull		<=	1'b0;
				state		<=	3'd4;
			end
		4:
			begin
				if (eof || cont)
				begin
					oRdreq_IIBG		<=	1'b0;
					if (flag & ~delay)
						delay	<=	1'b1;
					else
					begin
						oFull	<=	1'b1;
						state	<=	3'd1;
						delay	<=	1'b0;
					end
				end
				else if (bof)
				begin
					oRdreq_IIBG	<=	1'b0;
					state		<=	3'd3;
				end
				else
				begin
					if (waitreq)
					begin
						oWait	<=	1'b1;
						en_cont	<=	1'b1;
						pos		<=	4'b0;
					end
					if (pre_bof)
						oRdreq_IIBG		<=	1'b0;
					else
						oRdreq_IIBG		<=	1'b1;
					addr_feature	<=	(end_f_mem) ? 12'b0 : (addr_feature + 1'b1);
				end
			end
		endcase
	end
end

//===============================================================================

hfg_feature_mem_19x19	FEATURE (
									//Input
									.clock						(iClk),
									.address					(addr_feature),
									//Output
									.q							(mem_rec)
								);

hfg_no_feature_mem	NOFEATURE 	(
									//Input
									.clock						(iClk),
									.address					(addr_no_feature),
									//Output
									.q							(mem_no_rec)
								);

endmodule

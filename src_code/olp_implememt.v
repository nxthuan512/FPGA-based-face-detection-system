module	olp_implement	(
							//Input
							input				iClk,
							input				iReset_n,
							input				iRun,
							input				iSet,
							input		[12:0]	iPosition,
							input		[1:0]	iSize,
							//Output
							output	reg	[1:0]	oPass,
							output	reg			oFinish,
							output	reg	[1:0]	oSize,		
							output	reg	[20:0]	oFace_Pos
						);
//====================================WIRES=======================================
wire	[12:0]	addr_ram;
wire			oq_ram;
wire			idata_ram;
wire	[12:0]	pre_addr;
wire			cond;
wire	[12:0]	zero_begin;
wire			zero_cond1;
wire			zero_cond2;
wire	[23:0]	pre_pos;
wire	[23:0]	pre_face_pos;
wire	[20:0]	face_pos;
wire	[12:0]	face_center;
wire	[20:0]	top_left_face;
wire			end_set;
wire	[12:0]	x1;
//==================================REGISTERS=====================================
reg		[2:0]	state;
reg		[12:0]	position;
reg		[12:0]	addr_reg;
reg				idata_reg;
reg		[12:0]	y1;
reg		[12:0]	y2;
reg		[1:0]	pass;
reg				wr_ram;
reg		[12:0]	zero_begin_reg;
//================================PRE-CACL========================================
wire	[21:0]	p_shl_9	=	{face_center,9'b0};
wire	[20:0]	p_shl_8	=	{face_center,8'b0};
wire	[17:0]	p_shl_5	=	{face_center,5'b0};
wire	[16:0]	p_shl_4	=	{face_center,4'b0};
wire	[13:0]	p_shl_1 =	{face_center,1'b0};

wire	[21:0]	pp_shl_10	=	{pre_pos[23:16],14'b0};
wire	[18:0]	pp_shl_7	=	{pre_pos[23:16],11'b0};
wire	[16:0]	pp_shl_5	=	{pre_pos[23:16],9'b0};
wire	[15:0]	pp_shl_4	=	{pre_pos[23:16],8'b0};
//================================================================================
assign	addr_ram	=	addr_reg;
assign	idata_ram	=	idata_reg;
assign	x1			=	iPosition + 13'd7706;
assign	pre_addr	=	(pass == 2'd0) ? y1 : (pass == 2'd1) ? y2 : 13'b0;
assign	cond		=	pass == 2'd3;
assign	zero_begin	=	(iSize == 2'd0) ? (position + 13'h1D27) : (iSize == 2'd1) ? (position + 13'h1DC9) : (iSize == 2'd2) ? (position + 13'h1E1A) : 13'b0;

assign	face_center		=	position + 13'd162;
assign	top_left_face	=	(iSize == 2'd0) ? 21'd1861448 : (iSize == 2'd1) ? 21'd1902440 : (iSize == 2'd2) ? 21'd1943432 : 13'b0;

assign	zero_cond1	=	(iSize == 2'd0) ? (addr_ram == (zero_begin_reg + 5'd22)) : (iSize == 2'd1) ? (addr_ram == (zero_begin_reg + 5'd18)) : (iSize == 2'd2) ? (addr_ram == (zero_begin_reg + 5'd16)) : 1'b0;

assign	zero_cond2	=	(iSize == 2'd0) ? (addr_ram == (zero_begin + 11'd1782)) : (iSize == 2'd1) ? (addr_ram == (zero_begin + 11'd1458)) : (iSize == 2'd2) ? (addr_ram == (zero_begin + 11'd1296)) : 1'b0;

assign	pre_pos			=	(p_shl_9 + p_shl_8) + ((p_shl_5 + p_shl_4) + (p_shl_1 + face_center));
assign	pre_face_pos	=	(pp_shl_10 + pp_shl_7) + (pp_shl_5 + pp_shl_4);
assign	face_pos		=	({face_center,4'b0} + pre_face_pos[20:0]) + top_left_face;

assign	end_set	=	addr_reg == 13'd4799;
//================================================================================
always @ (posedge iClk)
if (~iReset_n || end_set)
begin
	state			<=	3'b0;
	position		<=	13'b0;
	addr_reg		<=	13'b0;
	idata_reg		<=	1'b0;
	y1				<=	13'b0;
	y2				<=	13'b0;
	pass			<=	2'b0;
	wr_ram			<=	1'b0;
	zero_begin_reg	<=	13'b0;
	oPass			<=	2'b0;
	oFace_Pos		<=	21'b0;
	oFinish			<=	1'b0;
	oSize			<=	2'b0;
end
else
begin
	case (state)
	0:
		begin
			oFinish	<=	1'b0;
			if (iRun)
			begin
				state			<=	3'd1;
				position		<=	iPosition;
				addr_reg		<=	x1;
			end
			else
				state	<=	3'd0;
			
			if (iSet)
			begin
				addr_reg	<=	13'b0;
				idata_reg	<=	1'b0;
				wr_ram		<=	1'b1;
				state		<=	3'd4;
			end
		end
	1:
		begin
			zero_begin_reg	<=	zero_begin;
			addr_reg		<=	addr_reg + 5'd16;
			y1				<=	position + 10'd794;
			y2				<=	position + 10'd810;
			state			<=	3'd2;
		end
	2:
		begin	
			if (~oq_ram)
			begin
				pass	<=	pass + 1'b1;
				if (~cond)
					addr_reg	<=	pre_addr;
				else
				begin
					oPass		<=	2'b11;
					oSize		<=	iSize;
					oFace_Pos	<=	face_pos;
				end
			end
			else
				oPass			<=	2'b10;
			
			if (oq_ram || cond)
			begin
				addr_reg		<=	zero_begin;
				idata_reg		<=	1'b1;
				wr_ram			<=	1'b1;
				state			<=	3'd3;
			end
		end
	3:
		begin
			oPass		<=	2'b0;
			if (~zero_cond2)
				if (~zero_cond1)
					addr_reg	<=	addr_reg + 1'b1;
				else
				begin
					addr_reg		<=	zero_begin_reg + 7'd80;
					zero_begin_reg	<=	zero_begin_reg + 7'd80;
				end
			else
			begin
				state		<=	3'b0;
				oFinish		<=	1'b1;
				idata_reg	<=	1'b0;
				wr_ram		<=	1'b0;
			end
		end
	4:
		addr_reg	<=	addr_reg + 1'b1;
	endcase

end

spram	OLP_RAM	(
					.address			(addr_ram),
					.clock				(iClk),
					.data				(idata_ram),
					.wren				(wr_ram),
					.q					(oq_ram)
				);

endmodule

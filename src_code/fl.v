module	fl	(
				//Input
				input					iClk,
				input					iReset_n,
				input					iInput_ready,
				input					iWrite_wait_request,
				input		[1:0]		iSize,
				input		[20:0]		iFace_Pos,
				//Output
				output	reg	[31:0]		oAddr_OI,
				output	reg				oWrreq_OI,
				output	reg	[31:0]		oData_to_OI,
				output					oFinish_Draw
			);

//=================================REGISTERS==============================
reg		[31:0]	begin_pos;
reg		[1:0]	state;
reg				flag;
reg				en_rd;
reg				rdreq_ff_reg;
reg		[8:0]	counter;
reg		[7:0]	size_w_reg;
reg		[8:0]	size_h_reg;
reg				finish;
//===================================WIRES================================
wire	[7:0]	size_w;
wire	[8:0]	size_h;
wire	[31:0]	face_pos;
wire			stop_w;
wire			stop_h;
wire			empty_pos;
wire			empty_size;
wire	[31:0]	q_face_pos;
wire	[1:0]	q_face_size;
wire			rdreq_ff;
//========================================================================
assign	size_w	=	(q_face_size == 2'd0) ? 8'd183 : (q_face_size == 2'd1) ? 8'd151 : (q_face_size == 2'd2) ? 8'd119 : 8'b0;
assign	size_h	=	(q_face_size == 2'd0) ? 9'd367 : (q_face_size == 2'd1) ? 9'd303 : (q_face_size == 2'd2) ? 9'd239 : 9'b0;

assign	stop_w 	= 	counter == size_w_reg;
assign	stop_h 	= 	counter == size_h_reg;

assign	face_pos	=	{10'b0,iFace_Pos[20:0],1'b0};

assign	rdreq_ff	=	~empty_pos & ~empty_size & en_rd;

assign	oFinish_Draw	=	empty_pos & empty_size & finish;
//========================================================================
always	@ (posedge iClk)
if (~iReset_n || oFinish_Draw)
begin
	begin_pos		<=	32'b0;
	state			<=	2'b0;
	flag			<=	1'b0;
	en_rd			<=	1'b1;
	finish			<=	1'b0;
	rdreq_ff_reg	<=	1'b0;
	counter			<=	9'b0;
	size_h_reg		<=	9'b0;
	size_w_reg		<=	8'b0;
	oAddr_OI		<=	32'b0;
	oWrreq_OI		<=	1'b0;
	oData_to_OI		<=	32'b0;
end
else
begin
	rdreq_ff_reg	<=	rdreq_ff;
	en_rd			<=	(rdreq_ff) ? 1'b0 : (finish) ? 1'b1 : en_rd;
		
	case (state)
	0:
		if (rdreq_ff_reg)
		begin
			begin_pos	<=	q_face_pos;
			oAddr_OI	<=	q_face_pos;
			size_w_reg	<=	size_w;
			size_h_reg	<=	size_h;
			flag		<=	1'b0;
			counter		<=	9'b0;
			oWrreq_OI	<=	1'b1;
			oData_to_OI	<=	32'hF800F800;
			state		<=	2'd1;
		end
		else
		begin
			finish		<=	1'b0;
			oWrreq_OI	<=	1'b0;
		end
	1:
		if (~iWrite_wait_request)
		begin
			if (~stop_w)
			begin
				oAddr_OI	<=	oAddr_OI + 3'd4;
				counter		<=	counter + 1'b1;
			end
			else
			begin
				if (flag)
				begin
					state		<=	2'd0;
					finish		<=	1'b1;
				end
				else
				begin
					counter	<=	9'b0;
					state	<=	2'd2;
				end
			end
		end
	2:
		if (~iWrite_wait_request)
		begin
			if (~stop_h)
			begin
				oAddr_OI	<=	oAddr_OI + 12'd2560;
				counter		<=	counter + 1'b1;
			end
			else
			begin
				if (flag)
				begin
					counter		<=	9'b0;
					state		<=	2'd1;
				end
				else
				begin
					flag		<=	1'b1;
					oAddr_OI	<=	begin_pos;
					counter		<=	9'b0;
				end
			end
		end

	endcase
end

scfifo_face_pos FACE_POS_0 	(
								.clock		(iClk),
								.data		(face_pos),
								.rdreq		(rdreq_ff),
								.wrreq		(iInput_ready),
								.empty		(empty_pos),
								.full		(),
								.q			(q_face_pos)
							);

scfifo_face_size FACE_SIZE_0(
								.clock		(iClk),
								.data		(iSize),
								.rdreq		(rdreq_ff),
								.wrreq		(iInput_ready),
								.empty		(empty_size),
								.full		(),
								.q			(q_face_size)
							);

endmodule

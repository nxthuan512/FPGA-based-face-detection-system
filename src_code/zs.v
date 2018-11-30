module	zs	(
				//Input
				input				iClk,
				input				iReset_n,
				input				iInput_ready_23x23,
				input		[12:0]	iPosition_23x23,
				input				iInput_ready_19x19,
				input		[12:0]	iPosition_19x19,
				input				iInput_ready_17x17,
				input		[12:0]	iPosition_17x17,
				//Output
				output	reg	[12:0]	oAddr_OM_23x23,
				output	reg	[31:0]	oZero_OM_23x23,
				output	reg			oWrreq_OM_23x23,
				output	reg	[12:0]	oAddr_OM_19x19,
				output	reg	[31:0]	oZero_OM_19x19,
				output	reg			oWrreq_OM_19x19,
				output	reg	[12:0]	oAddr_OM_17x17,
				output	reg	[31:0]	oZero_OM_17x17,
				output	reg			oWrreq_OM_17x17,
				output	reg			oFinish
			);

//============================REGISTERS================================
reg		[12:0]		position_23x23;
reg		[12:0]		position_19x19;
reg		[12:0]		position_17x17;
reg		[2:0]		en_zero;
reg		[12:0]		begin_pos_23x23_reg;
reg		[12:0]		begin_pos_19x19_reg;
reg		[12:0]		begin_pos_17x17_reg;
reg		[1:0]		state;
//==============================WIRES==================================
wire				cond1_23x23;
wire				cond2_23x23;
wire				cond1_19x19;
wire				cond2_19x19;
wire				cond1_17x17;
wire				cond2_17x17;
//=====================================================================
assign	cond1_23x23		=	oAddr_OM_23x23 == (begin_pos_23x23_reg  + 5'd22);
assign	cond2_23x23		=	oAddr_OM_23x23 == (position_23x23 + 11'd1782);
assign	cond1_19x19		=	oAddr_OM_19x19 == (begin_pos_19x19_reg  + 5'd18);
assign	cond2_19x19		=	oAddr_OM_19x19 == (position_19x19 + 11'd1458);
assign	cond1_17x17		=	oAddr_OM_17x17 == (begin_pos_17x17_reg  + 5'd16);
assign	cond2_17x17		=	oAddr_OM_17x17 == (position_17x17 + 11'd1296);
//=====================================================================
always @ (posedge iClk)
if (~iReset_n)
begin
	oAddr_OM_23x23			<=	13'b0;
	oZero_OM_23x23			<=	32'b0;
	oWrreq_OM_23x23			<=	1'b0;
	oAddr_OM_19x19			<=	13'b0;
	oZero_OM_19x19			<=	32'b0;
	oWrreq_OM_19x19			<=	1'b0;
	oAddr_OM_17x17			<=	13'b0;
	oZero_OM_17x17			<=	32'b0;
	oWrreq_OM_17x17			<=	1'b0;
	oFinish					<=	1'b0;
	position_23x23			<=	13'b0;
	position_19x19			<=	13'b0;
	position_17x17			<=	13'b0;
	en_zero					<=	3'b0;
	begin_pos_23x23_reg		<=	13'b0;
	begin_pos_19x19_reg		<=	13'b0;
	begin_pos_17x17_reg		<=	13'b0;
	state					<=	2'b0;
end
else
begin
	case (state)
	0:
		begin
			if (iInput_ready_23x23)
			begin
				position_23x23	<=	iPosition_23x23 + 13'h1D27;
				en_zero[0]		<=	1'b1;
				state			<=	2'd1;
			end
			if (iInput_ready_19x19)
			begin
				position_19x19	<=	iPosition_19x19 + 13'h1DC9;
				en_zero[1]		<=	1'b1;
				state			<=	2'd1;
			end
			if (iInput_ready_17x17)
			begin
				position_17x17	<=	iPosition_17x17 + 13'h1E1A;
				en_zero[2]		<=	1'b1;
				state			<=	2'd1;
			end
			oFinish				<=	1'b0;
			oWrreq_OM_23x23		<=	1'b0;
			oWrreq_OM_19x19		<=	1'b0;
			oWrreq_OM_17x17		<=	1'b0;
		end
	1:
		begin
			if (en_zero[0])
			begin
				begin_pos_23x23_reg	<=	position_23x23;
				oAddr_OM_23x23		<=	position_23x23;
				oZero_OM_23x23		<=	32'b0;
				oWrreq_OM_23x23		<=	1'b1;
			end
			if (en_zero[1])
			begin
				begin_pos_19x19_reg	<=	position_19x19;
				oAddr_OM_19x19		<=	position_19x19;
				oZero_OM_19x19		<=	32'b0;
				oWrreq_OM_19x19		<=	1'b1;
			end
			if (en_zero[2])
			begin
				begin_pos_17x17_reg	<=	position_17x17;
				oAddr_OM_17x17		<=	position_17x17;
				oZero_OM_17x17		<=	32'b0;
				oWrreq_OM_17x17		<=	1'b1;
			end
			state	<=	2'd2;
		end
	2:
		begin
			if (en_zero[0] & ~cond2_23x23)
			begin
				if (cond1_23x23)
				begin
					oAddr_OM_23x23		<=	begin_pos_23x23_reg + 7'd80;
					begin_pos_23x23_reg	<=	begin_pos_23x23_reg + 7'd80;
				end
				else
					oAddr_OM_23x23	<=	oAddr_OM_23x23 + 1'b1;
			end
			else
			begin
				en_zero[0]		<=	1'b0;
				oWrreq_OM_23x23	<=	1'b0;
			end
				
			if (en_zero[1] & ~cond2_19x19)
			begin
				if (cond1_19x19)
				begin
					oAddr_OM_19x19		<=	begin_pos_19x19_reg + 7'd80;
					begin_pos_19x19_reg	<=	begin_pos_19x19_reg + 7'd80;
				end
				else
					oAddr_OM_19x19	<=	oAddr_OM_19x19 + 1'b1;
			end
			else
			begin
				en_zero[1]		<=	1'b0;
				oWrreq_OM_19x19	<=	1'b0;
			end
				
			if (en_zero[2] & ~cond2_17x17)
			begin
				if (cond1_17x17)
				begin
					oAddr_OM_17x17		<=	begin_pos_17x17_reg + 7'd80;
					begin_pos_17x17_reg	<=	begin_pos_17x17_reg + 7'd80;
				end
				else
					oAddr_OM_17x17	<=	oAddr_OM_17x17 + 1'b1;
			end
			else
			begin
				en_zero[2]		<=	1'b0;
				oWrreq_OM_17x17	<=	1'b0;
			end
			
			if (en_zero == 3'b0)
			begin
				oFinish		<=	1'b1;
				state		<=	2'b0;
			end
		end
	endcase
end
endmodule

module threshold_23x23 	(
							//Input
							input				iClk,
							input				iReset_n,
							input				iInput_ready,
							input		[12:0]	iPosition,
							input		[31:0]	iMax_val,
							input				iFinish,
							input		[31:0]	iData_from_OM,
							//Output
							output	reg	[12:0]	oAddr_OM,
							output	reg	[12:0]	oPosition,
							output	reg			oOutput_ready,
							output	reg			oEnd
						);

//=========================REGISTERS================================
reg		[1:0]	state;
reg		[12:0]	position;
//===========================WIRES==================================
wire			threshold;
wire	[12:0]	face_center;
wire			cond;
//==================================================================
assign	threshold	=	iMax_val > 32'h4199999;				
assign	face_center	=	iPosition + 13'd162;	
assign	cond		=	iData_from_OM	>	32'h11EB85;	
//==================================================================					
always @ (posedge iClk)
if (~iReset_n || iFinish)
begin
	state			<=	2'b0;
	position		<=	13'b0;
	oAddr_OM		<=	13'b0;
	oPosition		<=	13'b0;
	oOutput_ready	<=	1'b0;
	oEnd			<=	1'b0;
end
else
begin
	case (state)
	0:
		if (iInput_ready)
		begin
			if (threshold)
			begin
				state		<=	2'd1;
				oAddr_OM	<=	face_center;
				position	<=	iPosition;
				oEnd		<=	1'b0;
			end
			else
			begin
				oPosition		<=	13'b0;
				oOutput_ready	<=	1'b0;
				oEnd			<=	1'b1;
			end
		end
		else
			oOutput_ready	<=	1'b0;
	1:
		begin
			oAddr_OM	<=	oAddr_OM + 1'b1;
			state		<=	2'd2;
		end
	2:
		if (cond)
		begin
			oPosition		<=	position;
			oOutput_ready	<=	1'b1;
			state			<=	3'd0;
		end
		else
			state		<=	2'd3;
	3:
		begin
			if (cond)
				oPosition	<=	position + 1'b1;
			else
				oPosition	<=	position + 13'd81;
			oOutput_ready	<=	1'b1;
			state			<=	2'd0;
		end
	
	endcase
end
					
endmodule

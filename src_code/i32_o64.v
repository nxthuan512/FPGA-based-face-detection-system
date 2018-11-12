module	i32_o64	(
					//Input
					input						iClk,
					input						iReset_n,
					input						iInput_ready,
					input			[31:0]		iData_in,
					//Output
					output	reg					oOutput_ready,
					output			[63:0]		oData_out
				);
				
//===============================REGISTERS===============================
reg		[63:0]		data_out;
reg					state;
//=======================================================================
assign	oData_out	= 	data_out;
//=======================================================================
always	@	(posedge iClk)
if (~iReset_n)
begin
	data_out		<=	64'b0;
	state			<=	1'b0;
	oOutput_ready	<=	1'b0;
end
else
begin
	case (state)
	0:
		begin
			oOutput_ready	<=	1'b0;
			if (iInput_ready)
			begin
				data_out[31:0]	<=	iData_in;
				state			<=	1'b1;
			end
		end
	1:
		if (iInput_ready)
		begin
			data_out[63:32]	<=	iData_in;
			state			<=	1'b0;
			oOutput_ready	<=	1'b1;
		end
	endcase
end

endmodule

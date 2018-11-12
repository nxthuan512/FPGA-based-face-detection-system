module	ann_threshold	(
							//Input
							input						iClk,
							input						iReset_n,
							input						iInput_ready,
							input			[31:0]		iOutput_Logsig,
							//Output
							output		reg				oFlag,
							output		reg				oOutput_ready,
							output		reg	[31:0]		oData_out
						);

parameter		THRESHOLD	=	32'h800000;

//=================================REGISTERS=====================================
reg		[31:0]	data_in_reg;
reg				input_ready_reg;
//===================================WIRES=======================================
wire			flag;
wire	[31:0]	data_out;
//===============================================================================
assign	flag		=	data_in_reg	>=	THRESHOLD;
assign	data_out	=	(flag) ? data_in_reg : 32'h11EB85;
//===============================================================================
always	@ (posedge iClk)
if (~iReset_n)
begin
	oFlag			<=	1'b0;
	oOutput_ready	<=	1'b0;
	oData_out		<=	32'b0;
	data_in_reg		<=	32'b0;
	input_ready_reg	<=	1'b0;
end
else
begin
	input_ready_reg		<=	iInput_ready;
	if (iInput_ready)
		data_in_reg		<=	iOutput_Logsig;	
	else if (input_ready_reg)
	begin
		oFlag			<=	~flag;
		oData_out		<=	data_out;
		oOutput_ready	<=	1'b1;
	end
	else
	begin
		oOutput_ready	<=	1'b0;
		data_in_reg		<=	32'b0;
	end

end

endmodule

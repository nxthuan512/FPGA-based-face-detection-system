module	ann_mac	(
					//Input
					input					iClk,
					input					iReset_n,
					input					iInput_ready,
					input					iFinish,
					input		[31:0]		iData_in,
					input		[31:0]		iWeight,
					//Output
					output	reg	[31:0]		oData_out
				);
//=======================REGISTERS===================================
reg		[31:0]		a_reg;
reg		[31:0]		b_reg;
reg		[63:0]		mult_result_reg;
reg		[63:0]		pre_sum_reg;
reg					flag;
//=========================WIRES=====================================
wire	[63:0]		pre_mult_result;
wire	[63:0]		mult_result;
wire	[63:0]		sum_result;
//===================================================================
assign	sum_result	=	mult_result_reg + pre_sum_reg;
assign	mult_result	=	(~|a_reg[31:1] & a_reg[0]) ? {pre_mult_result[39:0],24'b0} : pre_mult_result;
//===================================================================
always	@ (posedge iClk)
if (~iReset_n)
begin
	a_reg			<=	32'b0;
	b_reg			<=	32'b0;
	mult_result_reg	<=	64'b0;
	pre_sum_reg		<=	64'b0;
	oData_out		<=	32'b0;
	flag			<=	1'b0;
end
else
begin
	mult_result_reg	<=	mult_result;
	oData_out		<=	(flag) ? sum_result[59:28] : oData_out;
	
	if (iInput_ready)
	begin
		flag			<=	1'b1;
		a_reg			<=	iData_in;
		b_reg			<=	iWeight;
	end
	else
	begin
		a_reg			<=	32'b0;
		b_reg			<=	32'b0;
	end
	
	if (iFinish)
	begin
		pre_sum_reg		<=	64'b0;
		flag			<=	1'b0;
	end
	else
		pre_sum_reg		<=	sum_result;
end

//=====================================================================	
mult	MULT	(
					.dataa					(a_reg),
					.datab					(b_reg),
					.result					(pre_mult_result)
				);

endmodule

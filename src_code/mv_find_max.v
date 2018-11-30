module mv_find_max	(
					//Input
					input				iClk,
					input				iReset_n,
					input				iRst_reg,
					input		[12:0]	iPosition,
					input		[31:0]	iData_in,
					//Output
					output	reg	[12:0]	oPosition,
					output	reg [31:0]	oMax_val
					);
wire	[31:0]	max;
wire			cond;
wire	[12:0]	position;

assign	cond	  =	iData_in > oMax_val;
assign	max		  =	(cond) ? iData_in : oMax_val;
assign	position =	(cond) ? iPosition : oPosition;

always @ (posedge iClk)
begin
	if (~iReset_n || iRst_reg)
		oMax_val	<=	32'b0;
	else
	begin
		oMax_val	<=	max;
		oPosition	<=	position;
	end
end

endmodule

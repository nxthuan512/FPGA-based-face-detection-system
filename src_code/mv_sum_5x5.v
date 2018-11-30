module mv_sum_5x5	(
						//Input
						input				iClk,
						input				iReset_n,
						input				iRun,
						input		[4:0]	iRdreq,
						input		[4:0]	iWrreq,
						input		[31:0]	iData_in,
						//Output
						output		[4:0]	oFF_full,
						output				oFinish,
						output		[31:0]	oData_out
					);
parameter	END_ROW_VAL	=	7'd75;
//=========================REGISTERS====================================
reg		[2:0]	counter1;
reg		[6:0]	counter2;
reg		[31:0]	odata0;
reg		[31:0]	odata1;
reg		[31:0]	odata2;
reg		[31:0]	odata3;
reg		[31:0]	odata4;
reg		[4:0]	start_pos;
reg		[4:0]	mask;
//===========================WIRES======================================
wire	[31:0]	data0;
wire	[31:0]	data1;
wire	[31:0]	data2;
wire	[31:0]	data3;
wire	[31:0]	data4;
wire	[31:0]	sum;
wire			end_row;
//======================================================================
assign	sum			=	data0 + data1 + data2 + data3 + data4;
assign	oFinish		=	counter1 == 3'd5;
assign	end_row		=	counter2 == END_ROW_VAL;
//======================================================================
always @ (posedge iClk)
begin
	if (~iReset_n || ~iRun)
	begin
		counter1	<=	3'b0;
		counter2	<=	7'b0;
		odata0		<=	32'b0;
		odata1		<=	32'b0;
		odata2		<=	32'b0;
		odata3		<=	32'b0;
		odata4		<=	32'b0;
		start_pos	<=	5'b1;
		mask		<=	5'b1;
	end
	else
		if (iRun)
		begin
			odata0		<=	(~mask[0]) ? odata0 : (start_pos[0]  & oFinish || end_row) ? sum : (odata0 + sum);
			odata1		<=	(~mask[1]) ? odata1 : (start_pos[1]  & oFinish) ? sum : (odata1 + sum);
			odata2		<=	(~mask[2]) ? odata2 : (start_pos[2]  & oFinish) ? sum : (odata2 + sum);
			odata3		<=	(~mask[3]) ? odata3 : (start_pos[3]  & oFinish) ? sum : (odata3 + sum);
			odata4		<=	(~mask[4]) ? odata4 : (start_pos[4]  & oFinish) ? sum : (odata4 + sum);

			start_pos	<=	(~oFinish) ? start_pos : (start_pos[4]) ? 5'b1 : {start_pos[3:0],1'b0};
			mask		<=	(oFinish) ? 5'b11111 : ({mask[3:0],1'b0} + start_pos);
				
			if (end_row)
			begin
				counter1	<= 3'b1;
				counter2	<= 7'b0;
				start_pos	<= 5'b1;
				mask		<= 5'd3;
				odata1		<= 32'b0;
				odata2		<= 32'b0;
				odata3		<= 32'b0;
				odata4		<= 32'b0;
			end
			else
			begin
				counter1	<=	(~oFinish) ? (counter1 + 1'b1) : counter1;
				counter2	<=	(oFinish) ? (counter2 + 1'b1) : counter2;
			end
		end
end
//======================================================================
scfifo_80x1	FF0		(
						.clock			(iClk),
						.data			(iData_in),
						.rdreq			(iRdreq[0]),
						.wrreq			(iWrreq[0]),
						.empty			(),
						.full			(oFF_full[0]),
						.q				(data0)
					);

scfifo_80x1	FF1		(
						.clock			(iClk),
						.data			(data0),
						.rdreq			(iRdreq[1]),
						.wrreq			(iWrreq[1]),
						.empty			(),
						.full			(oFF_full[1]),
						.q				(data1)
					);

scfifo_80x1	FF2		(
						.clock			(iClk),
						.data			(data1),
						.rdreq			(iRdreq[2]),
						.wrreq			(iWrreq[2]),
						.empty			(),
						.full			(oFF_full[2]),
						.q				(data2)
					);

scfifo_80x1	FF3		(
						.clock			(iClk),
						.data			(data2),
						.rdreq			(iRdreq[3]),
						.wrreq			(iWrreq[3]),
						.empty			(),
						.full			(oFF_full[3]),
						.q				(data3)
					);

scfifo_80x1	FF4		(
						.clock			(iClk),
						.data			(data3),
						.rdreq			(iRdreq[4]),
						.wrreq			(iWrreq[4]),
						.empty			(),
						.full			(oFF_full[4]),
						.q				(data4)
					);

mv_mux_5to1	MUX		(
						.isel			(start_pos),
						.idata0			(odata0),
						.idata1			(odata1),
						.idata2			(odata2),
						.idata3			(odata3),
						.idata4			(odata4),
						.odata			(oData_out)
					);					

endmodule

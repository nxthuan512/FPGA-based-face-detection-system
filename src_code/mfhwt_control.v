module mfhwt_control	(
							//Input external
							input					iClk,
							input					iReset_n,
							input					iData_ready,
							//Input internal
							input			[7:0]	iFull_Buffer0,
							input			[1:0]	iEmpty_Buffer0,
							
							input					iRdready_Buffer1,
							
							input			[3:0]	iFull_Buffer2,
							input					iEmpty_Buffer2,
							//Output external
							output	reg				oOutput_ready,
							//Output internal
							output					oSelect_Buffer0,
							output			[1:0]	oRdreq_Buffer0,
							output			[7:0]	oWrreq_Buffer0,
							
							output	reg				oWrreq_Buffer1,
							output					oSelect_Buffer1,
							
							output					oRdreq_Buffer2,
							output	reg		[3:0]	oWrreq_Buffer2			
						);
//=======================REGISTERS===================================
reg						sel_buf0;
reg						rdrq_0_buf0;
reg						rdrq_1_buf0;
reg						sel_buf1;
reg						rdrq_buf2;
reg						input_ready;
reg			[1:0]		rd_buf0;
//=======================WIRES=======================================
wire					allfull_0_buf0;
wire					allfull_1_buf0;
wire					allfull_buf2;
wire		[3:0]		wrrq_0_buf0;
wire		[3:0]		wrrq_1_buf0;
wire		[7:0]		invfull_buf0;
wire					wrrq_buf1;
wire		[3:0]		wrrq_buf2;
wire		[3:0]		wr_buf2;
wire		[3:0]		invfull_buf2;
//===================================================================
//	COMBINATION
//===================================================================
assign		allfull_0_buf0	= iFull_Buffer0[0] & iFull_Buffer0[1] & iFull_Buffer0[2] & iFull_Buffer0[3];
assign		allfull_1_buf0	= iFull_Buffer0[4] & iFull_Buffer0[5] & iFull_Buffer0[6] & iFull_Buffer0[7];
assign		allfull_buf2	= iFull_Buffer2[0] & iFull_Buffer2[1] & iFull_Buffer2[2] & iFull_Buffer2[3];

assign		oSelect_Buffer0   = (allfull_0_buf0) ? 1'b1 : (allfull_1_buf0) ? 1'b0 : sel_buf0;
assign		oRdreq_Buffer0[0] = (allfull_0_buf0) ? 1'b1 : (iEmpty_Buffer0[0]) ? 1'b0 : rdrq_0_buf0;
assign		oRdreq_Buffer0[1] = (allfull_1_buf0) ? 1'b1 : (iEmpty_Buffer0[1]) ? 1'b0 : rdrq_1_buf0;
assign		invfull_buf0 	  = ~iFull_Buffer0;
assign		wrrq_0_buf0		  = (invfull_buf0[0]) ? 4'd1 : (invfull_buf0[1]) ? 4'd2 : (invfull_buf0[2]) ? 4'd4 : (invfull_buf0[3]) ? 4'd8 : 4'd0;
assign		wrrq_1_buf0		  = (invfull_buf0[4]) ? 4'd1 : (invfull_buf0[5]) ? 4'd2 : (invfull_buf0[6]) ? 4'd4 : (invfull_buf0[7]) ? 4'd8 : 4'd0;
assign		oWrreq_Buffer0	  = (input_ready) ? {wrrq_1_buf0,wrrq_0_buf0} : 8'b0;

assign		wrrq_buf1	= (allfull_0_buf0 | allfull_1_buf0) ? 1'b1 : ((iEmpty_Buffer0[0] & rd_buf0[0]) | (iEmpty_Buffer0[1] & rd_buf0[1])) ? 1'b0 : oWrreq_Buffer1;
assign		oSelect_Buffer1 = (iRdready_Buffer1) ? ~sel_buf1 : sel_buf1;

assign		oRdreq_Buffer2 	= (allfull_buf2) ? 1'b1 : (iEmpty_Buffer2) ? 1'b0 : rdrq_buf2;
assign		invfull_buf2	= ~iFull_Buffer2;
assign		wr_buf2		= (invfull_buf2[0]) ? 4'd1 : (invfull_buf2[1]) ? 4'd2 : (invfull_buf2[2]) ? 4'd4 : (invfull_buf2[3]) ? 4'd8 : 4'd0;
assign		wrrq_buf2	= (iRdready_Buffer1) ? wr_buf2 : 4'b0;
//===================================================================
//	SEQUENCE
//===================================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		sel_buf0		<= 	1'b0;
		rdrq_0_buf0 	<= 	1'b0;
		rdrq_1_buf0 	<= 	1'b0;
		sel_buf1 		<= 	1'b0;
		rdrq_buf2		<=	1'b0;
		input_ready		<=	1'b0;
		rd_buf0			<=	2'b0;
		oWrreq_Buffer1	<= 	1'b0;
		oWrreq_Buffer2	<=	1'b0;
		oOutput_ready	<=	1'b0;
	end
	else
	begin
		rd_buf0			<= oRdreq_Buffer0;
		input_ready		<= iData_ready;
		sel_buf0 		<= oSelect_Buffer0;
		rdrq_0_buf0 	<= oRdreq_Buffer0[0];
		rdrq_1_buf0 	<= oRdreq_Buffer0[1];
		sel_buf1 		<= oSelect_Buffer1;
		oWrreq_Buffer1 	<= wrrq_buf1;
		rdrq_buf2 		<= oRdreq_Buffer2;
		oWrreq_Buffer2 	<= wrrq_buf2;
		oOutput_ready 	<= rdrq_buf2;
	end
end

endmodule

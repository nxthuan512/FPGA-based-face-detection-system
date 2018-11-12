module	iig_control (
						//Input
						input					iClk,
						input					iReset_n,
						input					iRun,
						input					iInput_ready,
						input					iFull_BUF0,
						input					iEmpty_BUF0,
						//Output
						output					oInt_rst_MAC,
						output		reg			oReady_MAC,
						output		reg			oSelect_BUF0,
						output					oRdreq_BUF0,
						output					oWrreq_BUF0,
						output		reg			oEnable_SUM0,
						output			[12:0]	oAddr_IIGBRAM,
						output		reg			oOutput_ready
					 );
//========================PARAMETERS=================================
parameter	EN_SUM 	  = 7'd80;
parameter	DISEN_SUM =	13'd4800;
//=========================REGISTERS=================================
reg				wrreq_BUF0;
reg				pre_wrreq_BUF0;
reg		[12:0]	counter;
reg		[6:0]	counter_end;
reg		[12:0]	addr_reg;
//===========================WIRES===================================
wire		cond0;
wire		cond1;
wire		cond2;
wire		cond3;
wire		cond4;
//===================================================================
//	COMBINATON
//===================================================================
assign		oInt_rst_MAC 	= iFull_BUF0;
assign		oRdreq_BUF0 	= (cond1) ? 1'b1 :(iInput_ready)?1'b1:1'b0;
assign		oWrreq_BUF0	 	= wrreq_BUF0;
assign		oAddr_IIGBRAM	= addr_reg;
 
assign		cond0	= (counter == EN_SUM) ? 1'b1 : 1'b0;
assign		cond1	= (counter == DISEN_SUM) ? 1'b1 : 1'b0;
assign		cond2	= oRdreq_BUF0 & oEnable_SUM0;
assign		cond3	= (counter_end >= 7'd3) ? 1'b1 : 1'b0;
assign		cond4 	= (counter_end == 7'd83) ? 1'b1 : 1'b0;
//===================================================================
//	SEQUENCE
//===================================================================
always	@ (posedge iClk)
begin
	if (~iReset_n || cond4 || ~iRun)
	begin
		counter			<= 13'b0;
		counter_end		<= 7'b0;
		addr_reg		<= 13'b0;
		oSelect_BUF0 	<= 1'b0;
		wrreq_BUF0 		<= 1'b0;
		oOutput_ready 	<= 1'b0;
		oEnable_SUM0	<= 1'b0;
		oReady_MAC		<= 1'b0;
	end
	else
	begin
		oReady_MAC 	 	<= iInput_ready;
		pre_wrreq_BUF0 	<= oWrreq_BUF0;
		addr_reg		<= (oOutput_ready) ? (addr_reg + 1'b1) : addr_reg;
		
		if (cond1)
		begin
			counter_end 	<= counter_end + 1'b1;
			wrreq_BUF0 		<= 1'b0;		
			oOutput_ready 	<= (cond3) ? 1'b1 : 1'b0;
		end
		else
		begin
			if (iInput_ready)
				counter	<= counter + 1'b1;
				
			if (cond0)
				oEnable_SUM0 <= 1'b1;			
				
			wrreq_BUF0 		<= (oRdreq_BUF0) ? 1'b1 : 1'b0;
			oOutput_ready	<= (cond2) ? 1'b1 : 1'b0;		
		end
		
		if (pre_wrreq_BUF0 & ~oWrreq_BUF0)
			oSelect_BUF0 <= (cond1) ? 1'b0 : ~oSelect_BUF0;
	end
end
endmodule

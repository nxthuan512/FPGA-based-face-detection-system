module iibg_19x19	(
						//Input	
						input					iClk,
						input					iReset_n,
						input					iRst,
						input					iRdreq,
						input					iFull,
						input					iWrreq,
						input		[8:0]		iAddr_read,
						input		[20:0]		iData_in,
						//Output
						output					oFull,
						output	reg				oReady,
						output	reg	[83:0]		oData0,
						output	reg	[83:0]		oData1,
						output	reg	[83:0]		oData2,
						output	reg	[83:0]		oData3,
						output	reg	[83:0]		oData4,
						output	reg	[83:0]		oData5,
						output	reg	[83:0]		oData6,
						output	reg	[83:0]		oData7
					);

//=======================REGISTERS================================
reg		[8:0]		addr_write;
reg		[83:0]		rec;
reg		[2:0]		sel;
reg		[3:0]		counter;
reg					rd_ram;
reg					full;
reg		[1:0]		state;
reg					rst_reg;
//=========================WIRES==================================
wire	[8:0]		addr_ram;
wire	[20:0]		q_ram;
wire				cond2;
wire	[83:0]		rec0;
wire	[83:0]		rec1;
wire	[83:0]		rec2;
wire	[83:0]		rec3;
wire	[83:0]		rec4;
wire	[83:0]		rec5;
wire	[83:0]		rec6;
wire	[83:0]		rec7;
wire				cond_rst;
wire				ready;
//================================================================
assign	addr_ram  = (iWrreq) ? addr_write : iAddr_read;
assign	cond2	  = counter == 4'd4;
assign	oFull	  = (addr_write == 9'd399) ? 1'b1 : 1'b0;
assign	ready     =	(full) ? 1'b1 : 1'b0;
assign	cond_rst  = ~iRst & rst_reg;
//================================================================
always @ (posedge iClk)
begin
	if (~iReset_n || cond_rst)
	begin
		addr_write	<=	9'b0;
		rec			<=	84'b0;
		sel			<=	3'b0;
		counter		<=	4'b0;
		full		<=	1'b0;
		rd_ram		<=	1'b0;
		state		<=	2'b0;
		rst_reg		<=	1'b0;
		oReady		<=	1'b0;
		oData0		<=	84'b0;
		oData1		<=	84'b0;
		oData2		<=	84'b0;
		oData3		<=	84'b0;
		oData4		<=	84'b0;
		oData5		<=	84'b0;
		oData6		<=	84'b0;
		oData7		<=	84'b0;
	end
	else
	begin
		oData0		<=	(sel == 3'h0) ? rec0 : oData0;
		oData1		<=	(sel == 3'h1) ? rec1 : oData1;
		oData2		<=	(sel == 3'h2) ? rec2 : oData2;
		oData3		<=	(sel == 3'h3) ? rec3 : oData3;
		oData4		<=	(sel == 3'h4) ? rec4 : oData4;
		oData5		<=	(sel == 3'h5) ? rec5 : oData5;
		oData6		<=	(sel == 3'h6) ? rec6 : oData6;
		oData7		<=	(sel == 3'h7) ? rec7 : oData7;
		
		rd_ram		<=	iRdreq;
		full		<=	iFull;
		oReady		<=	ready;
		rst_reg		<=	iRst;
		
		case (state)
		0:
			if (rd_ram)
				state	<= 2'b1;
			else if (oReady)
				state	<=	2'd2;
			else
				state	<=	2'b0;
		1:
			begin
				counter	<=	counter	+ 1'b1;
				rec		<=	{q_ram,rec[83:21]};
				if (cond2)
				begin
					counter	<=	4'b0;
					rec		<=	84'b0;
					sel 	<=	sel + 1'b1;
					state	<=	2'b0;
				end
				else
					state	<=	2'b1;
				
			end
		2:
			begin
				counter	<=	4'b0;
				rec		<=	84'b0;
				sel		<=	3'b0;
				oData0	<=	84'b0;
				oData1	<=	84'b0;
				oData2	<=	84'b0;
				oData3	<=	84'b0;
				oData4	<=	84'b0;
				oData5	<=	84'b0;
				oData6	<=	84'b0;
				oData7	<=	84'b0;
				state	<=	2'b0;
			end
		endcase
		
		if (iWrreq)
			addr_write	<=	addr_write + 1'b1;
		if (oFull)
			addr_write	<=	9'b0;
	end
end

//============================================================================
spram_19x19	BRAM_GROUP_19x19	(
									//Input
									.clock			(iClk),
									.wren			(iWrreq),
									.data			(iData_in),
									.address		(addr_ram),
									//Output
									.q				(q_ram)
								);

demux_1to8	DEMUX				(
									//Input
									.idata			(rec),
									.isel			(sel),
									//Output
									.odata0			(rec0),
									.odata1			(rec1),
									.odata2			(rec2),
									.odata3			(rec3),
									.odata4			(rec4),
									.odata5			(rec5),
									.odata6			(rec6),
									.odata7			(rec7)
								);
							
endmodule

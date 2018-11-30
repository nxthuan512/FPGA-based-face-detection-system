module mfhwt_scfifo_160x4 	(
								//Input
								input				iClk,
								input		[3:0]	iWrreq,
								input				iRdreq,
								input		[15:0]	iData,
								//Output
								output		[3:0]	oFull,
								output				oEmpty,
								output		[63:0]	oData
							);
//=======================WIRES================================
wire	[15:0]	data_to_ff0;
wire	[15:0]	data_to_ff1;
wire	[15:0]	data_to_ff2;
wire	[15:0]	data_to_ff3;

wire	[15:0]	data_from_ff0;
wire	[15:0]	data_from_ff1;
wire	[15:0]	data_from_ff2;
wire	[15:0]	data_from_ff3;

wire			full_ff0;
wire			full_ff1;
wire			full_ff2;
wire			full_ff3;

wire			empty_ff0;
wire			empty_ff1;
wire			empty_ff2;
wire			empty_ff3;	

wire	[1:0]	sel_demux;
//=============================================================
//	COMBINATION								   
//=============================================================
assign		oFull 		= {full_ff3,full_ff2,full_ff1,full_ff0};
assign		oEmpty 		= empty_ff3 & empty_ff2 & empty_ff1 & empty_ff0;
assign 		oData 		= {data_from_ff3,data_from_ff2,data_from_ff1,data_from_ff0};
assign		sel_demux		= (iWrreq[1]) ? 2'd1 : (iWrreq[2]) ? 2'd2 : (iWrreq[3]) ? 2'd3 : 2'd0;
//=============================================================
mfhwt_demux_1to4	DEMUX1to4 	(
									.idata		(iData),
									.isel		(sel_demux),
									.odata0		(data_to_ff0),
									.odata1		(data_to_ff1),
									.odata2		(data_to_ff2),
									.odata3		(data_to_ff3)
								);

mfhwt_scfifo_160x1	FF0 		(
									.clock		(iClk),
									.data		(data_to_ff0),
									.rdreq		(iRdreq),
									.wrreq		(iWrreq[0]),
									.empty		(empty_ff0),
									.full		(full_ff0),
									.q			(data_from_ff0)
								);

mfhwt_scfifo_160x1	FF1 		(
									.clock		(iClk),
									.data		(data_to_ff1),
									.rdreq		(iRdreq),
									.wrreq		(iWrreq[1]),
									.empty		(empty_ff1),
									.full		(full_ff1),
									.q			(data_from_ff1)
								);

mfhwt_scfifo_160x1	FF2 		(
									.clock		(iClk),
									.data		(data_to_ff2),
									.rdreq		(iRdreq),
									.wrreq		(iWrreq[2]),
									.empty		(empty_ff2),
									.full		(full_ff2),
									.q			(data_from_ff2)
								);

mfhwt_scfifo_160x1	FF3 		(
									.clock		(iClk),
									.data		(data_to_ff3),
									.rdreq		(iRdreq),
									.wrreq		(iWrreq[3]),
									.empty		(empty_ff3),
									.full		(full_ff3),
									.q			(data_from_ff3)
								);

endmodule

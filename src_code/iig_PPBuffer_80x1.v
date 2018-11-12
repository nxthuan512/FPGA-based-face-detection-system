module iig_PPBuffer_80x1 (
						//Input
						input				iClk,
						input				iReset_n,
						input				iSelect,
						input				iRdreq,
						input				iWrreq,
						input		[20:0]	iData,
						//Output
						output				oFull,
						output				oEmpty,
						output		[20:0]	oData
					);

//=======================REGISTERS========================
reg						wrreq;
reg						sel;
//========================WIRES===========================
wire					demux_select;
wire					mux_select;

wire		[20:0]		data_to_buf0;
wire		[20:0]		data_from_buf0;
wire					full_buf0;
wire					empty_buf0;
wire					rdreq_buf0;
wire					wrreq_buf0;

wire		[20:0]		data_to_buf1;
wire		[20:0]		data_from_buf1;
wire					full_buf1;
wire					empty_buf1;
wire					rdreq_buf1;
wire					wrreq_buf1;
//=========================================================
//	COMBINATION
//=========================================================
assign		oFull 	 	 = full_buf1 | full_buf0;
assign		oEmpty		 = empty_buf1 | empty_buf0; 
 
assign		demux_select = sel;
assign		mux_select 	 = ~sel;

assign		rdreq_buf0	 = demux_select & iRdreq;
assign		wrreq_buf0	 = mux_select & wrreq;
assign		rdreq_buf1	 = mux_select & iRdreq;
assign		wrreq_buf1	 = demux_select & wrreq;
//=========================================================
//	SEQUENCE
//=========================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		wrreq	<= 1'b0;
		sel <= 1'b0;
	end
	else
	begin
		wrreq	<= iWrreq;
		sel <= iSelect;
	end
end
//=========================================================
iig_demux_1to2	DEMUX1to2 	(
								.idata				(iData),
								.isel				(demux_select),
								.odata0				(data_to_buf0),
								.odata1				(data_to_buf1)
							);

iig_mux_2to1	MUX2to1 	(
								.data0x				(data_from_buf0),
								.data1x				(data_from_buf1),
								.sel				(mux_select),
								.result				(oData)
							);

iig_scfifo_80x1	BUF0 		(
								.clock				(iClk),
								.wrreq				(wrreq_buf0),
								.rdreq				(rdreq_buf0),
								.data				(data_to_buf0),
								.full				(full_buf0),
								.empty				(empty_buf0),
								.q					(data_from_buf0)
							);

iig_scfifo_80x1	BUF1 		(
								.clock				(iClk),
								.wrreq				(wrreq_buf1),
								.rdreq				(rdreq_buf1),
								.data				(data_to_buf1),
								.full				(full_buf1),
								.empty				(empty_buf1),
								.q					(data_from_buf1)
							);

endmodule

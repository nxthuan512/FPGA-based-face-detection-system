module mfhwt_PPBuffer_640x4 (
								//Input
								input				iClk,
								input				iSelect,
								input		[1:0]	iRdreq,
								input		[7:0]	iWrreq,
								input		[15:0]	iData,
								//Output
								output		[7:0]	oFull,
								output		[1:0]	oEmpty,
								output		[63:0]	oData
							);
//========================WIRES===========================
wire					demux_select;
wire					mux_select;

wire		[15:0]		data_to_buf0;
wire		[63:0]		data_from_buf0;
wire		[3:0]		full_buf0;
wire					empty_buf0;
wire		[3:0]		wrreq_buf0;

wire		[15:0]		data_to_buf1;
wire		[63:0]		data_from_buf1;
wire		[3:0]		full_buf1;
wire					empty_buf1;
wire		[3:0]		wrreq_buf1;
//=========================================================
//	COMBINATION
//=========================================================
assign		oFull 	 	 = {full_buf1,full_buf0};
assign		oEmpty		 = {empty_buf1,empty_buf0};  
assign		demux_select = iSelect;
assign		mux_select 	 = ~iSelect;
assign		wrreq_buf0 	 = (~iSelect) ? iWrreq[3:0] : 4'b0; 
assign		wrreq_buf1 	 = (iSelect) ? iWrreq[7:4] : 4'b0; 
//=========================================================
mfhwt_demux_1to2	DEMUX1to2 	(
									.idata				(iData),
									.isel				(demux_select),
									.odata0				(data_to_buf0),
									.odata1				(data_to_buf1)
								);

mfhwt_mux_2to1	MUX2to1 		(
									.data0x				(data_from_buf0),
									.data1x				(data_from_buf1),
									.sel				(mux_select),
									.result				(oData)
								);

mfhwt_scfifo_640x4	BUF0 		(
									.iClk				(iClk),
									.iWrreq				(wrreq_buf0),
									.iRdreq				(iRdreq[0]),
									.iData				(data_to_buf0),
									.oFull				(full_buf0),
									.oEmpty				(empty_buf0),
									.oData				(data_from_buf0)
								);

mfhwt_scfifo_640x4	BUF1 		(
									.iClk				(iClk),
									.iWrreq				(wrreq_buf1),
									.iRdreq				(iRdreq[1]),
									.iData				(data_to_buf1),
									.oFull				(full_buf1),
									.oEmpty				(empty_buf1),
									.oData				(data_from_buf1)
								);

endmodule

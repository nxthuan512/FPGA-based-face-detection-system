module mfhwt_PPBuffer 	(
							//Input
							input				iClk,
							input				iReset_n,
							input				iSelect,
							input				iWrreq,
							input		[15:0]	iData,
							//Output
							output	reg			oRdready,
							output		[63:0]	oData
						);
//=======================REGISTERS=============================
reg		[63:0]		reg0;
reg		[63:0]		reg1;
reg		[2:0]		counter;
//=======================WIRES=================================
wire	[15:0]		data_to_reg0;
wire	[63:0]		data_from_reg0;

wire	[15:0]		data_to_reg1;
wire	[63:0]		data_from_reg1;

wire				demux_sel;
wire				mux_sel;

wire	[63:0]		odata_0;
wire	[63:0]		odata_1;

wire				rd_en;
//=============================================================
//	COMBINATION
//=============================================================
assign		demux_sel 		= iSelect;
assign		mux_sel 		= ~iSelect;

assign		data_from_reg0  = reg0;
assign		data_from_reg1  = reg1;

assign		odata_0 		= {data_to_reg0,reg0[63:16]};
assign		odata_1 		= {data_to_reg1,reg1[63:16]};

assign		rd_en = (counter == 3'd4) ? 1'b1 : 1'b0;
//=============================================================
//	SEQUENCE
//=============================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		reg0 <= 64'b0;
		reg1 <= 64'b0;
		counter <= 3'b0;
		oRdready <= 1'b0;
	end
	else
	begin
		if (iWrreq)
			counter <= counter + 1'b1;
		else
			counter <= 3'b0;
		
		if (rd_en)
		begin
			oRdready <= 1'b1;
			counter <= 3'b1;
		end
		else
			oRdready <= 1'b0;
		
		if (~iSelect)
			reg0 <= odata_0;
		else
			reg1 <= odata_1;
	end
end

mfhwt_demux_1to2	DEMUX1to2 	(	
									.idata				(iData),
									.isel				(demux_sel),
									.odata0				(data_to_reg0),
									.odata1				(data_to_reg1)
								);

mfhwt_mux_2to1	MUX2to1 		(
									.data0x				(data_from_reg0),
									.data1x				(data_from_reg1),
									.sel				(mux_sel),
									.result				(oData)
								);

endmodule

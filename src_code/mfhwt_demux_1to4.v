module mfhwt_demux_1to4 (
							input			[15:0]	idata,
							input			[1:0]	isel,
							output			[15:0]	odata0,
							output			[15:0]	odata1,
							output			[15:0]	odata2,
							output			[15:0]	odata3
						);

assign		odata0 = (isel == 2'h0) ? idata : 16'h0;
assign		odata1 = (isel == 2'h1) ? idata : 16'h0;
assign		odata2 = (isel == 2'h2) ? idata : 16'h0;
assign		odata3 = (isel == 2'h3) ? idata : 16'h0;

endmodule

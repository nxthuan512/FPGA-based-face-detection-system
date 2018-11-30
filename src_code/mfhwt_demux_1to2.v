module mfhwt_demux_1to2 (
							input			[15:0]	idata,
							input					isel,
							output			[15:0]	odata0,
							output			[15:0]	odata1
						);

assign		odata0 = (~isel) ? idata : 16'h0;
assign		odata1 = (isel) ? idata : 16'h0;

endmodule

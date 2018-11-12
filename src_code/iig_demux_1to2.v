module iig_demux_1to2 (
					input			[20:0]	idata,
					input					isel,
					output			[20:0]	odata0,
					output			[20:0]	odata1
				);

assign		odata0 = (~isel) ? idata : 21'h0;
assign		odata1 = (isel) ? idata : 21'h0;

endmodule

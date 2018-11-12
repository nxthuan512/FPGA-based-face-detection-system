module demux_1to8 (
					input			[83:0]	idata,
					input			[2:0]	isel,
					output			[83:0]	odata0,
					output			[83:0]	odata1,
					output			[83:0]	odata2,
					output			[83:0]	odata3,
					output			[83:0]	odata4,
					output			[83:0]	odata5,
					output			[83:0]	odata6,
					output			[83:0]	odata7
				);

assign		odata0 = (isel == 3'h0) ? idata : 84'h0;
assign		odata1 = (isel == 3'h1) ? idata : 84'h0;
assign		odata2 = (isel == 3'h2) ? idata : 84'h0;
assign		odata3 = (isel == 3'h3) ? idata : 84'h0;
assign		odata4 = (isel == 3'h4) ? idata : 84'h0;
assign		odata5 = (isel == 3'h5) ? idata : 84'h0;
assign		odata6 = (isel == 3'h6) ? idata : 84'h0;
assign		odata7 = (isel == 3'h7) ? idata : 84'h0;

endmodule

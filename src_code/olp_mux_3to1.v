module olp_mux_3to1 (
						input			[2:0]	isel,
						input			[12:0]	idata0,
						input			[12:0]	idata1,
						input			[12:0]	idata2,
						output			[12:0]	odata
					);

assign		odata = (isel[0]) ? idata0 : (isel[1]) ? idata1 : (isel[2]) ? idata2 : 13'b0;
endmodule

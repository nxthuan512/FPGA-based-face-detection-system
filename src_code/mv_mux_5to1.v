module mv_mux_5to1 (
						input			[4:0]	isel,
						input			[31:0]	idata0,
						input			[31:0]	idata1,
						input			[31:0]	idata2,
						input			[31:0]	idata3,
						input			[31:0]	idata4,
						output			[31:0]	odata
					);

assign		odata = (isel[0]) ? idata0 : (isel[1]) ? idata1 : (isel[2]) ? idata2 : (isel[3]) ? idata3 : (isel[4]) ? idata4 : 32'b0;
endmodule

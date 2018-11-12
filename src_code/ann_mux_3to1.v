module	ann_mux_3to1	(
							//Input
							input		[1:0]		iSel,
							input		[31:0]		iFeature,
							input		[31:0]		iOutput_Logsig,
							//Output
							output		[31:0]		oData_out
						);
						
assign		oData_out	=	(iSel == 2'b0) ? 32'b1 : (iSel == 2'b1) ? iFeature : iOutput_Logsig;						

endmodule

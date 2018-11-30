module	om	(
				//Input
				input					iClk,
				input					iReset_n,
				input					iRun_PostP,
				input		[12:0]		iAddr_ANN_OM_23x23,
				input		[12:0]		iAddr_PostP_OM_23x23,
				input					iWrreq_ANN_OM_23x23,
				input					iWrreq_PostP_OM_23x23,
				input		[31:0]		iData_to_OM_23x23,
				input		[31:0]		iZr_to_OM_23x23,
				input		[12:0]		iAddr_ANN_OM_19x19,
				input		[12:0]		iAddr_PostP_OM_19x19,
				input					iWrreq_ANN_OM_19x19,
				input					iWrreq_PostP_OM_19x19,
				input		[31:0]		iData_to_OM_19x19,
				input		[31:0]		iZr_to_OM_19x19,
				input		[12:0]		iAddr_ANN_OM_17x17,
				input		[12:0]		iAddr_PostP_OM_17x17,
				input					iWrreq_ANN_OM_17x17,
				input					iWrreq_PostP_OM_17x17,
				input		[31:0]		iData_to_OM_17x17,	
				input		[31:0]		iZr_to_OM_17x17,
				input					iRun_Set_OM,
				input					iFinish_Set_OM,
				input		[12:0]		iAddr_Set_OM,
				input					iWrreq_Set_OM,
				input		[31:0]		iData_Set_OM,
				//Output
				output		[31:0]		oData_from_OM_23x23,
				output		[31:0]		oData_from_OM_19x19,
				output		[31:0]		oData_from_OM_17x17,
				output					oEnd
			);
			
//==============================REGISTERS=================================
reg		run_set_om_reg;
//================================WIRES===================================
wire	[12:0]		addr_23x23;
wire	[12:0]		addr_19x19;
wire	[12:0]		addr_17x17;

wire	[31:0]		idata_23x23;
wire	[31:0]		idata_19x19;
wire	[31:0]		idata_17x17;

wire				wrreq_23x23;
wire				wrreq_19x19;
wire				wrreq_17x17;

wire				run_set_om;
//========================================================================
assign	wrreq_23x23	=	(iRun_PostP) ? iWrreq_PostP_OM_23x23 : (run_set_om) ? iWrreq_Set_OM : iWrreq_ANN_OM_23x23;
assign	wrreq_19x19	=	(iRun_PostP) ? iWrreq_PostP_OM_19x19 : (run_set_om) ? iWrreq_Set_OM : iWrreq_ANN_OM_19x19;
assign	wrreq_17x17	=	(iRun_PostP) ? iWrreq_PostP_OM_17x17 : (run_set_om) ? iWrreq_Set_OM : iWrreq_ANN_OM_17x17;

assign	addr_23x23	=	(iRun_PostP) ? iAddr_PostP_OM_23x23 : (run_set_om) ? iAddr_Set_OM : iAddr_ANN_OM_23x23;
assign	addr_19x19	=	(iRun_PostP) ? iAddr_PostP_OM_19x19 : (run_set_om) ? iAddr_Set_OM : iAddr_ANN_OM_19x19;
assign	addr_17x17	=	(iRun_PostP) ? iAddr_PostP_OM_17x17 : (run_set_om) ? iAddr_Set_OM : iAddr_ANN_OM_17x17;

assign	oEnd		=	iWrreq_ANN_OM_17x17 & (iAddr_ANN_OM_17x17 == 13'd4151);

assign	idata_23x23	=	(iRun_PostP) ? iZr_to_OM_23x23 : (run_set_om) ? iData_Set_OM : iData_to_OM_23x23;
assign	idata_19x19	=	(iRun_PostP) ? iZr_to_OM_19x19 : (run_set_om) ? iData_Set_OM : iData_to_OM_19x19;
assign	idata_17x17	=	(iRun_PostP) ? iZr_to_OM_17x17 : (run_set_om) ? iData_Set_OM : iData_to_OM_17x17;

assign	run_set_om	=	(iRun_Set_OM) ? 1'b1 : (iFinish_Set_OM) ? 1'b0 : run_set_om_reg;
//========================================================================
always	@	(posedge iClk)
if (~iReset_n)
	run_set_om_reg	<=	1'b0;
else
	run_set_om_reg	<=	run_set_om;
//========================================================================
om_23x23	OM_23x23	(
							.address				(addr_23x23),
							.clock					(iClk),
							.data					(idata_23x23),
							.wren					(wrreq_23x23),
							.q						(oData_from_OM_23x23)
						);
						
om_19x19	OM_19x19	(
							.address				(addr_19x19),
							.clock					(iClk),
							.data					(idata_19x19),
							.wren					(wrreq_19x19),
							.q						(oData_from_OM_19x19)
						);

om_17x17	OM_17x17	(
							.address				(addr_17x17),
							.clock					(iClk),
							.data					(idata_17x17),
							.wren					(wrreq_17x17),
							.q						(oData_from_OM_17x17)
						);

endmodule

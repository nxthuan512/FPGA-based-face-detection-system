module write_master_pipeline (
							// --- Global Signals ---
							input				iClk,
							input				iReset_n,
							// --- Signals from/to CONTROL_SLAVE ---
							input				iStart,
							input		[31:0]	iStart_write_address,
							output 				oDone,
							// --- Signals from/to AVALON_BUS ---
							input				iWait_request,								
							output 	reg			oWrite,							
							output  	[31:0]	oWrite_data,
							output 		[31:0]	oWrite_address,
							// --- Signals from/to WRITE_MASTER ---
							input				iWM_write_request,
							input		[31:0]	iWM_write_address,
							input		[31:0]	iWM_write_data,
							input				iFinish,
							output				oWait_request
			);
// ------------------ Wire Declarations ------------------
wire	[31:0]		write_address;
wire				FF_read_request;
wire				FF_empty;
// ------------------ Reg Declarations -------------------					
reg					state;
reg		[31:0]		start_address;
//--------------------------------------------------------
assign	write_address 	= iWM_write_address + start_address;
assign 	FF_read_request = ~iWait_request & ~FF_empty;
assign	oDone			= iFinish;
assign	oWait_request	= iWait_request;

always @ (posedge iClk)				
begin
	if (~iReset_n)
	begin
		start_address	<=	32'b0;
		oWrite			<=	1'b0;
	end
	else
	begin
		oWrite	<=	(~iWait_request) ? FF_read_request : oWrite;
		if (iStart)
			start_address	<=	iStart_write_address;
	end
end

write_fifo WRITE_ADDR 	(
							.clock		(iClk),
							.data		(write_address),
							.rdreq		(FF_read_request),
							.wrreq		(iWM_write_request),
							.empty		(FF_empty),
							.full		(),
							.q			(oWrite_address),
							.usedw		()
						);

write_fifo WRITE_DATA 	(
							.clock		(iClk),
							.data		(iWM_write_data),
							.rdreq		(FF_read_request),
							.wrreq		(iWM_write_request),
							.empty		(),
							.full		(),
							.q			(oWrite_data),
							.usedw		()
						);

endmodule

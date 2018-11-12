module dma_rb_wp_controller (
						input					iClk,
						input					iReset_n,
						// CONTROL SLAVE Side
						input					iCS_chip_select,
						input					iCS_read,
						input					iCS_write,
						input		[3:0]		iCS_address,
						input		[31:0]		iCS_write_data,
						output		[31:0]		oCS_read_data,
						// READ MASTER Side
						input					iRM_read_data_valid,
						input					iRM_wait_request,
						input		[31:0]		iRM_read_data,
						output					oRM_read,
						output		[31:0]		oRM_read_address,
						output		[9:0]		oRM_burst_length,
						// WRITE MASTER Side
						input					iWM_wait_request,
						output					oWM_write,
						output		[31:0]		oWM_write_address,
						output		[31:0]		oWM_write_data,
						//CORE SIDE
						input					iWrreq_SDRAM,
						input		[31:0]		iAddr_SDRAM,
						input		[31:0]		iData_to_SDRAM,
						input					iFinish,
						output					oWrite_wait_request,
						output					oOutput_ready,
						output		[31:0]		oData_out
					);
					
parameter	READ_MASTER_ADDRESS_INC 	= 4;
parameter	READ_MASTER_BURST_LENGTH 	= 64;
// ====================================================================
// Wire Declaration
// ====================================================================
// SLAVE CONTROL
wire				WM_done,
					RM_start,
					WM_start;
wire	[31:0]		src_address,
					dest_address,
					length;
// READ MASTER
wire				RM_FF_almost_full,
					RM_FF_write_request;
wire	[31:0]		RM_FF_data;

// WRITE MASTER
wire				WM_FF_empty,
					WM_FF_read_request;
wire	[31:0]		WM_FF_q;

// ====================================================================
// CONTROL SLAVE
control_slave CONTROL_SLAVE (
							// Inputs
							.iClk						(iClk),
							.iReset_n					(iReset_n),
							.iChip_select				(iCS_chip_select),
							.iWrite						(iCS_write),
							.iRead						(iCS_read),
							.iWM_done					(WM_done),
							.iAddress					(iCS_address),
							.iWrite_data				(iCS_write_data),
							
							// Outputs
							.oRM_start					(RM_start),
							.oWM_start					(WM_start),
							.oRead_data					(oCS_read_data),
							.oSrc_address				(src_address),
							.oDest_address				(dest_address),
							.oLength					(length)
					);

// READ MASTER BURST MODE	
read_master_burst READ_MASTER_BURST (
							// --- Global Signals ---
							.iClk						(iClk),
							.iReset_n					(iReset_n),
							// --- Signals from/to CONTROL_SLAVE ---
							.iStart						(RM_start),
							.iStart_read_address		(src_address),
							.iLength					(length),
							// --- Signals from/to AVALON_BUS ---
							.iRead_data_valid			(iRM_read_data_valid),
							.iWait_request				(iRM_wait_request),						
							.iRead_data					(iRM_read_data),
							.oBurst_length				(oRM_burst_length),							
							.oRead						(oRM_read),
							.oRead_address				(oRM_read_address),	
							// --- Signals from/to READ_MASTER ---
							.iRM_read_request			(RM_FF_read_request),
							.oOutput_ready				(oOutput_ready),
							.oRM_wait_request			(RM_FF_empty),
							.oRM_read_data				(oData_out)	
					);
defparam	READ_MASTER_BURST.BURST_LENGTH 	= READ_MASTER_BURST_LENGTH;
defparam	READ_MASTER_BURST.ADDRESS_INC 	= READ_MASTER_ADDRESS_INC;	

write_master_pipeline WRITE_MASTER_PIPELINE (
							// --- Global Signals ---
							.iClk						(iClk),
							.iReset_n					(iReset_n),
							// --- Signals from/to CONTROL_SLAVE ---
							.iStart						(WM_start),		
							.iStart_write_address		(dest_address),
							.oDone						(WM_done),
							// --- Signals from/to AVALON_BUS ---
							.iWait_request				(iWM_wait_request),		
							.oWrite_data				(oWM_write_data),
							.oWrite						(oWM_write),	
							.oWrite_address				(oWM_write_address),
							// --- Signals from/to WRITE_MASTER_CORE ---
							.iWM_write_request			(iWrreq_SDRAM),
							.iWM_write_address			(iAddr_SDRAM),
							.iWM_write_data				(iData_to_SDRAM),
							.iFinish					(iFinish),
							.oWait_request				(oWrite_wait_request)
			);
			
// ===============================================================
wire	RM_FF_empty;
wire	RM_FF_read_request;

reg		s1_RM_FF_read_request;

assign 	RM_FF_read_request 	= s1_RM_FF_read_request && ~RM_FF_empty;

always @ (posedge iClk)
begin
	if (~iReset_n)
		s1_RM_FF_read_request	<= 1'b0;	
	else 
		s1_RM_FF_read_request	<= ~RM_FF_empty;
end
	
endmodule

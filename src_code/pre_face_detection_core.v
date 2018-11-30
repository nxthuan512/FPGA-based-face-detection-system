module	pre_face_detection_core	(
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
									output		[31:0]		oWM_write_data
								);

//======================================WIRES=======================================
wire				inputready;
wire	[31:0]		idata_fd;
wire				outputready;
wire	[31:0]		oaddr_sdram;
wire	[31:0]		odata_sdram;
wire				finish;
wire				write_wait_request;
//==================================================================================		
dma_rb_wp_controller DMA	(
								.iClk						(iClk),
								.iReset_n					(iReset_n),
								// CONTROL SLAVE Side
								.iCS_chip_select			(iCS_chip_select),
								.iCS_read					(iCS_read),
								.iCS_write					(iCS_write),
								.iCS_address				(iCS_address),
								.iCS_write_data				(iCS_write_data),
								.oCS_read_data				(oCS_read_data),
								// READ MASTER Side
								.iRM_read_data_valid		(iRM_read_data_valid),
								.iRM_wait_request			(iRM_wait_request),
								.iRM_read_data				(iRM_read_data),
								.oRM_read					(oRM_read),
								.oRM_read_address			(oRM_read_address),
								.oRM_burst_length			(oRM_burst_length),
								// WRITE MASTER Side
								.iWM_wait_request			(iWM_wait_request),
								.oWM_write					(oWM_write),
								.oWM_write_address			(oWM_write_address),
								.oWM_write_data				(oWM_write_data),
								//CORE SIDE
								.iWrreq_SDRAM				(outputready),
								.iAddr_SDRAM				(oaddr_sdram),
								.iData_to_SDRAM				(odata_sdram),
								.iFinish					(finish),
								.oWrite_wait_request		(write_wait_request),
								.oOutput_ready				(inputready),
								.oData_out					(idata_fd)
							);
					
face_detection	FD			(
								//Input
								.iClk						(iClk),
								.iReset_n					(iReset_n),
								.iInput_ready				(inputready),
								.iData_in					(idata_fd),
								.iWrite_wait_request		(write_wait_request),
								//Output
								.oAddr_OI					(oaddr_sdram),
								.oWrreq_OI					(outputready),
								.oData_out					(odata_sdram),
								.oFinish					(finish)
							);
					
endmodule

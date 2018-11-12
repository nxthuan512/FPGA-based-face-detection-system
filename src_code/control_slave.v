module control_slave (
						// Inputs
						input				iClk,
						input				iReset_n,
						input				iChip_select,
						input				iWrite,
						input				iRead,
						input				iWM_done,
						input		[3:0]	iAddress,
						input		[31:0]	iWrite_data,
						
						// Outputs
						output	reg			oRM_start,
						output	reg			oWM_start,
						output	reg [31:0]	oRead_data,
						output	reg [31:0]	oSrc_address,
						output	reg	[31:0]	oDest_address,
						output 	reg	[31:0]	oLength
					);

// ------------------ Wire Declarations -------------------
wire			GO, 
				DONE, 
				BUSY;

// ------------------ Reg Declarations -------------------
reg		[31:0]	control,
				status;

// =======================================================
// Bit			31	... 16 	15	... 8   7   6    5    4    3    2    1    0	
// Control:					Reserved				 	  				  GO
// Status:					Reserved								BUSY  DONE
assign GO = control[0];
assign {DONE, BUSY} = status[1:0];

// ========================================================
// Receive config data from Nios II
// ========================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		oSrc_address		<= 32'h0;
		oDest_address		<= 32'h0;
		oLength				<= 32'h0;
		control				<= 32'h0;
		oRead_data			<= 32'h0;					
	end
	
	else if (DONE)
		control[0] <= 1'b0;
		
	else if (iChip_select)
	begin
		// ----- WRITE -----
		// 0x0: 		Source Address
		// 0x1: 		Destination Address
		// 0x2: 		Length
		// 0x3 - 0x6: 	Reserved
		// 0x7:			Control
		// ----- READ -----
		// 0x8 - 0xE:	Reserved
		// 0xF:			Status
		if (iWrite & ~BUSY)
			case (iAddress)
				4'h0: oSrc_address 		<= iWrite_data;
				4'h1: oDest_address		<= iWrite_data;
				4'h2: oLength			<= iWrite_data;
				4'h7: control 	  		<= iWrite_data;
			endcase
		
		else if (iRead)
			case (iAddress)
				4'hF: oRead_data[1:0]	<= status[1:0];		
			endcase
	end 		
end

// ========================================================
// Control RM and WM
// ========================================================
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		status 					<= 32'h0;
		{oRM_start, oWM_start} 	<= 2'h0;
	end
	
	else
		case ({DONE, BUSY})
			// Init State
			2'h0: begin
				if (GO)
				begin
					{oRM_start, oWM_start} 	<= 2'h3;				
					// Jump to BUSY State
					status[1:0]				<= 2'h1;
				end
			end
			
			// BUSY State
			2'h1: begin
				{oRM_start, oWM_start} 		<= 2'h0;
				// Jump to DONE State
				if (iWM_done) status[1:0]	<= 2'h2;
			end
			
			// DONE State
			// Jump to Init State
			2'h2: status[1:0]				<= 2'h0;
				
			default:;
		endcase
end

endmodule

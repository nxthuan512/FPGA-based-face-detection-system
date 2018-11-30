module read_master_burst (
							// --- Global Signals ---
							input				iClk,
							input				iReset_n,
							// --- Signals from/to CONTROL_SLAVE ---
							input				iStart,
							input		[31:0]	iStart_read_address,
							input		[31:0]	iLength,
							// --- Signals from/to AVALON_BUS ---
							input				iRead_data_valid,
							input				iWait_request,						
							input		[31:0]	iRead_data,
							output		[9:0]	oBurst_length,							
							output 	reg			oRead,
							output	reg	[31:0]	oRead_address,	
							// --- Signals from/to READ_MASTER_CORE ---
							input				iRM_read_request,
							output				oRM_wait_request,
							output	reg			oOutput_ready,
							output		[31:0]	oRM_read_data							
						);

// BURST_LENGTH supports up to 64 (words)
// Each word contains ADDRESS_INC (bytes)
parameter			BURST_LENGTH 		= 10'd64;
// ADDRESS_INC = 4, 8, 16, 32 (bytes)
parameter			ADDRESS_INC 		= 4;
// BURST_ADDRES_INC gives the last read address after a burst transaction
localparam			BURST_ADDRESS_INC 	= (BURST_LENGTH * ADDRESS_INC);
localparam			BURST_LENGTH_SUB_1	= (BURST_LENGTH - 1);

// ============================================
// Wire Declarations
// ============================================
wire				FF_almost_full;
wire	[6:0]		FF_used_word;
wire	[31:0]		s1_oRead_address;

// ============================================
// Reg Declarations
// ============================================
reg		[1:0]		state;
reg		[9:0]		burst_count;
reg		[31:0]		end_read_address;

// ========================================================
// Main Process
// ========================================================
assign oBurst_length    = BURST_LENGTH;
assign s1_oRead_address = oRead_address + BURST_ADDRESS_INC;

///// Main State Machine //////
always @ (posedge iClk)
begin
	if (~iReset_n)
	begin
		oRead				<= 1'b0;
		oRead_address 		<= 32'h0;
		oOutput_ready		<= 1'b0;
		burst_count			<= 10'h0;
		end_read_address 	<= 32'h0;
		state				<= 2'h0;
	end
	
	else 
	begin
		oOutput_ready	<=	iRM_read_request;
		case (state)
			// If there is a iStart pulse, READ_MASTER_BURST initializes the registers, outputs
			// and jump to next state 
			2'h0: if (iStart)
			begin
				oRead				<= 1'b1;
				oRead_address 		<= iStart_read_address;				
				end_read_address 	<= iStart_read_address + iLength - ADDRESS_INC;
				state				<= 2'h1;
			end	
			
			// If iWaitrequest is deasserted, READ_MASTER_BURST has to be waiting for new valid data 
			// If iRead_data_valid is asserted, burst_count is increased 1, and READ_MASTER_BURST
			// obtains new valid data
			2'h1: begin
				if (~iWait_request)
				begin
					oRead					<= 1'b0;
					// A burst transaction has done, jump to next state
					if (burst_count == BURST_LENGTH)
					begin
						burst_count			<= 10'h0;
						if (s1_oRead_address > end_read_address)
							state			<= 2'h0;
						else
						begin
							oRead_address	<= s1_oRead_address;
							// After a transaction, oRead must wait for 1 clock before being asserted again
							if (~FF_almost_full)	oRead		<= 1'b1;
							else					state		<= 2'h2;
						end
					end
				end
				
				if (iRead_data_valid )
					burst_count				<= burst_count + 1'b1;
			end
			
			// If oRead_address <= end_read_address, go to Step 1
			2'h2: if (~FF_almost_full)
			begin
				oRead				<= 1'b1;
				state				<= 2'h1;
			end
			
			default:;
		endcase
	end
end

read_fifo READ_FIFO (
						.clock				(iClk),
						.data				(iRead_data),
						.rdreq				(iRM_read_request),
						.wrreq				(iRead_data_valid),
						.empty				(oRM_wait_request),
						.full				(),
						.q					(oRM_read_data),
						.usedw				(FF_used_word)
					);
assign FF_almost_full 	= (FF_used_word > BURST_LENGTH + 'd32);

endmodule

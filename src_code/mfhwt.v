module mfhwt (
				//Input
				input				iClk,
				input				iReset_n,
				input				iInput_ready,
				input		[31:0]	iData_in,
				//Output
				output				oOutput_ready,
				output		[15:0]	oData_out
			);

//====================WIRES============================
//CONTROLLER
wire			oSelect_BUFFER0;
wire	[1:0]	oRdreq_BUFFER0;
wire	[7:0]	oWrreq_BUFFER0;
wire			oWrreq_BUFEER1;
wire			oSelect_BUFFER1;
wire			oRdreq_BUFFER2;
wire	[3:0]	oWrreq_BUFFER2;
//AVG0
wire	[15:0]	odata_AVG0_idata_BUFFER0;
//BUFFER0
wire	[63:0]	odata_BUFFER0_idata_AVG1;
wire	[7:0]	oFull_BUFFER0;
wire	[1:0]	oEmpty_BUFFER0;
//AVG1
wire	[15:0]	odata_AVG1_idata_BUFFER1;
//BUFFER1
wire			oRdready_BUFEER1;
wire	[63:0]	odata_BUFFER1_idata_AVG2;

//AVG2
wire	[15:0]	odata_AVG2_idata_BUFFER2;
//BUFFER2
wire	[63:0]	odata_BUFFER2_idata_AVG3;
wire	[3:0]	oFull_BUFFER2;
wire			oEmpty_BUFFER2;

wire	[63:0]	data_in;
wire			inputready;
//=====================REGISTERS=======================
reg		[63:0]	idata_AVG0;
reg				iData_ready;
reg		[18:0]	counter;
//=====================================================
always @ (posedge iClk)
if (~iReset_n)
begin
	idata_AVG0 	<= 1'b0;
	iData_ready <= 1'b0;
end
else
begin
	idata_AVG0 	<= data_in;
	iData_ready <= inputready;
end

mfhwt_control CONTROL_MFHWT (
							//Input external
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.iData_ready			(iData_ready),
							//Input internal
							.iFull_Buffer0			(oFull_BUFFER0),
							.iEmpty_Buffer0			(oEmpty_BUFFER0),
							
							.iRdready_Buffer1		(oRdready_BUFEER1),
							
							.iFull_Buffer2			(oFull_BUFFER2),
							.iEmpty_Buffer2			(oEmpty_BUFFER2),
							//Output external
							.oOutput_ready			(oOutput_ready),
							//Output internal
							.oSelect_Buffer0		(oSelect_BUFFER0),
							.oRdreq_Buffer0			(oRdreq_BUFFER0),
							.oWrreq_Buffer0			(oWrreq_BUFFER0),
							
							.oWrreq_Buffer1			(oWrreq_BUFEER1),
							.oSelect_Buffer1		(oSelect_BUFFER1),
							
							.oRdreq_Buffer2			(oRdreq_BUFFER2),
							.oWrreq_Buffer2			(oWrreq_BUFFER2)	
							);

i32_o64	I32_O64				(
							//Input
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.iInput_ready			(iInput_ready),
							.iData_in				(iData_in),
							//Output
							.oOutput_ready			(inputready),
							.oData_out				(data_in)
							);							

mfhwt_avg AVG0				(
							//Input
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.idata					(idata_AVG0),
							//Output
							.odata					(odata_AVG0_idata_BUFFER0)
							);
							
mfhwt_PPBuffer_640x4 BUFFER0(
							//Input
							.iClk					(iClk),
							.iSelect				(oSelect_BUFFER0),
							.iRdreq					(oRdreq_BUFFER0),
							.iWrreq					(oWrreq_BUFFER0),
							.iData					(odata_AVG0_idata_BUFFER0),
							//Output
							.oFull					(oFull_BUFFER0),
							.oEmpty					(oEmpty_BUFFER0),
							.oData					(odata_BUFFER0_idata_AVG1)
							);
							
mfhwt_avg AVG1				(
							//Input
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.idata					(odata_BUFFER0_idata_AVG1),
							//Output
							.odata					(odata_AVG1_idata_BUFFER1)
							);
							
mfhwt_PPBuffer BUFFER1		(
							//Input
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.iSelect				(oSelect_BUFFER1),
							.iWrreq					(oWrreq_BUFEER1),
							.iData					(odata_AVG1_idata_BUFFER1),
							//Output
							.oRdready				(oRdready_BUFEER1),
							.oData					(odata_BUFFER1_idata_AVG2)
							);
							
mfhwt_avg AVG2				(
							//Input
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.idata					(odata_BUFFER1_idata_AVG2),
							//Output
							.odata					(odata_AVG2_idata_BUFFER2)
							);
							
mfhwt_PPBuffer_160x4 BUFFER2(
							//Input
							.iClk					(iClk),
							.iRdreq					(oRdreq_BUFFER2),
							.iWrreq					(oWrreq_BUFFER2),
							.iData					(odata_AVG2_idata_BUFFER2),
							//Output
							.oFull					(oFull_BUFFER2),
							.oEmpty					(oEmpty_BUFFER2),
							.oData					(odata_BUFFER2_idata_AVG3)
							);
							
mfhwt_avg AVG3				(
							//Input
							.iClk					(iClk),
							.iReset_n				(iReset_n),
							.idata					(odata_BUFFER2_idata_AVG3),
							//Output
							.odata					(oData_out)
							);
					
endmodule

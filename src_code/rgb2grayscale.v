module rgb2grayscale (
						//Input
						input					iClk,
						input					iReset_n,
						input					iInput_ready,
						input			[15:0]	iRGB,
						//Output
						output	reg				oOutput_ready,
						output	reg		[7:0]	oY
					 );
//================WIRES==========================
wire	[6:0]		yr;
wire	[7:0]		yg;
wire	[4:0]		yb;	
wire	[7:0]		y;
//===============SPLIT RGB=======================
wire	[7:0]		r;
wire	[7:0]		g;
wire	[7:0]		b;
//===============================================
//	COMBINATION
//===============================================
assign	y = (yr + yg) + yb;
assign	r = {iRGB[15:11],3'b0};
assign	g = {iRGB[10:5],2'b0};
assign	b = {iRGB[4:0],3'b0};
//===============================================

always @ (posedge iClk)
begin
	if (!iReset_n)
	begin
		oOutput_ready <= 1'b0;
		oY <= 8'b0;
	end
	else
	begin
		oOutput_ready <= iInput_ready;
		oY <= y;
	end
end

r2Yr	R2YR	(
					.iClk			(iClk),
					.iReset_n		(iReset_n),
					.iR				(r),
					.oYR			(yr)
				);

g2Yg	G2YG	(
					.iClk			(iClk),
					.iReset_n		(iReset_n),
					.iG				(g),
					.oYG			(yg)
				);

b2Yb	B2YB	(
					.iClk			(iClk),
					.iReset_n		(iReset_n),
					.iB				(b),
					.oYB			(yb)
				);

endmodule

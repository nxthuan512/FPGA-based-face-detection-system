module	hfg_normalization_17x17 	(
										//Input
										input					iClk,
										input					iReset_n,
										input		[20:0]		iPre_Feature,
										//Output
										output	reg	[31:0]		oFeature
									);
//----------------------------REGISTERS=======================
reg		[19:0]		abs_prefeature;
reg					sign_reg;
//==============================WIRES=========================
wire	[19:0]		pre_feature;
wire	[36:0]		unsign_feature;
wire	[31:0]		sign_feature;
wire	[31:0]		feature;
wire				sign;
// ========================== Pre-calculate ==================
wire	[34:0]		f_shl_14 = {abs_prefeature,14'b0};
wire	[31:0]		f_shl_11 = {abs_prefeature,11'b0};
wire	[28:0]		f_shl_8	 = {abs_prefeature,8'b0};
wire	[25:0]		f_shl_5  = {abs_prefeature,5'b0};
wire	[23:0]		f_shl_3  = {abs_prefeature,3'b0};
wire	[21:0]		f_shl_1  = {abs_prefeature,1'b0};
//=======================  Normalization 19x19 ================
assign		sign			= iPre_Feature[20];
assign		pre_feature 	= (iPre_Feature[20]) ? (~iPre_Feature[19:0] + 1'b1) : iPre_Feature[19:0];
assign		unsign_feature	= ((f_shl_14 - f_shl_11) + (f_shl_8 - f_shl_5)) + (f_shl_3 + f_shl_1);
assign		feature			= {1'b0,unsign_feature[36:6]};
assign		sign_feature	= (sign_reg) ? (~feature + 1) : feature;
//=============================================================
always @ (posedge iClk)
if (~iReset_n)
begin
	oFeature <= 31'b0;
	sign_reg <= 1'b0;
end
else
begin
	abs_prefeature	<= pre_feature;
	oFeature 		<= sign_feature;
	sign_reg		<= sign;
end

endmodule

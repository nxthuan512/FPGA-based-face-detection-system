module	hfg_normalization_19x19 	(
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
wire	[33:0]		f_shl_13 = {abs_prefeature,13'b0};
wire	[31:0]		f_shl_11 = {abs_prefeature,11'b0};
wire	[30:0]		f_shl_10 = {abs_prefeature,10'b0};
wire	[28:0]		f_shl_8	 = {abs_prefeature,8'b0};
wire	[27:0]		f_shl_7  = {abs_prefeature,7'b0};
wire	[24:0]		f_shl_4  = {abs_prefeature,4'b0};
//=======================  Normalization 19x19 ================
assign		sign			= iPre_Feature[20];
assign		pre_feature 	= (iPre_Feature[20]) ? (~iPre_Feature[19:0] + 1'b1) : iPre_Feature[19:0];
assign		unsign_feature	= ((f_shl_13 + f_shl_11) + (f_shl_10 + f_shl_8)) + (f_shl_7 + f_shl_4);
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

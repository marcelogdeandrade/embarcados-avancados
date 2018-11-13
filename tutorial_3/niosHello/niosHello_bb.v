
module niosHello (
	button_export,
	clk_clk,
	keys_export,
	leds_leds,
	reset_reset_n,
	encoder_a_export,
	encoder_b_export);	

	input		button_export;
	input		clk_clk;
	input	[3:0]	keys_export;
	output	[5:0]	leds_leds;
	input		reset_reset_n;
	input		encoder_a_export;
	input		encoder_b_export;
endmodule

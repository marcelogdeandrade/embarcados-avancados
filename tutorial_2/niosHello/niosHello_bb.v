
module niosHello (
	button_export,
	clk_clk,
	keys_export,
	leds_export,
	reset_reset_n);	

	input		button_export;
	input		clk_clk;
	input	[3:0]	keys_export;
	output	[5:0]	leds_export;
	input		reset_reset_n;
endmodule

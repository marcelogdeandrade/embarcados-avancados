library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0);
		  
		  fpga_keys          : in std_logic_vector(3 downto 0);
		  
		  fpga_enable        : in std_logic;
		  
		  fpga_encoder_a     : in std_logic;
		  
		  fpga_encoder_b     : in std_logic;
		  
		  fpga_switch_encoder : in std_logic

	);
end entity topLevel;

architecture rtl of topLevel is


 component niosHello is
	  port (
			button_export : in  std_logic                    := 'X';             -- export
			clk_clk       : in  std_logic                    := 'X';             -- clk
			keys_export   : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			leds_leds     : out std_logic_vector(5 downto 0);                    -- leds
			reset_reset_n : in  std_logic                    := 'X';             -- reset_n
			encoder_a_export : in std_logic                  := 'X';
			encoder_b_export : in std_logic                  := 'X'
			);
 end component niosHello;


begin
	
 u0 : component niosHello
	  port map (
			button_export => fpga_enable, -- button.export
			clk_clk       => fpga_clk_50,       --    clk.clk
			keys_export   => fpga_keys,   --   keys.export
			leds_leds     => open,   --   leds.export
			reset_reset_n => not fpga_switch_encoder,  --  reset.reset_n
			encoder_a_export => fpga_encoder_a,
			encoder_b_export => fpga_encoder_b
        );
		  
		  fpga_led_pio(0) <= fpga_switch_encoder;
end architecture;
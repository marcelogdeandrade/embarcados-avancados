library IEEE;
use IEEE.std_logic_1164.all;

entity topLevel is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0);
		  
		  fpga_keys          : in std_logic_vector(3 downto 0);
		  
		  fpga_enable        : in std_logic

	);
end entity topLevel;

architecture rtl of topLevel is

-- signal
signal blink : std_logic := '0';

begin
	
  led_peripheral: work.LED_peripheral
  port map (
				clk => fpga_clk_50, blink_out => blink, enable => fpga_enable, KEY => fpga_keys
  );

  fpga_led_pio(0) <= blink;
  fpga_led_pio(1) <= blink;
  fpga_led_pio(2) <= blink;
  fpga_led_pio(3) <= blink;
  fpga_led_pio(4) <= blink;
  fpga_led_pio(5) <= blink;

end architecture;
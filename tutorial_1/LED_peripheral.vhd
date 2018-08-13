library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity LED_peripheral is 
   generic ( 
				freq : integer := 10000000;
				step : integer := 10000000
	);
	port (
		clk : in STD_LOGIC;
		enable: in STD_LOGIC := '0';
		KEY : in STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '1');
		blink_out : out STD_LOGIC
	);
end entity LED_peripheral;


architecture led_p of LED_peripheral is

	-- Declarations (optional)
signal blink : std_logic := '0';
signal multiplier : integer;
signal freq_multiplied : integer;
signal counter : integer := 0;

begin

	multiplier <= to_integer(unsigned(KEY));
	freq_multiplied <= freq * (1 + multiplier);
	process(clk)
	begin
	  if (rising_edge(clk)) then
					if (counter < freq_multiplied) then
						 counter <= counter + 1;
					else
						 blink <= not blink;
						 counter <= 0;
					end if;
	  end if;
	end process;
	
	blink_out <= blink and enable;


end led_p;

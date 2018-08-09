library IEEE;
use IEEE.std_logic_1164.all;

entity LED_peripheral is 
   generic ( 
				freq : integer := 25000000;
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

begin
	
	process(clk)
	variable counter : integer range 0 to freq := 0;
	begin
	  if (rising_edge(clk)) then
					if (counter < freq) then
						 counter := counter + 1;
					else
						 blink <= not blink;
						 counter := 0;
					end if;
	  end if;
	end process;
	
	blink_out <= blink;


end led_p;



--                                                      0
-- REG0 - CONFIG - R/W  [                              EN ]
--                 EN : 0 Desligado/ 1 Ligado                                          
-- REG1 - Pulsos 


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;
use work.all;

entity peripheral_ENCONDER is
    port (
        -- Gloabals
        clk                : in  std_logic                     := '0';             
        reset              : in  std_logic                     := '0';             

        -- I/Os
        A               : in std_logic;
		  B               : in std_logic;
		  
        -- Avalion Memmory Mapped Slave
        avs_address     : in  std_logic_vector(3 downto 0)  := (others => '0'); 
        avs_read        : in  std_logic                     := '0';             
        avs_readdata    : out std_logic_vector(31 downto 0) := (others => '0'); 
        avs_write       : in  std_logic                     := '0';             
        avs_writedata   : in  std_logic_vector(31 downto 0) := (others => '0')
	);
end entity peripheral_ENCONDER;

architecture rtl of peripheral_ENCONDER is

signal REG_PULSOS : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

signal POSITION : integer := 0;
signal POSITION_DEGREES : integer := 0;

-- Build an enumerated type for the state machine
type state_type is (s0, s1, s2, s3, s4, s5, s6);

-- Register to hold the current state
signal state : state_type;

begin

  process(clk)
  begin
  
    if (reset = '1') then
		state <= s0;
		POSITION <= 0;
		
    elsif(rising_edge(clk)) then
		  
		   -- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when s0=>
					if A = '1' and B = '0' then
						state <= s1;
						POSITION <= POSITION + 1;
					elsif A = '0' and B = '1' then
						state <= s4;
						POSITION <= POSITION + 1;
					else
						state <= s0;
					end if;
				when s1=>
					if A = '1' and B = '1' then
						state <= s2;
						POSITION <= POSITION + 1;
					else
						state <= s1;
					end if;
				when s2=>
					if A = '0' and B = '1' then
						state <= s3;
						POSITION <= POSITION + 1;
					elsif A = '1' and B = '0' then
						state <= s6;
						POSITION <= POSITION + 1;
					else
						state <= s2;
					end if;
				when s3=>
					if A = '0' and B = '0' then
						state <= s0;
						POSITION <= POSITION + 1;
					else
						state <= s3;
					end if;
				when s4=>
					if A = '1' and B = '1' then
						state <= s5;
						POSITION <= POSITION + 1;
					else
						state <= s4;
					end if;
				when s5=>
					if A = '1' and B = '0' then
						state <= s6;
						POSITION <= POSITION + 1;
					elsif A = '0' and B = '1' then
						state <= s3;
						POSITION <= POSITION + 1;
					else 
						state <= s5;
					end if;
				when s6=>
					if A = '0' and B = '0' then
						state <= s0;
						POSITION <= POSITION + 1;
					else
						state <= s6;
					end if;
			end case;
		  
		  
		  
		  -- Position to degrees
		  POSITION_DEGREES <= POSITION;
		  
		  -- Position to array
		  REG_PULSOS <= conv_std_logic_vector(POSITION_DEGREES, REG_PULSOS'length);
		  
		  if (avs_read = '1') then
				if(avs_address = "0001") then                  -- REG_DATA
					avs_readdata <= REG_PULSOS;
            end if;		  
		  end if;
    end if;
  end process; 
  

end rtl;
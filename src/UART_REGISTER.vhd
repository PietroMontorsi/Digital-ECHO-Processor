library ieee;
use ieee.std_logic_1164.all;

entity UART_REGISTER is 
generic  (N : integer := 8);
	port (  D : in std_logic_vector (N-1 downto 0);
		     CLK, RST, LE : in std_logic;
		     Q : out std_logic_vector(N-1 downto 0));

end UART_REGISTER;

architecture Behavior of UART_REGISTER is 

begin 

  process (CLK, RST)
  begin
      
    if RST = '1' then
	    Q <= (others => '0');

    else
    
		if (CLK'event and CLK = '1') then
			if LE =  '1' then
			Q <= D;
		   end if;

		end if;
       
	 end if;
	
   end process;

end architecture;

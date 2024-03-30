library ieee;
use ieee.std_logic_1164.all;

entity UART_FFD is 
	port ( D, CLK, RST : in std_logic;
		Q : out std_logic);

end UART_FFD;

architecture Behavior of UART_FFD is 

begin 

  process (CLK, RST)
  begin
      
    if RST = '0' then
	Q <= '0'; 

     end if;
  
    if CLK'event and CLK = '1' then
       Q <= D; 
    end if;
   
   end process;

end Behavior;

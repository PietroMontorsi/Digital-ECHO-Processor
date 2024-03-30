library ieee;
use ieee.std_logic_1164.all;

entity UART_COMP is
generic ( NCOMP : integer);
	port( IN1 , IN2 : in std_logic_vector (NCOMP-1 downto 0);
	      OutCOMP : out std_logic); 
end UART_COMP;

architecture Behavior of UART_COMP is 


begin 

Comparetore_Proc : process(IN1)

variable tmp_OutCOMP : std_logic := '0';

begin

  if  IN1 = IN2 then 
    tmp_OutCOMP := '1';
  else 
    tmp_OutCOMP := '0';	 
  end if;

OutCOMP <= tmp_OutCOMP;

end process;

end Behavior;
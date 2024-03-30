library ieee;
use ieee.std_logic_1164.all;

entity UART_CNT is
generic ( N : integer);
	port( CLR, CE, CLK : in std_logic;
	      CNT : out integer range 0 to N;
	      TC : out std_logic); 
end UART_CNT;

architecture Behavior of UART_CNT is 


begin 

Counter_Proc : process(CLK, CLR)

variable tmp_TC : std_logic := '0';
variable tmp_Cnt  : integer := 0;
begin 

if CLR = '1' then      
   tmp_Cnt := 0;
   tmp_TC := '0';

elsif CLK'event and CLK = '1' then
         
        if CE = '1' then
	       tmp_Cnt := tmp_Cnt + 1;
	       tmp_TC := '0';

	     if tmp_Cnt = N then
            tmp_TC :=  '1';
            tmp_Cnt := 0;
   
        end if; 
         
 
        end if;

        
end if;

CNT <= tmp_Cnt;
TC <= tmp_TC;

end process Counter_Proc; 

end Behavior;

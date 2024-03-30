library ieee;
use ieee.std_logic_1164.all;

entity UART_SIPO is 
generic  (N : integer := 8);
	port (  SIn, CLK, RST, SE : in std_logic;
		QParall     : out std_logic_vector (N-1 downto 0));
end UART_SIPO;

architecture Behavior of UART_SIPO is 


begin 

UART : process (CLK, RST)

variable temp_reg : std_logic_vector (N-1 downto 0);

  begin
      
    if RST = '1' then  -- reset asincrono positivo 
	temp_reg := (others => '0');
     
  
    elsif CLK'event and CLK = '1' then
      if (SE = '1') then 
         for i in N-1 downto 1 loop
	  temp_reg(i) := temp_reg(i-1);
	 end loop;
         temp_reg(0) := SIn;           
      end if;  
     
   end if; 
   
   QParall <= temp_reg;

end process;

end Behavior;

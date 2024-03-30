library ieee;
use ieee.std_logic_1164.all;

entity UART_PISO is 
generic  (PISO_N : integer := 10);
	port ( LE, SIn, CLK, RST, SE : in std_logic;
		DIn         : in std_logic_vector ( PISO_N-1 downto 0);
		QSer                : out std_logic);
end UART_PISO;

architecture Behavior of UART_PISO is 


begin 

UART : process (CLK, RST)

variable temp_reg : std_logic_vector (PISO_N-1 downto 0);

  begin
      
    if RST = '1' then  -- reset asincrono positivo 
	    temp_reg := (others => '1');
     else
  
    if CLK'event and CLK = '1' then
      if (SE = '1') then 
         for i in PISO_N-1 downto 1 loop
	         temp_reg(i) := temp_reg(i-1);
	      end loop;
        temp_reg(0) := SIn;           
      end if;  
       
      if (LE = '1') then 
	     Temp_reg := DIn ;  
      end if;
     
   end if; 
	end if;
   
   QSer <= temp_reg(PISO_N-1);

end process;

end architecture;

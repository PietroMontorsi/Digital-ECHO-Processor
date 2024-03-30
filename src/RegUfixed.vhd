library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;

entity RegUfixed is 
generic  (N : integer := 8);
	port (  D : in ufixed(-1 downto -N);
		CLK, RST, LE : in std_logic;
		Q : out ufixed(-1 downto -N));

end RegUfixed;

architecture Behavior of RegUfixed is 

begin 

  process (CLK, RST)
  begin
      
    if RST = '1' then
	Q <= (others => '0');
    
  
    elsif CLK'event and CLK = '1' then
      if LE =  '1' then
       Q <= D;
      end if;

    end if;
   
   end process;

end Behavior;


library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;


entity Adder is
	port (  Adder_In1, Adder_In2 : in ufixed(-1 downto -8);
		Adder_Out : out ufixed( -1 DOWNTO -8));

end Adder;

architecture Behavior of Adder is
    
 signal Sum : ufixed( 0 DOWNTO -8);

begin

 process(Adder_In1, Adder_In2)
  
  begin    
          
   Sum <= (Adder_In1 + Adder_In2); 

 end process;

 
process(Sum, Adder_In1, Adder_In2)
 
 begin    
     
   if (Sum(0) = '1') then 
     
     Adder_Out <= (others => '1');
  
   elsif (Sum(0) = '0') then
 
     Adder_Out(-1 DOWNTO -8) <= Sum(-1 DOWNTO -8);

   end if;   

 end process;

 end Behavior;

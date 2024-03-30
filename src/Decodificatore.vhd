library ieee;
use ieee.std_logic_1164.all;

entity Decodificatore is 
	port (  AsciIn : in std_logic_vector(7 downto 0);
		HexOut : out std_logic_vector(7 downto 0);
		En     : in std_logic;
		Ready, Error : out std_logic); 

end Decodificatore;

architecture Behavior of Decodificatore is 


begin

Process ( AsciIn, En)
  
variable tmp_bit4 : std_logic_vector (3 downto 0);
variable tmp_byte : std_logic_vector (7 downto 0);
variable tmp_cnt  : integer := 0;
variable tmp_Ready, tmp_Error  : std_logic := '0';

begin

 if En = '1' then  
    
    case AsciIn is
      when "01100001" | "01000001" =>   tmp_bit4 := "1010";   --aA
					tmp_cnt := tmp_cnt + 1;
					tmp_Error := '0';
      when "01100010" | "01000010" =>   tmp_bit4 := "1011";   --bB
					tmp_Error := '0';
					tmp_cnt := tmp_cnt + 1;
      when "01100011" | "01000011" =>   tmp_bit4 := "1100";   --cC
					tmp_cnt := tmp_cnt + 1;	
					tmp_Error := '0';
      when "01100100" | "01000100" =>   tmp_bit4 := "1101";   --dD
					tmp_cnt := tmp_cnt + 1;
					tmp_Error := '0';
      when "01100101" | "01000101" =>   tmp_bit4 := "1110";   --eE
					tmp_cnt := tmp_cnt + 1;
					tmp_Error := '0';
      when "01100110" | "01000110" =>   tmp_bit4 := "1111";   --fF
					tmp_cnt := tmp_cnt + 1;
					tmp_Error := '0';
      when "00110000" =>   tmp_bit4 := "0000";   --0 
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00110001" =>   tmp_bit4 := "0001";   --1
			   tmp_cnt := tmp_cnt + 1;
		 	   tmp_Error := '0';
      when "00110010" =>   tmp_bit4 := "0010";   --2
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00110011" =>   tmp_bit4 := "0011";   --3 
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00110100" =>   tmp_bit4 := "0100";   --4
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00110101" =>   tmp_bit4 := "0101";   --5
		           tmp_cnt := tmp_cnt + 1;
   			   tmp_Error := '0';
      when "00110110" =>   tmp_bit4 := "0110";   --6
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00110111" =>   tmp_bit4 := "0111";   --7
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00111000" =>   tmp_bit4 := "1000";   --8
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      when "00111001" =>   tmp_bit4 := "1001";   --9
			   tmp_cnt := tmp_cnt + 1;
			   tmp_Error := '0';
      
      when others => tmp_Ready := '0'; 
	             tmp_Error := '1'; 
 
    end case;
   
     
   --elsif   En = '0' then      
     --tmp_Ready := '0';
     --tmp_byte := "00000000";

end if;    

case tmp_cnt is
       
       when 0 => tmp_Ready := '0';       

       when 1 => 
	     
		 tmp_byte(7 downto 4) := tmp_bit4;
                 --tmp_cnt := tmp_cnt + 1;
	         tmp_Ready := '0';
            
       when 2 => 
             
		 tmp_byte(3 downto 0) := tmp_bit4;
                 tmp_cnt := 0;
	         tmp_Ready := '1';
               
   
       when others =>  tmp_Ready := '0';
		       --tmp_cnt := 0; 
		       --tmp_byte := "00000000";
     end case; 

Error <= tmp_Error;   
Ready <= tmp_Ready;
HexOut <= tmp_byte;

end process;

end Behavior;

library ieee;
use ieee.std_logic_1164.all;

entity Ric_Ist is 
	port (  ByteIn : in std_logic_vector(7 downto 0);
		Instruction : out std_logic_vector(1 downto 0)); 

end Ric_Ist;

architecture Behavior of Ric_Ist is 

begin

Process (ByteIn)

variable tmp_Instruction : std_logic_vector(1 downto 0);

begin
case ByteIn is
      when "01010100" => tmp_Instruction := "11";
      when "00101010" => tmp_Instruction := "01";
      when "00101101" => tmp_Instruction := "10";
      when others => tmp_Instruction := "00";
end case;

Instruction <= tmp_Instruction;

end process;

end Behavior;

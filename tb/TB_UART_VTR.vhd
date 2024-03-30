library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_VTR is

end TB_UART_VTR;

architecture Behavior of TB_UART_VTR is 

component UART_VTR is
generic ( N : integer := 3);
	port( bit3in : in std_logic_vector ( N-1 downto 0);
	      LE : in std_logic;
	      Dataid, NF : out std_logic); 
end component;


signal TB_bit3in : std_logic_vector (2 downto 0);
signal TB_Dataid, TB_LE, TB_NF : std_logic;

begin

TB_bit3in <= "000", "001" after 10 ns, "010" after 20 ns, "011" after 30 ns, "100" after 40 ns, "101" after 50 ns, "110" after 60 ns,
           "111" after 70 ns;
TB_LE <= '1';

Comparatore : UART_VTR 
	--generic map (N => 3)
	port map ( bit3in => TB_bit3in, Dataid => TB_Dataid, LE => TB_LE, NF => TB_NF);


end Behavior;

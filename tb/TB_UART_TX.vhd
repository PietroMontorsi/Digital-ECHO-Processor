library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_TX is
generic (PISO_N : integer := 10; N : integer := 8);
end TB_UART_TX;


architecture Behavior of TB_UART_TX is

component CLK_GEN is
	port ( CLK, RST : out std_logic);

end component;

component UART_TX is

generic (PISO_N : integer := 10; N : integer := 8);

         port ( T_E, CLK : in std_logic;
                Data : in std_logic_vector ( N-1 downto 0 );
		T_X : out std_logic);

end component;


signal TB_T_E, TB_CLK, TB_T_X : std_logic;
signal TB_Data : std_logic_vector ( N-1 downto 0 );

begin

TB_T_E <= '0', '1' after 32000 ns, '0' after 32100 ns;
TB_Data <= "00000000", "00010110" after 32000 ns, "00000000" after 32100 ns;

CLOCK : CLK_GEN port map(
	CLK => TB_CLK);

UART : UART_TX port map(
	T_E => TB_T_E, CLK => TB_CLK, Data => TB_Data, T_X => TB_T_X);

end Behavior;
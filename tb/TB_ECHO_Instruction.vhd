library ieee;
use ieee.std_logic_1164.all;

entity TB_ECHO_Instruction is 

end TB_ECHO_Instruction;

architecture Behavior of TB_ECHO_Instruction is 

component ECHO_Instruction is

	port( REG_GAIN, REG_DECAY : out std_logic_vector ( 7 downto 0);
	      REG_DELAY : out std_logic_vector ( 15 downto 0 );
	      ECHO_UART_RX, CLK : in std_logic);

end component;

component Clk_Gen is
	port ( clk, reset : out std_logic);
end component;

signal TB_REG_GAIN, TB_REG_DECAY : std_logic_vector (7 downto 0);
signal TB_REG_DELAY : std_logic_vector (15 downto 0);
signal TB_ECHO_UART_RX, TB_Clk : std_logic;

begin
--00101010 *    00101101 -
--00110101 5    01000110 F
--01100001 a    00110001 1
 
TB_ECHO_UART_RX <= '1', '0' after 5.21 us, '1' after 10.4 us, '0' after 15.6 us, '1' after 20.6 us, '1' after 26.0 us, '0' after 31.3 us, '1' after 36.5 us, '0' after 41.7 us, '0' after 46.9 us, '1' after 52.1 us,
                        '0' after 67.3 us, '0' after 72.5 us, '1' after 77.7 us, '1' after 82.9 us, '0' after 88.1 us, '0' after 93.3 us, '0' after 98.5 us, '1' after 103.8 us, '0' after 109 us, '1' after 114 us,
                        '0' after 129.4 us, '1' after 134.6 us, '0' after 139.8 us, '0' after 145 us, '0' after 150.2 us, '1' after 155.4 us, '1' after 160.6 us, '0' after 165.8 us, '0' after 171 us, '1' after 176.3 us,
			
			'0' after 291.5 us, '0' after 296.7 us, '1' after 301.9 us, '0' after 307.1 us, '1' after 312.3 us, '0' after 317.6 us, '1' after 322.8 us, '0' after 328 us, '0' after 333.2 us, '1' after 338.4 us,
                        '0' after 363.6 us, '1' after 368.8 us, '0' after 374 us, '1' after 379 us, '0' after 384.4 us, '1' after 389.7 us, '1' after 394.9 us, '0' after 400.1 us, '0' after 405.3 us, '1' after 410.5 us,
                        '0' after 435.7 us, '1' after 440.9 us, '0' after 446.1 us, '0' after 451.3 us, '0' after 456.5 us, '0' after 461.7 us, '1' after 466.9 us, '1' after 472.1 us, '0' after 477.3 us, '1' after 482.5 us;               

Dec : ECHO_Instruction port map (TB_REG_GAIN, TB_REG_DECAY, TB_REG_DELAY, TB_ECHO_UART_RX, TB_Clk);

clock : Clk_Gen port map (TB_Clk);

end Behavior;
		
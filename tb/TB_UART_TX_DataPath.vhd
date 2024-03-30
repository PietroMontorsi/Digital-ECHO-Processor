library ieee;
use ieee.std_logic_1164.all;

entity TB_UART_TX_DataPath is

end TB_UART_TX_DataPath;

architecture Behavior of TB_UART_TX_DataPath is

component CLK_GEN is
	port ( CLK, RST : out std_logic);
end component;

component UART_TX_DataPath is

generic (PISO_N : integer := 10; N : integer := 8);

         port ( CLOCK, FF_LE, FF_RST, PISO_LE, PISO_SE, PISO_SIn, PISO_RST, BaudCNT_CLR, BaudCNT_CE, bitCNT_CLR, bitCNT_CE : in std_logic;
		PISO_START, PISO_STOP : in std_logic;    -- rispettivamente 0 e 1;
		Din : in std_logic_vector ( 7 downto 0 );
		TX, BaudCNT_TC, bitCNT_TC : out std_logic);
end component;


signal W_CLOCK, W_FF_LE, W_FF_RST, W_PISO_LE, W_PISO_SE, W_PISO_SIn, W_PISO_RST, W_BaudCNT_CLR, W_BaudCNT_CE, W_bitCNT_CLR, W_bitCNT_CE : std_logic;
signal W_PISO_START, W_PISO_STOP : std_logic;
signal W_TX, W_BaudCNT_TC, W_bitCNT_TC : std_logic;
signal Data : std_logic_vector( 7 downto 0);

begin

Data <= "01011001";
W_FF_LE <= '1' , '0' after 102 ns;
W_FF_RST <='1', '0' after 5 ns;
W_PISO_LE <='0', '1' after 102 ns, '0' after 107 ns; 
W_PISO_SE <= '0', '1' after 152 ns, '0' after 157 ns, '1' after 202 ns, '0' after 207 ns, '1' after 252 ns, '0' after 257 ns, 
		'1' after 302 ns, '0' after 307 ns, '1' after 352 ns, '0' after 357 ns,'1' after 402 ns, '0' after 407 ns,
		'1' after 452 ns, '0' after 457 ns, '1' after 502 ns, '0' after 507 ns, '1' after 552 ns, '0' after 557 ns,
		'1' after 602 ns, '0' after 607 ns;
W_PISO_SIn <= '1'; 
W_PISO_RST <= '1', '0' after 5 ns;
W_BaudCNT_CLR <= '0', '1' after 102 ns, '0' after 107 ns;
W_BaudCNT_CE <= '0', '1' after 107 ns; 
W_bitCNT_CLR <= '0', '1' after 102 ns, '0' after 107 ns;
W_bitCNT_CE <= '0', '1' after 152 ns, '0' after 157 ns, '1' after 202 ns, '0' after 207 ns, '1' after 252 ns, '0' after 257 ns, 
		'1' after 302 ns, '0' after 307 ns, '1' after 352 ns, '0' after 357 ns,'1' after 402 ns, '0' after 407 ns,
		'1' after 452 ns, '0' after 457 ns, '1' after 502 ns, '0' after 507 ns, '1' after 552 ns, '0' after 557 ns,
		'1' after 602 ns, '0' after 607 ns;
W_PISO_START <= '0'; 
W_PISO_STOP <= '1';



CLK_GEN1 : CLK_GEN port map(
	CLK => W_CLOCK);


DataPath : UART_TX_DataPath port map(
	W_CLOCK, W_FF_LE, W_FF_RST, W_PISO_LE, W_PISO_SE, W_PISO_SIn, W_PISO_RST, W_BaudCNT_CLR, W_BaudCNT_CE, W_bitCNT_CLR, W_bitCNT_CE,
        W_PISO_START, W_PISO_STOP, Data,
	W_TX, W_BaudCNT_TC, W_bitCNT_TC);


end Behavior;
library ieee;
use ieee.std_logic_1164.all;

entity UART is
	port( DataIn : in std_logic_vector ( 7 downto 0);
	      TE, Clk, RX : in std_logic;
	      DataOut : out std_logic_vector ( 7 downto 0);
	      DR, TX : out std_logic);	 
end UART;

architecture Behavior of UART is 

component UART_TX is

generic (PISO_N : integer := 10; N : integer := 8);
         port ( T_E, CLK : in std_logic;
                Data : in std_logic_vector ( N-1 downto 0 );
		T_X: out std_logic);
end component;

component UART_RX is

generic (NCOMP : integer := 8; N : integer := 8);
         port ( R_X, CLK : in std_logic;
                D_R : out std_logic;
		Dout: out std_logic_vector (N-1 downto 0));
end component;

begin

Trasmitter: UART_TX port map (TE, Clk, DataIn, TX);
Reciver: UART_RX port map (RX, Clk, DR, DataOut);


end Behavior; 
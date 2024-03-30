library ieee;
use ieee.std_logic_1164.all;

entity UART_RX_DataPath is

generic (NCOMP : integer := 8; N : integer := 8);

         port ( CLOCK, RX, X8SIPO_SE, X8SIPO_RST, X1SIPO_SE, X1SIPO_RST, SYNCNT_CE, SYNCNT_CLR, bitCNT_CE, bitCNT_CLR : in std_logic;
		COMP_STR, SYNCNT_TC, bitCNT_TC, X8CNT_TC: out std_logic;
		DATAOUT : out std_logic_vector ( N-1 downto 0);
		X8CNT_CLR, X8CNT_CE : in std_logic);

end UART_RX_DataPath;

architecture Behavior of UART_RX_DataPath is 

component UART_SIPO is 
generic  (N : integer := 8);
	port (  SIn, CLK, RST, SE : in std_logic;
		QParall : out std_logic_vector (N-1 downto 0));
end component;

component UART_COMP is
generic ( NCOMP : integer);
	port( IN1, IN2 : in std_logic_vector (NCOMP-1 downto 0);
	      OutCOMP : out std_logic); 
end component;

component UART_VTR is
generic ( N : integer := 3);
	port( bit3in : in std_logic_vector ( 2 downto 0);
	      Dataid: out std_logic);
end component;

component UART_CNT is
generic ( N : integer);
	port( CLR, CE, CLK : in std_logic;
	      CNT : out integer range 0 to N;
	      TC : out std_logic); 
end component;

signal DP_DATAID: std_logic;
signal DP_IN1 : std_logic_vector ( N-1 downto 0);

begin

X8SIPO : UART_SIPO 
	generic map (N => 8)
	port map ( SIn => RX, CLK => CLOCK, RST => X8SIPO_RST, SE => X8SIPO_SE, QParall => DP_IN1);

COMP : UART_COMP 
	generic map (NCOMP => 8)
	port map ( IN1 => DP_IN1, IN2 => "11110000", OutCOMP => COMP_STR);

VTR : UART_VTR 
	generic map (N => 3)
	port map ( bit3in(2 downto 0) => DP_IN1(7 downto 5), Dataid => DP_DATAID);

X1SIPO : UART_SIPO
	generic map (N => 8)
	port map ( SIn => DP_DATAID, CLK => CLOCK, RST => X1SIPO_RST, SE => X1SIPO_SE, QParall => DATAOUT); 

SYNCNT : UART_CNT 
	generic map ( N => 1040) 
	port map ( CLR => SYNCNT_CLR, CE => SYNCNT_CE, CLK => CLOCK, TC => SYNCNT_TC);	

bitCNT : UART_CNT 
	generic map ( N => 9)
	port map ( CLR => bitCNT_CLR, CE => bitCNT_CE, CLK => CLOCK, TC => bitCNT_TC);

X8CNT : UART_CNT 
	generic map ( N => 130)
	port map ( CLR => X8CNT_CLR, CE => X8CNT_CE, CLK => CLOCK, TC => X8CNT_TC);	

end Behavior;
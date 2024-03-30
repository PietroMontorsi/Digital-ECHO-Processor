library ieee;
use ieee.std_logic_1164.all;

entity ECHO_Instruction is

	port( REG_GAIN, REG_DECAY : out std_logic_vector ( 7 downto 0);
	      REG_DELAY : out std_logic_vector ( 15 downto 0 );
	      ECHO_UART_RX, CLK, RESET : in std_logic;
	      ECHO_UART_TX : out std_logic);

end ECHO_Instruction;

architecture Behavior of ECHO_Instruction is

component ECHO_DataPathIst is

generic (N : integer := 8);
      port ( CLOCK, FF_LE, FF_RST, DEC_EN, REG_LE_GAIN, REG_LE_DECAY, REG_LE_DELAY_H, REG_LE_DELAY_L, REG_RST: in std_logic;
		UART_RX : in std_logic;
		UART_DR, DEC_READY, DEC_ERROR, UART_TX : out std_logic;
		Ist : out std_logic_vector (1 downto 0);
		BusGAIN, BusDECAY : out std_logic_vector ( 7 downto 0);
		BusDELAY : out std_logic_vector ( 15 downto 0 ));

end component;

component ECHO_ControlUnitIst is
	 port ( FF_LE, FF_RST, DEC_EN, REG_LE_GAIN, REG_LE_DECAY, REG_LE_DELAY_H, REG_LE_DELAY_L, REG_RST: out std_logic;
		--REG_RST_GAIN, REG_RST_DECAY, REG_RST_DELAY_H, REG_RTS_DELAY_L : in std_logic; 
		CLOCK, RST, UART_DR, DEC_READY, DEC_ERROR : in std_logic;
		Ist : in std_logic_vector (1 downto 0));

end component;

signal W_CLOCK, W_FF_LE, W_FF_RST, W_DEC_EN, W_REG_LE_GAIN, W_REG_LE_DECAY, W_REG_LE_DELAY_H, W_REG_LE_DELAY_L, W_REG_RST : std_logic;
signal W_UART_RX, W_UART_DR, W_DEC_READY, W_DEC_ERROR : std_logic;
signal W_Ist : std_logic_vector (1 downto 0);
--signal W_BusGAIN, W_BusDECAY : std_logic_vector ( 7 downto 0);
--signal W_BusDELAY : std_logic_vector ( 15 downto 0 ); 



begin 

DataPathIst : ECHO_DataPathIst port map(
        CLK, W_FF_LE, W_FF_RST, W_DEC_EN, W_REG_LE_GAIN, W_REG_LE_DECAY, W_REG_LE_DELAY_H, W_REG_LE_DELAY_L, W_REG_RST,
	     ECHO_UART_RX, W_UART_DR, W_DEC_READY, W_DEC_ERROR, ECHO_UART_TX, W_Ist, REG_GAIN, REG_DECAY, REG_DELAY);
	
ControlUnitIst : ECHO_ControlUnitIst port map(
	W_FF_LE, W_FF_RST, W_DEC_EN, W_REG_LE_GAIN, W_REG_LE_DECAY, W_REG_LE_DELAY_H, W_REG_LE_DELAY_L, W_REG_RST,
	CLK, RESET, W_UART_DR, W_DEC_READY, W_DEC_ERROR, W_Ist);


end Behavior;
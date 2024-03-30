library ieee;
use ieee.std_logic_1164.all;

entity ECHO_DataPathIst is

generic (N : integer := 8);
      port ( CLOCK, FF_LE, FF_RST, DEC_EN, REG_LE_GAIN, REG_LE_DECAY, REG_LE_DELAY_H, REG_LE_DELAY_L, REG_RST: in std_logic;
		--REG_RST_GAIN, REG_RST_DECAY, REG_RST_DELAY_H, REG_RTS_DELAY_L : in std_logic; 
		UART_RX : in std_logic;
		UART_DR, DEC_READY, DEC_ERROR, UART_TX : out std_logic;
		Ist : out std_logic_vector (1 downto 0);
		BusGAIN, BusDECAY : out std_logic_vector ( 7 downto 0);
		BusDELAY : out std_logic_vector ( 15 downto 0 ));

end ECHO_DataPathIst;

architecture Behavior of ECHO_DataPathIst is 

component UART is 
        port( DataIn : in std_logic_vector ( 7 downto 0);
	      TE, Clk, RX : in std_logic;
	      DataOut : out std_logic_vector ( 7 downto 0);
	      DR, TX : out std_logic);	
end component;

component Reg is
generic  (N : integer);
	port (  D : in std_logic_vector (N-1 downto 0);
		CLK, RST, LE : in std_logic;
		Q : out std_logic_vector(N-1 downto 0));
end component;

component Decodificatore is
        port (  AsciIn : in std_logic_vector(7 downto 0);
		HexOut : out std_logic_vector(7 downto 0);
		En: in std_logic;
		Ready, Error : out std_logic); 
end component;

component Ric_Ist is
        port (  ByteIn : in std_logic_vector(7 downto 0);
		Instruction : out std_logic_vector(1 downto 0)); 
end component;

signal BusASCII, BusToRegIst : std_logic_vector (7 downto 0);
signal BusDataToReg : std_logic_vector (7 downto 0);
signal UART_DataIn : std_logic_vector ( 7 downto 0);
signal UART_TE : std_logic;

begin

RS232 : UART
	port map ( 
	  Clk => CLOCK, RX => UART_RX, DR => UART_DR, DataOut =>  BusDataToReg, TE => UART_TE, DataIn => UART_DataIn, TX => UART_TX);

Riconoscitore : Ric_Ist
	port map (BusASCII, Ist);

Registro : Reg 
	generic map (N => 8)
	port map ( D(7) =>  BusDataToReg(0), D(6) =>  BusDataToReg(1), D(5) =>  BusDataToReg(2), D(4) =>  BusDataToReg(3),
		   D(3) =>  BusDataToReg(4), D(2) =>  BusDataToReg(5), D(1) =>  BusDataToReg(6), D(0) =>  BusDataToReg(7),  
		   CLK => CLOCK, RST => FF_RST, LE => FF_LE, Q => BusASCII);

Dec : Decodificatore
	port map ( AsciIn => BusASCII, HexOut => BusToRegIst, En => DEC_EN, Ready => DEC_READY, Error => DEC_ERROR); 

RegPer : Reg 
	generic map ( N => 8 )
	port map ( D => BusToRegIst, CLK => CLOCK, RST => REG_RST, LE => REG_LE_GAIN, Q => BusGAIN);	

RegMen : Reg
	generic map ( N => 8 )
	port map (  D => BusToRegIst, CLK => CLOCK, RST => REG_RST, LE => REG_LE_DECAY, Q => BusDECAY );

RegTH : Reg
	generic map ( N => 8)
	port map (  D => BusToRegIst, CLK => CLOCK, RST => REG_RST, LE => REG_LE_DELAY_H, Q => BusDELAY(15  downto 8));

RegTL : Reg
	generic map ( N => 8)
	port map (  D => BusToRegIst, CLK => CLOCK, RST => REG_RST, LE => REG_LE_DELAY_L, Q => BusDELAY(7  downto 0));	

end Behavior;

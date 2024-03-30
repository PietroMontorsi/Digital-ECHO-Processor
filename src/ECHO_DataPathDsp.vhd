library ieee;
use ieee.std_logic_1164.all;
use ieee.fixed_pkg.all;


entity ECHO_DataPathDsp is
	port (  Input, Decay, Gain : in std_logic_vector(7 downto 0);
		Delay : in std_logic_vector(15 downto 0);
		CLOCK : in std_logic;
		Reg_RST, RegIn_LE, RegADD_LE, RegRHU_LE, RAM_RST, RAM_WRE, RAM_RDE, RegRAM_LE, MUX_S : in std_logic;  
		Output : out std_logic_vector(7 downto 0));

end ECHO_DataPathDsp;

architecture Behavior of ECHO_DataPathDsp is

    
component RegUfixed is 
generic  (N : integer := 8);
	port (  D : in ufixed(-1 downto -N);
		CLK, RST, LE : in std_logic;
		Q : out ufixed(-1 downto -N));
end component;


component Adder is
	port (  Adder_In1, Adder_In2 : in ufixed(-1 downto -8);
		Adder_Out : out ufixed( -1 DOWNTO -8));
end component;


component CircularBufferRAM is
generic( Word : integer := 8;
            L : integer := 2**16);  

port( CLK, RST, WRE, RDE : in  std_logic;
      DataIn : in  ufixed(-1 downto -Word);
      DelayIn : in std_logic_vector(15 downto 0);
      DataOut : out ufixed(-1 downto -Word));
end component;


component MUX2to1 is
port ( 
	Mux_In1, Mux_In2 : in std_logic_vector(7 downto 0);
	S : in std_logic;
	Mux_Out : out ufixed(-1 downto -8));
end component;


component Multiplier is
	port (  Multiplier_In1, Multiplier_In2 : in ufixed(-1 downto -8);
		Multiplier_Out : out ufixed(-1 DOWNTO -16));
end component;

component RoundingHU is
	port (  Rounding_In : in ufixed(-1 downto -16);
		Rounding_Out : out ufixed(-1 downto -8));
end component;

signal InUfixed, RegIntoAdd, RegRHUtoAdd, ADDtoReg, RAMtoRegMul, RegtoMul, MuxtoMul, OutUfixed, RHUtoReg : ufixed (-1 downto -8);
signal BUSMulOut : ufixed (-1 downto -16);


begin

InUfixed <= to_ufixed(Input,-1,-8);

RegIn : RegUfixed port map(InUfixed, CLOCK, Reg_RST, RegIn_LE, RegIntoAdd); 
RegRHU : RegUfixed port map(RHUtoReg, CLOCK, Reg_RST, RegRHU_LE, RegRHUtoAdd);
Rounder: RoundingHU port map (BUSMulOut, RHUtoReg);
Add : Adder port map(RegIntoAdd, RegRHUtoAdd, ADDtoReg);
RegADD : RegUfixed port map(ADDtoReg, CLOCK, Reg_RST, RegADD_LE, OutUfixed);
RAM : CircularBufferRAM port map(CLOCK, RAM_RST, RAM_WRE, RAM_RDE, OutUfixed, Delay, RAMtoRegMul);
RegRAM : RegUfixed port map(RAMtoRegMul, CLOCK, Reg_RST, RegRAM_LE, RegtoMul); 
Mux : Mux2to1 port map(Decay, Gain, Mux_S,  MuxtoMul);
Mul : Multiplier port map(RegtoMul, MuxtoMul, BUSMulOut); 

Output <= to_slv(OutUfixed);

end Behavior;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.fixed_pkg.all;

entity CircularBufferRAM is

generic( Word : integer := 8;
            L : integer := 2**16);  

port( CLK, RST, WRE, RDE : in  std_logic;
      DataIn : in  ufixed(-1 downto -Word);
      DelayIn : in std_logic_vector(15 downto 0);
      DataOut : out ufixed(-1 downto -Word));

end CircularBufferRAM;

architecture Behavior of CircularBufferRAM is

type MEM is array (L-1 downto 0) of ufixed(-1 downto -Word);
signal Ram_Block : MEM;

signal wr_address         : integer ;
signal rd_address         : integer ;
signal Delay              : integer range 0 to 2**16;
 
--signal r_enable_read     : std_logic;


begin

Delay <= to_integer(unsigned(DelayIn));


Scrittura : process (CLK)

variable tmp_wr_address : integer;

begin


  if ( RST = '1') then

    tmp_wr_address := 0;

   elsif ( CLK'event and CLK = '1' ) then

    if( WRE = '1' ) then 

      if( tmp_wr_address < L-1 ) then
		
		  tmp_wr_address := wr_address;

        tmp_wr_address := tmp_wr_address + 1;

      else
		
		  tmp_wr_address := wr_address;

        tmp_wr_address := 0;

      end if;   

        Ram_Block(tmp_wr_address) <= DataIn;

    end if;
  end if;

  wr_address <= tmp_wr_address;

end process Scrittura;

Lettura : process (clk)

variable tmp_rd_address : integer;

begin

tmp_rd_address := rd_address;

  --if ( RST = '1') then

    --tmp_rd_address := 0;

  if ( CLK'event and CLK = '1' ) then

    if( RDE = '1' ) then

        if( wr_address - Delay  < 0 ) then

          tmp_rd_address  := (wr_address - Delay + L);

        else

          tmp_rd_address := (wr_address - Delay);

        end if;
 
         DataOut <= Ram_Block(tmp_rd_address) ; 
      end if;
    end if;
  
rd_address <= tmp_rd_address;

end process Lettura;


end Behavior;

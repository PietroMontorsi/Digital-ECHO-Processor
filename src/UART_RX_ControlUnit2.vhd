library ieee;
use ieee.std_logic_1164.all;

entity UART_RX_ControlUnit2 is
	port (  X8CNT_TC, CLOCK, RST : in std_logic;
		     X8SIPO_SE, X8CNT_CLR, X8CNT_EN: out std_logic);
              

end UART_RX_ControlUnit2;

architecture Behavior of UART_RX_ControlUnit2 is



type State_Type is (Reset, IDLE, ST1);

signal PresentState : State_Type; 

begin

StateUpdating : process (CLOCK, RST) is
begin

if RST = '1' then 
  PresentState <= RESET;
elsif CLOCK'event and CLOCK = '1' then

case PresentState is

  when RESET => PresentState <= IDLE;
  
  when IDLE => 
	if ( X8CNT_TC = '1') then
	  PresentState <= ST1;
	else
	  PresentState <= IDLE;
	end if;

  when ST1 => PresentState <= IDLE;

  when others => PresentState <= RESET;
end case;
end if;

end process StateUpdating;

OutputEvaluation : process (PresentState) is
begin


X8CNT_EN <= '1';
X8SIPO_SE <= '0';
X8CNT_CLR <= '0'; 

case PresentState is 

  when RESET =>
     
     X8CNT_CLR <= '1'; 
    
  when IDLE =>

  when ST1 =>

     X8SIPO_SE <= '1';    

end case;

end process;

end Behavior;


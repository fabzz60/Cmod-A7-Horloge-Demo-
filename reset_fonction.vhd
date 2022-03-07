
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reset_fonction is
    Port ( BTN0 : in STD_LOGIC;
           BTN1 : in STD_LOGIC;
           reset : out STD_LOGIC);
end reset_fonction;

architecture Behavioral of reset_fonction is

begin
reset <= BTN0 and BTN1;

end Behavioral;

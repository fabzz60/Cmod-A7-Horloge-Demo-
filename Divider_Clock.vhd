
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity diviseur_horloge_numerique is
    Port ( clk : in  STD_LOGIC;  --12MHz
           clk_divide : out  STD_LOGIC;  --1KHz
           reset : in  STD_LOGIC);
end diviseur_horloge_numerique;

architecture Behavioral of diviseur_horloge_numerique is

SIGNAL	count_1000Hz : INTEGER range 0 to 12000 := 0;
SIGNAL  clock_1000Hz_int:  STD_LOGIC :='0';
CONSTANT M1: INTEGER := 12000; --1000Hz
begin

--Divise par 100000
PROCESS(clk,reset)
BEGIN
if reset='1' then  
   count_1000Hz <= 0;
ELSIF rising_edge(clk) then
      IF count_1000Hz <= M1-1 THEN  --Divise par 100000  FOUT = 1000Hz synchro affichage
      count_1000Hz <= count_1000Hz + 1;
      ELSE
      count_1000Hz <= 0;
      END IF;
      --à la moitié du comptage on change la valeur  (rapport cyclique = 1/2)
	  IF count_1000Hz <= M1/2 THEN
      clock_1000Hz_int <= '1';
      ELSE
      clock_1000Hz_int <= '0';
      end if;
END IF;
END PROCESS;
CLK_divide <= clock_1000Hz_int;

end Behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decodage is

Port ( sel : in  STD_LOGIC_VECTOR (2 downto 0);
       afficheur_0 : out  STD_LOGIC;
       afficheur_1 : out  STD_LOGIC;
       afficheur_2 : out  STD_LOGIC;
       afficheur_3 : out  STD_LOGIC;
       afficheur_4 : out  STD_LOGIC;
       afficheur_5 : out  STD_LOGIC);
       		 
end decodage;

architecture Behavioral of decodage is

begin


process(Sel)
begin
afficheur_0 <='1'; afficheur_1 <='1'; afficheur_2 <='1'; afficheur_3 <='1';afficheur_4 <='1';afficheur_5 <='1';

case sel is
      when "000"  =>afficheur_0 <='0'; 
	  when "001"  =>afficheur_1 <='0';
	  when "010"  =>afficheur_2 <='0';  
	  when "011"  =>afficheur_3 <='0'; 
	  when "100"  =>afficheur_4 <='0'; 
	  when "101"  =>afficheur_5 <='0'; 
     when others => null;
end case;
end process;


end Behavioral;




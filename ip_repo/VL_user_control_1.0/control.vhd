----------------------------------------------------
--                Vladi & Adi                     --
--           TAU EE Senior year project           --
--                                                --
--************************************************--
--*************** User Interface *****************--
--************************************************--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity control is
    Port ( Switches : in STD_LOGIC_VECTOR (0 to 7); --left to right
           clk_12hz : in std_logic;
           clk_1hz5 : in std_logic;
           Leds : out STD_LOGIC_VECTOR (0 to 7) := "10000000"; --left to right
           butn_in : in STD_LOGIC_VECTOR (0 to 2); -- left to right- L,C,R
           en : out STD_LOGIC_VECTOR (0 to 3):= "0000";
           options0 : out STD_LOGIC_VECTOR (0 to 3);
           options1 : out STD_LOGIC_VECTOR (0 to 3);
           options2 : out STD_LOGIC_VECTOR (0 to 3);
           options3 : out STD_LOGIC_VECTOR (0 to 3)
           );
end control;

architecture Behavioral of control is

signal ok : std_logic := '0';
signal butn_i : STD_LOGIC_VECTOR (0 to 2);
signal sele : integer :=0;

begin

butn_i <= butn_in;

ena:process(Switches) --enable
begin
if Switches(0)='1' then En(0) <= '1'; end if;
if Switches(0)='0' then En(0) <= '0'; end if;
if Switches(1)='1' then En(1) <= '1'; end if;
if Switches(1)='0' then En(1) <= '0'; end if;       
if Switches(2)='1' then En(2) <= '1'; end if;
if Switches(2)='0' then En(2) <= '0'; end if;
if Switches(3)='1' then En(3) <= '1'; end if;
if Switches(3)='0' then En(3) <= '0'; end if;
end process;    

sele_p:process(clk_12hz) --scroll between effects
begin
if rising_edge(clk_12hz)  then 
if (ok = '0') then
if (sele=0 and butn_i="001") then  sele <= 1;  end if;
if (sele=1 and butn_i="100") then  sele <= 0;  end if;
if (sele=1 and butn_i="001") then  sele <= 2;  end if;
if (sele=2 and butn_i="100") then  sele <= 1;  end if;
if (sele=2 and butn_i="001") then  sele <= 3;  end if;
if (sele=3 and butn_i="100") then  sele <= 2;  end if;
end if;  
end if;
end process;

process(clk_12hz, sele,butn_i) --scroll between effects
begin
if (ok = '0') then --buttons L,R control effect selection
if (sele=0) then  Leds <= "10000000"; end if; 
if (sele=1) then  Leds <= "01000000"; end if; 
if (sele=2) then  Leds <= "00100000"; end if; 
if (sele=3) then  Leds <= "00010000"; end if; 
end if;
end process;

process(clk_12hz, sele, butn_i) -- change effect parameters
begin   
if (ok = '1') then --buttons L,R control selected effect
if (sele=0) then  options0 <= Switches(4 to 7); end if; 
if (sele=1) then  options1 <= Switches(4 to 7); end if; 
if (sele=2) then  options2 <= Switches(4 to 7); end if; 
if (sele=3) then  options3 <= Switches(4 to 7); end if; 

end if;
end process;
 
o:process(butn_i, clk_1hz5)
begin
if rising_edge(clk_1hz5)  then 
    if butn_i="010" then
        if (ok='0') then 
        ok <= '1'; --control effect itself
        end if;
        if (ok='1') then
        ok <= '0'; --control effect selection
        end if;
    end if; 
end if;
end process;

end Behavioral;

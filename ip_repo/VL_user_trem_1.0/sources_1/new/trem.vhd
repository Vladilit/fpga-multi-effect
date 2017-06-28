----------------------------------------------------
--                Vladi & Adi                     --
--           TAU EE Senior year project           --
--                                                --
--************************************************--
--****************** Trem ************************--
--************************************************--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity trem is
    Port ( x : in STD_LOGIC_VECTOR(31 downto 0);
           y : out STD_LOGIC_VECTOR(31 downto 0);
           clk_48 : in std_logic;
           clk_190 : in std_logic;
           clk_380 : in std_logic;
           clk_95 : in std_logic;
           clk_48hz : in std_logic; 
           options : in STD_LOGIC_VECTOR(0 to 3);                
           en : in STD_LOGIC_VECTOR(0 to 3)
           );
end trem;

architecture Behavioral of trem is

signal data_o : STD_LOGIC_VECTOR(31 downto 0);
signal data_i : STD_LOGIC_VECTOR(31 downto 0);
signal temp_vec_64 : STD_LOGIC_VECTOR(63 downto 0);

--*************triangular wave signals*************************
signal count_int: integer ;
signal count_int2: integer;
signal count_int4: integer ;
signal count_int6: integer ;
signal direction: std_logic := '0';
signal direction_s2: std_logic := '0';
signal direction_s4: std_logic := '0';
signal direction_s6: std_logic := '0';
--**********************************************

begin

--*************generate various triangular waves*************************
process(count_int) --tremolo frequency - 1.6hz
begin
    if (count_int=30) then
        direction <= '1';
    end if;
    if (count_int=1) then
        direction <= '0';
    end if;
end process;
dir:process(direction, clk_95)
begin
if rising_edge(clk_95) then 
    if (direction='0') then
    count_int <= count_int+1;
    end if;
    if (direction='1') then
    count_int <= count_int-1;
end if;
end if;
end process;

process(count_int2) --tremolo frequency - 3.2 hz
begin
    if (count_int2=30) then
        direction_s2 <= '1';
    end if;
    if (count_int2=1) then
        direction_s2 <= '0';
    end if;
end process;
dir2:process(direction_s2, clk_190)
begin
if rising_edge(clk_190) then 
    if (direction_s2='0') then
    count_int2 <= count_int2+1;
    end if;
    if (direction_s2='1') then
    count_int2 <= count_int2-1;
end if;
end if;
end process;

process(count_int4) --tremolo frequency - 6.35hz
begin
    if (count_int4=30) then 
        direction_s4 <= '1';
    end if;
    if (count_int4=1) then
        direction_s4 <= '0';
    end if;
end process;
dir4:process(direction_s4, clk_380)
begin
if rising_edge(clk_380) then 
    if (direction_s4='0') then
    count_int4 <= count_int4+1;
    end if;
    if (direction_s4='1') then
    count_int4 <= count_int4-1;
end if;
end if;
end process;

process(count_int6) --tremolo frequency - 0.8hz
begin
    if (count_int6=30) then
        direction_s6 <= '1';
    end if;
    if (count_int6=1) then
        direction_s6 <= '0';
    end if;
end process;
dir6:process(direction_s6, clk_48hz)
begin
if rising_edge(clk_48hz) then 
    if (direction_s6='0') then
    count_int6 <= count_int6+1;
    end if;
    if (direction_s6='1') then
    count_int6 <= count_int6-1;
end if;
end if;
end process;
--***********************************************

process (clk_48, options)
begin
if en(2)= '1' then
if rising_edge(clk_48) then 

if options="1000" then --tremolo frequency -  1.6hz
temp_vec_64 <= std_logic_vector((signed(x))*count_int); --yes
y <= "00000000" & std_logic_vector(shift_right(signed(temp_vec_64(23 downto 0)),4));   
end if;

if options="0100" then --tremolo frequency -  3.2 hz
temp_vec_64 <= std_logic_vector((signed(x))*count_int2); 
y <= "00000000" & std_logic_vector(shift_right(signed(temp_vec_64(23 downto 0)),4));  
end if;
                                                                                 
if options="0010" then --tremolo frequency - 6.35hz
temp_vec_64 <= std_logic_vector((signed(x))*count_int4);
y <= "00000000" & std_logic_vector(shift_right(signed(temp_vec_64(23 downto 0)),4)); 
end if;

if options="0001" then --tremolo frequency - 0.8hz
temp_vec_64 <= std_logic_vector((signed(x))*count_int6);
y <= "00000000" & std_logic_vector(shift_right(signed(temp_vec_64(23 downto 0)),4));  
end if;  
    
end if;  
else
y<=x;                 
end if;
end process;
end Behavioral;

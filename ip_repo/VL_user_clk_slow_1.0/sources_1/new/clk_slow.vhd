----------------------------------------------------
--                Vladi & Adi                     --
--           TAU EE Senior year project           --
--                                                --
--************************************************--
--************* Clocks generator *****************--
--************************************************--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_slow is
    Port ( clk_in : in STD_LOGIC;
           clk_190hz : out STD_LOGIC;
           clk_380hz : out STD_LOGIC;
           clk_95hz : out STD_LOGIC;
           clk_48hz : out STD_LOGIC;
           clk_12hz : out STD_LOGIC;
           clk1hz5 : out STD_LOGIC
--           clk_1k5hz : out STD_LOGIC;
--           clk3k : out STD_LOGIC;
--           clk_762hz : out STD_LOGIC;           
--           clk_24khz : out STD_LOGIC                      
           );
end clk_slow;

architecture Behavioral of clk_slow is

signal clk_sig: std_logic;
signal clk_cntr : std_logic_vector(25 downto 0) := (others => '0');

begin

count: process(clk_in)
begin
    if rising_edge(clk_in) then
        clk_cntr <= std_logic_vector(unsigned(clk_cntr)+1);       
    end if;
end process;

--****** for control block *****
clk_12hz <= clk_cntr(21);
clk1hz5 <= clk_cntr(24);
--******************************

--****** for tremolo  **********
clk_380hz <= clk_cntr(16);
clk_190hz <= clk_cntr(17);
clk_95hz <= clk_cntr(18);
clk_48hz <= clk_cntr(19);
--******************************

--**** other clocks *****
--clk_24khz <= clk_cntr(10);
--clk3k <= clk_cntr(13);
--clk_1k5hz <= clk_cntr(14);
--clk_762hz <= clk_cntr(15);
end Behavioral;
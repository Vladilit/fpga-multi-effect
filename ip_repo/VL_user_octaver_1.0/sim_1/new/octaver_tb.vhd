
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;
use ieee.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity octaver_tb is
end octaver_tb;

architecture Behavioral of octaver_tb is
component  octaver is
    Port ( x : in STD_LOGIC_VECTOR(31 downto 0);
           y : out STD_LOGIC_VECTOR(31 downto 0);
           clk_48: in std_logic :='1';
           clk_24: in std_logic;
           options : in STD_LOGIC_VECTOR(0 to 3);           
           en : in STD_LOGIC_VECTOR(0 to 3);
           addr1_temp0 : out std_logic_vector (31 downto 0);
           addr2_temp1 : out std_logic_vector (31 downto 0)
           );
end component;

    signal x : STD_LOGIC_VECTOR(31 downto 0) := "00000000000000000000000000000000";
    signal y :  STD_LOGIC_VECTOR(31 downto 0);
    signal clk_48: std_logic := '1';
    signal clk_24:  std_logic;
    signal options :  STD_LOGIC_VECTOR(0 to 3) := "0000";
    signal en : STD_LOGIC_VECTOR(0 to 3) := "0100";
    signal addr1_temp0 : std_logic_vector (31 downto 0);
    signal addr2_temp1 :  std_logic_vector (31 downto 0);
--    signal del_temp2 :  std_logic_vector (31 downto 0);
--    signal del_temp_last :  std_logic_vector (31 downto 0);
    constant clock_period: time := 20 us;
    signal rand_num : integer := 0;
           
begin

uut: octaver
port map(
x => x,
y => y,
clk_48 => clk_48,
clk_24 => clk_24,
options => options,
en => en
--addr1_temp0 => addr1_temp0,
--addr2_temp1 => addr2_temp1
);

clk_process: process
 begin
    clk_48 <= '1';
    wait for clock_period/2;
    clk_48 <= '0';
    wait for clock_period/2;
 end process;

clk2_process: process
 begin
    clk_24 <= '1';
    wait for clock_period;
    clk_24 <= '0';
    wait for clock_period;
 end process;
  
process
  begin
     x <= std_logic_vector(signed(x)+1);
     wait for clock_period;
  end process;
  
--random_num: process
--       variable seed1, seed2: positive;               -- seed values for random generator
--       variable rand: real;   -- random real-number value in range 0 to 1.0  
--       variable range_of_rand : real := 150000.0;    -- the range of random values created will be 0 to +30000.
--   begin
--       uniform(seed1, seed2, rand);   -- generate random number
--       rand_num <= integer(rand*range_of_rand);  -- rescale to 0..1000, convert integer part 
--       x <= std_logic_vector(to_unsigned(rand_num, 32));
--        wait for 0.000020 sec;
--   end process;

end Behavioral;

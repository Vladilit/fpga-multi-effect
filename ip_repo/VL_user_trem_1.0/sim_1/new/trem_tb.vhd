
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trem_tb is
end trem_tb;

architecture Behavioral of trem_tb is
  component trem
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
end component;

  signal x: STD_LOGIC_VECTOR(31 downto 0);
  signal y: STD_LOGIC_VECTOR(31 downto 0);
  signal clk_48: std_logic :='0';
  signal clk_190: std_logic;
  signal clk_380: std_logic :='0';
  signal clk_95: std_logic;
  signal clk_48hz: std_logic;
  signal options: STD_LOGIC_VECTOR(0 to 3) := "0010";
  signal en: STD_LOGIC_VECTOR(0 to 3) := "0010";   

  constant clock_period: time := 20 us;
  constant clock_period380: time := 2.63 ms;
  signal rand_num : integer := 0;
    
begin


  uut: trem port map ( x        => x,
                       y        => y,
                       clk_48   => clk_48,
                       clk_190  => clk_190,
                       clk_380  => clk_380,
                       clk_95   => clk_95,
                       clk_48hz => clk_48hz,
                       options  => options,
                       en       => en );

clk_process: process
 begin
    clk_48 <= '1';
    wait for clock_period/2;
    clk_48 <= '0';
    wait for clock_period/2;
 end process;
 
clk380_process: process
  begin
     clk_380 <= '1';
     wait for clock_period380/2;
     clk_380 <= '0';
     wait for clock_period380/2;
  end process;
 

random_num: process
       variable seed1, seed2: positive;               -- seed values for random generator
       variable rand: real;   -- random real-number value in range 0 to 1.0  
       variable range_of_rand : real := 150000.0;    -- the range of random values created will be 0 to +30000.
   begin
       uniform(seed1, seed2, rand);   -- generate random number
       rand_num <= integer(rand*range_of_rand);  -- rescale to 0..1000, convert integer part 
       x <= std_logic_vector(to_unsigned(rand_num, 32));
        wait for 0.000020 sec;
   end process;

end Behavioral;

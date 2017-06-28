library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity clk_slow_tb is
end;

architecture bench of clk_slow_tb is

  component clk_slow
      Port ( clk_in : in STD_LOGIC;
          clk_190hz : out STD_LOGIC;
          clk_380hz : out STD_LOGIC;
          clk_95hz : out STD_LOGIC;
          clk_48hz : out STD_LOGIC;
          clk_12hz : out STD_LOGIC;
          clk1hz5 : out STD_LOGIC
             );
  end component;

  signal clk_in: STD_LOGIC;
  signal clk_190hz :  STD_LOGIC;
  signal clk_380hz :  STD_LOGIC;
  signal clk_95hz :  STD_LOGIC;
  signal clk_48hz :  STD_LOGIC;
  signal clk_12hz :  STD_LOGIC;
  signal clk1hz5 :  STD_LOGIC;


  constant clock_period: time := 20 ns; --50Mhz

begin

  uut: clk_slow port map ( clk_in  => clk_in,
                         clk_190hz => clk_190hz,
                         clk_380hz => clk_380hz,
                         clk_95hz => clk_95hz,
                         clk_48hz => clk_48hz,
                         clk_12hz => clk_12hz,
                         clk1hz5 => clk1hz5
                            );

clk_process: process
 begin
    clk_in <= '1';
    wait for clock_period/2;
    clk_in <= '0';
    wait for clock_period/2;
 end process;
 
 

end;
library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity control_tb is
end;

architecture bench of control_tb is

  component control
      Port ( Switches : in STD_LOGIC_VECTOR (0 to 7);
          clk_12hz : in std_logic;
          clk_1hz5 : in std_logic;
          Leds : out STD_LOGIC_VECTOR (0 to 7) := "10000000"; --left to right
          butn_in : in STD_LOGIC_VECTOR (0 to 2);
          en : out STD_LOGIC_VECTOR (0 to 3):= "0000";
          options0 : out STD_LOGIC_VECTOR (0 to 3);
          options1 : out STD_LOGIC_VECTOR (0 to 3);
          options2 : out STD_LOGIC_VECTOR (0 to 3);
          options3 : out STD_LOGIC_VECTOR (0 to 3)
             );
  end component;

  signal Switches: STD_LOGIC_VECTOR (0 to 7);
  signal clk_12hz :  std_logic;
  signal clk_1hz5 :  std_logic;
  signal Leds :  STD_LOGIC_VECTOR (0 to 7) := "10000000"; --left to right
  signal butn_in :  STD_LOGIC_VECTOR (0 to 2);
  signal en :  STD_LOGIC_VECTOR (0 to 3):= "0000";
  signal options0 :  STD_LOGIC_VECTOR (0 to 3);
  signal options1 :  STD_LOGIC_VECTOR (0 to 3);
  signal options2 :  STD_LOGIC_VECTOR (0 to 3);
  signal options3 :  STD_LOGIC_VECTOR (0 to 3);

  constant clock_period: time := 83 ms;
  constant clock_period2: time := 0.66 sec;
  
begin


  uut: control port map ( Switches => Switches,
                          clk_12hz => clk_12hz,
                          clk_1hz5 => clk_1hz5,
                          Leds     => Leds,
                          butn_in  => butn_in,
                          en       => en,
                          options0 => options0,
                          options1 => options1,
                          options2 => options2,
                          options3 => options3 );


clk_process: process
 begin
    clk_12hz <= '1';
    wait for clock_period/2;
    clk_12hz <= '0';
    wait for clock_period/2;
 end process;
 

clk2_process: process
  begin
     clk_1hz5 <= '1';
     wait for clock_period2/2;
     clk_1hz5 <= '0';
     wait for clock_period2/2;
  end process;
  
  stimulus: process
  begin
  
butn_in <= "001";
  wait for 100ms;
  butn_in <= "00000";
  wait for 50ms;
  
  butn_in <= "001";
  wait for 200ms;
  butn_in <= "00000";
  wait for 50ms;
  
--  butn_in <= "00100";
--  wait for 200ms;
--  butn_in <= "00000";
--  wait for 100ms;
  
--  butn_in <= "00010";
--  wait for 200ms;
--  butn_in <= "00000";
--  wait for 100ms;

--butn_in <= "00001";
--  wait for 100ms;
--  butn_in <= "00000";
--  wait for 50ms;
  
--  butn_in <= "01000";
--  wait for 200ms;
--  butn_in <= "00000";
--  wait for 50ms;
  
--  butn_in <= "00100";
--  wait for 200ms;
--  butn_in <= "00000";
--  wait for 100ms;
  
--  butn_in <= "00010";
--  wait for 200ms;
--  butn_in <= "00000";
--  wait for 100ms;



    wait;
  end process;

end;
  
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/06/2017 12:37:23 PM
-- Design Name: 
-- Module Name: dist_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


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

entity Distortion_tb is
--  Port ( );
end Distortion_tb;

architecture Behavioral of Distortion_tb is

  component Distortion
      Port ( x : in STD_LOGIC_VECTOR(31 downto 0);
             y : out STD_LOGIC_VECTOR(31 downto 0);
             clk_48: in std_logic;
             options : in STD_LOGIC_VECTOR(0 to 3);
             en : in STD_LOGIC_VECTOR(0 to 3)
         );
  end component;

  signal x: STD_LOGIC_VECTOR(31 downto 0);
  signal y: STD_LOGIC_VECTOR(31 downto 0);
  signal clk_48: std_logic;
  signal options: STD_LOGIC_VECTOR(0 to 3):="1000";
  signal en: STD_LOGIC_VECTOR(0 to 3):="1000";

    constant clock_period: time := 20 us;
    signal rand_num : integer := 0;
    
    

begin


  uut: Distortion port map ( x       => x,
                       y       => y,
                       clk_48  => clk_48,
                       options => options,
                       en      => en );

clk_process: process
 begin
    clk_48 <= '1';
    wait for clock_period/2;
    clk_48 <= '0';
    wait for clock_period/2;
 end process;
 
random_num: process
       variable seed1, seed2: positive;               -- seed values for random generator
       variable rand: real;   -- random real-number value in range 0 to 1.0  
       variable range_of_rand : real := 500000.0;    -- the range of random values created will be 0 to +30000.
   begin
       uniform(seed1, seed2, rand);   -- generate random number
       rand_num <= integer(rand*range_of_rand);  -- rescale to 0..1000, convert integer part 
       x <= std_logic_vector(to_unsigned(rand_num, 32));
        wait for 0.000020 sec;
   end process;

end Behavioral;

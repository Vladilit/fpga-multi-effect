library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MCLK_gen is
    Port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC);
end MCLK_gen;

architecture Behavioral of MCLK_gen is

signal clk_sig: std_logic;
 
begin

divide_by_2: process(clk_in)
begin
    if rising_edge(clk_in) then
        clk_sig <= not clk_sig;       
    end if;
end process;
clk_out <= clk_sig;

end Behavioral;
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity bram is
generic (
         T: integer := 20000;
         B: integer := 15 --15 bits for 20,000 memory places
         );
    
port (clk : in std_logic;
we : in std_logic;
addr1 : in std_logic_vector(B-1 downto 0);
addr2 : in std_logic_vector(B-1 downto 0);
di : in std_logic_vector(31 downto 0); --32 bit word
do1 : out std_logic_vector(31 downto 0);
do2 : out std_logic_vector(31 downto 0));

end bram;

architecture arch of bram is

type ram_type is array (0 to T-1) of std_logic_vector (31 downto 0);
signal RAM : ram_type:= (T-1 downto 0 => x"00000000"); --define and initialize RAM

begin

process (clk)
begin
    if rising_edge(clk) then
    if we = '1' then
    RAM(conv_integer(addr1)) <= di;
    end if;
    do1 <= RAM(conv_integer(addr1));
    end if;
end process;

process (clk)
    begin
    if rising_edge(clk) then
    do2 <= RAM(conv_integer(addr2));
    end if;
end process;

end arch;
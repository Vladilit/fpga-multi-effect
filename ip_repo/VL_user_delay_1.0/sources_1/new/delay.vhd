----------------------------------------------------
--                Vladi & Adi                     --
--           TAU EE Senior year project           --
--                                                --
--************************************************--
--****************** Delay ***********************--
--************************************************--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity delay is
generic (
         T: integer := 20000;
         B: integer := 15 --15 bits for 20,000 memory places
         );   
    Port ( x : in STD_LOGIC_VECTOR(31 downto 0);
           y : out STD_LOGIC_VECTOR(31 downto 0);
           clk_48: in std_logic;
           options : in STD_LOGIC_VECTOR(0 to 3);                
           en : in STD_LOGIC_VECTOR(0 to 3)
           );
end delay;

architecture Behavioral of delay is

signal y_temp_s : signed(31 downto 0):= x"00000000";

--triangular wave parameters
signal direction: std_logic := '0';
signal count: integer := 5;

signal i : std_logic_vector (B-1 downto 0) := "000000000000000";
signal max_delay : integer := T-1;

--********************** BRAM signals
signal  we :  std_logic := '1';
signal  addr1 :  std_logic_vector(B-1 downto 0) := "000000000000000";
signal  addr2 :  std_logic_vector(B-1 downto 0):= "000000000000000";
signal  data_in :  std_logic_vector(31 downto 0); --32 bit word
signal  data_out1 :  std_logic_vector(31 downto 0);
signal  data_out2 :  std_logic_vector(31 downto 0);
--*************************

	component bram is
		generic (
        T: integer := 20000;
        B: integer := 15 --15 bits for 20,000 memory places
		);
		port (
        CLK : in std_logic;
        WE : in std_logic;
        ADDR1 : in std_logic_vector(B-1 downto 0);
        ADDR2 : in std_logic_vector(B-1 downto 0);
        DI : in std_logic_vector(31 downto 0); --32 bit word
        DO1 : out std_logic_vector(31 downto 0);
        DO2 : out std_logic_vector(31 downto 0)
		);
	end component bram;

	component bram_d_allpass is
		generic (
        T: integer := 20000;
        B: integer := 15 --15 bits for 20,000 memory places
		);
		port (
        CLK : in std_logic;
        WE : in std_logic;
        ADDR1 : in std_logic_vector(B-1 downto 0);
        ADDR2 : in std_logic_vector(B-1 downto 0);
        DI : in std_logic_vector(31 downto 0); --32 bit word
        DO1 : out std_logic_vector(31 downto 0);
        DO2 : out std_logic_vector(31 downto 0)
                  
		);
	end component bram_d_allpass;
	
begin

--*********** temporary debugging signals *********
--addr1_temp0 <= "00000000000000000" & std_logic_vector(addr1);
--addr2_temp1 <= "00000000000000000" & std_logic_vector(addr2);
--*************************************************

bram_inst : bram
port map (
        CLK => clk_48,
        WE => we,
        ADDR1 => addr1,
        ADDR2 => addr2,
        DI => data_in,
        DO1 => data_out1,
        DO2 => data_out2
        ); 
     
process(count) --triangular wave, creates long delay
begin
    if (count=2440) then 
        direction <= '1';
    end if;
    if (count=0) then 
        direction <= '0';
    end if;
end process;
dir1:process(direction, clk_48)
begin
if rising_edge(clk_48) then 
    if (direction='0') then
    count <= count+1;
    end if;
    if (direction='1') then
    count <= count-1;
end if;
end if;
end process;

process(clk_48)
begin
    if rising_edge(clk_48) then 
        if to_integer(unsigned(i)) = max_delay-2 then
        i<= "000000000000000";
        else
        i <= std_logic_vector(unsigned(i)+1);
        end if;      
    end if;
end process;

addr_1:process(clk_48) --BRAM write pointer
begin
    if rising_edge(clk_48) then 
           if (to_integer(unsigned(addr1)) = max_delay-2) then 
               addr1 <= "000000000000000";
           else
            addr1 <= std_logic_vector(unsigned(addr1) + 1);            
           end if;                    
    end if;
end process;

addr_2:process(clk_48) --BRAM read pointer
begin
if rising_edge(clk_48) then 
        if (options="1000" or options="0100" or options="0010" or options="1100" or options="1110") then            
               if (to_integer(unsigned(addr2)) = max_delay-2) then 
                 addr2 <= "000000000000000";  
               end if;
               addr2 <= std_logic_vector(unsigned(i) + 1);
         end if;              
     end if; 
end process;

main:process (clk_48, options)
begin
if en(3)= '1' then
if rising_edge(clk_48) then 

if options="1000" then --iir , play Buckethead's Whitewash!
max_delay <= T-1;
y_temp_s <= signed(x) + signed("00000000" & std_logic_vector(shift_right(signed(data_out2(23 downto 0)),1)));
data_in <= std_logic_vector(y_temp_s);
y <= std_logic_vector(y_temp_s);    
end if;

if options="1100" then  --iir, faster delay 
max_delay <= T/2-1;
y_temp_s <= signed(x) + signed("00000000" & std_logic_vector(shift_right(signed(data_out2(23 downto 0)),1)));
data_in <= std_logic_vector(y_temp_s);
y <= std_logic_vector(y_temp_s);  
end if;

if options="1110" then --iir, very slight reverb
max_delay <= T/2-1;
y_temp_s <= signed(x) + signed("00000000" & std_logic_vector(shift_right(signed(data_out2(23 downto 0)),3)));
data_in <= std_logic_vector(y_temp_s);
y <= std_logic_vector(y_temp_s);  
end if;

if options="0100" then --iir, long delay
max_delay <= count;
y_temp_s <= signed(x) + signed("00000000" & std_logic_vector(shift_right(signed(data_out2(23 downto 0)),1)));
data_in <= std_logic_vector(y_temp_s);
y <= std_logic_vector(y_temp_s);    
end if;

if options="0010" then --fir sigle tap, long delay
max_delay <= count;
y_temp_s <= signed(x) + signed("00000000" & std_logic_vector(shift_right(signed(data_out2(23 downto 0)),1)));
data_in <= x;
y <= std_logic_vector(y_temp_s); 
end if;

            
end if;   
else
y<=x;      
end if;
end process;


end Behavioral;

----------------------------------------------------
--                Vladi & Adi                     --
--           TAU EE Senior year project           --
--                                                --
--************************************************--
--************* Distortion /Overdrive ************--
--************************************************--

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Distortion is
    Port ( x : in STD_LOGIC_VECTOR(31 downto 0);
           y : out STD_LOGIC_VECTOR(31 downto 0);
           clk_48: in std_logic;
           options : in STD_LOGIC_VECTOR(0 to 3);
           en : in STD_LOGIC_VECTOR(0 to 3)
       );
end Distortion;

architecture Behavioral of Distortion is

signal y_temp_s : signed(31 downto 0):= x"00000000";

begin

process(clk_48, options)
begin
if en(0)= '1' then
if rising_edge(clk_48) then 

if options="1000" then --weak overdrive
    if signed(x(23 downto 0)) >= 70000 then
        y<=std_logic_vector(to_signed(70000,32));    
    elsif signed(x(23 downto 0)) <= -70000 then
        y<=std_logic_vector(to_signed(-70000,32));
    else
       y<=x;
    end if;
end if;

if options="0100" then --strong overdrive
    if signed(x(23 downto 0)) >= 70000 then
      y<=std_logic_vector(to_signed(90000,32));    
    elsif signed(x(23 downto 0)) <= -70000 then
      y<=std_logic_vector(to_signed(-90000,32));
    else
      y<=x;
    end if;
end if;

if options="0010" then --overdrive
    if signed(x(23 downto 0)) >= 50000 then
        y  <= std_logic_vector(to_signed(50000,32)); 
    elsif signed(x(23 downto 0)) <= -50000 then
        y  <= std_logic_vector(to_signed(-50000,32)); 
    else
        y<=x;
end if;
end if;

if options="0001" then --distortion
if signed(x(23 downto 0)) >= 0 and signed(x(23 downto 0)) < 50 then
y<=std_logic_vector(to_signed(200,32)); 
elsif signed(x(23 downto 0)) >= 50 and signed(x(23 downto 0)) < 100 then
y<=std_logic_vector(to_signed(500,32)); 
elsif signed(x(23 downto 0)) >= 100 and signed(x(23 downto 0)) < 200 then
y<=std_logic_vector(to_signed(1000,32)); 
elsif signed(x(23 downto 0)) >= 200 and signed(x(23 downto 0)) < 500 then
y<=std_logic_vector(to_signed(2000,32)); 
elsif signed(x(23 downto 0)) >= 500 and signed(x(23 downto 0)) < 1000 then
y<=std_logic_vector(to_signed(3000,32)); 
elsif signed(x(23 downto 0)) >= 1000 and signed(x(23 downto 0)) < 2000 then
y<=std_logic_vector(to_signed(4000,32)); 
elsif signed(x(23 downto 0)) >= 2000 and signed(x(23 downto 0)) < 3000 then
y<=std_logic_vector(to_signed(5000,32)); 
elsif signed(x(23 downto 0)) >= 3000 and signed(x(23 downto 0)) < 4500 then
y<=std_logic_vector(to_signed(5500,32)); 
elsif signed(x(23 downto 0)) >= 4000 and signed(x(23 downto 0)) < 5000 then
y<=std_logic_vector(to_signed(6000,32)); 
elsif signed(x(23 downto 0)) >= 5000 and signed(x(23 downto 0)) < 5500 then
y<=std_logic_vector(to_signed(7000,32)); 
elsif signed(x(23 downto 0)) >= 5500 and signed(x(23 downto 0)) < 6000 then
y<=std_logic_vector(to_signed(8000,32)); 
elsif signed(x(23 downto 0)) >= 6000 and signed(x(23 downto 0)) < 6500 then
y<=std_logic_vector(to_signed(9000,32)); 
elsif signed(x(23 downto 0)) >= 6500 and signed(x(23 downto 0)) < 7000 then
y<=std_logic_vector(to_signed(10000,32)); 
elsif signed(x(23 downto 0)) >= 7000 and signed(x(23 downto 0)) < 7500 then
y<=std_logic_vector(to_signed(20000,32)); 
elsif signed(x(23 downto 0)) >= 7500 and signed(x(23 downto 0)) < 8000 then
y<=std_logic_vector(to_signed(30000,32)); 
elsif signed(x(23 downto 0)) >= 8000 and signed(x(23 downto 0)) < 8500 then
y<=std_logic_vector(to_signed(50000,32)); 
elsif signed(x(23 downto 0)) >= 8500 and signed(x(23 downto 0)) < 9000 then
y<=std_logic_vector(to_signed(70000,32)); 
elsif signed(x(23 downto 0)) >= 9000 and signed(x(23 downto 0)) < 9500 then
y<=std_logic_vector(to_signed(95000,32)); 
elsif signed(x(23 downto 0)) >= 9500 and signed(x(23 downto 0)) < 10000 then
y<=std_logic_vector(to_signed(105000,32)); 
elsif signed(x(23 downto 0)) >= 10000 and signed(x(23 downto 0)) < 15000 then
y<=std_logic_vector(to_signed(110000,32)); 
elsif signed(x(23 downto 0)) >= 15000 and signed(x(23 downto 0)) < 20000 then
y<=std_logic_vector(to_signed(115000,32)); 
elsif signed(x(23 downto 0)) >= 20000 and signed(x(23 downto 0)) < 25000 then
y<=std_logic_vector(to_signed(120000,32)); 
elsif signed(x(23 downto 0)) >= 25000 and signed(x(23 downto 0)) < 30000 then
y<=std_logic_vector(to_signed(125000,32)); 
elsif signed(x(23 downto 0)) >= 30000 and signed(x(23 downto 0)) < 35000 then
y<=std_logic_vector(to_signed(130000,32)); 
elsif signed(x(23 downto 0)) >= 35000 and signed(x(23 downto 0)) < 40000 then
y<=std_logic_vector(to_signed(135000,32)); 
elsif signed(x(23 downto 0)) >= 40000 and signed(x(23 downto 0)) < 45000 then
y<=std_logic_vector(to_signed(140000,32)); 
elsif signed(x(23 downto 0)) >= 45000 and signed(x(23 downto 0)) < 50000 then
y<=std_logic_vector(to_signed(145000,32)); 
elsif signed(x(23 downto 0)) >= 50000 and signed(x(23 downto 0)) < 60000 then
y<=std_logic_vector(to_signed(150000,32)); 
elsif signed(x(23 downto 0)) >= 60000 and signed(x(23 downto 0)) < 70000 then
y<=std_logic_vector(to_signed(160000,32));    
elsif signed(x(23 downto 0)) >= 70000 and signed(x(23 downto 0)) < 80000 then
y<=std_logic_vector(to_signed(170000,32)); 
elsif signed(x(23 downto 0)) >= 80000 and signed(x(23 downto 0)) < 90000 then
y<=std_logic_vector(to_signed(180000,32)); 
elsif signed(x(23 downto 0)) >= 90000 and signed(x(23 downto 0)) < 100000 then
y<=std_logic_vector(to_signed(190000,32)); 
elsif signed(x(23 downto 0)) >= 100000 and signed(x(23 downto 0)) < 120000 then
y<=std_logic_vector(to_signed(200000,32)); 
elsif signed(x(23 downto 0)) >= 120000 and signed(x(23 downto 0)) < 140000 then
y<=std_logic_vector(to_signed(220000,32)); 
elsif signed(x(23 downto 0)) >= 140000 and signed(x(23 downto 0)) < 160000 then
y<=std_logic_vector(to_signed(240000,32)); 
elsif signed(x(23 downto 0)) >= 160000 and signed(x(23 downto 0)) < 170000 then
y<=std_logic_vector(to_signed(260000,32)); 
elsif signed(x(23 downto 0)) >= 170000 and signed(x(23 downto 0)) < 190000 then
y<=std_logic_vector(to_signed(270000,32)); 
elsif signed(x(23 downto 0)) >= 190000 and signed(x(23 downto 0)) < 200000 then
y<=std_logic_vector(to_signed(290000,32)); 
elsif signed(x(23 downto 0)) >= 200000 and signed(x(23 downto 0)) < 220000 then
y<=std_logic_vector(to_signed(300000,32));   
elsif signed(x(23 downto 0)) >= 220000 and signed(x(23 downto 0)) < 240000 then
y<=std_logic_vector(to_signed(320000,32)); 
elsif signed(x(23 downto 0)) >= 240000 and signed(x(23 downto 0)) < 260000 then
y<=std_logic_vector(to_signed(340000,32)); 
elsif signed(x(23 downto 0)) >= 260000 and signed(x(23 downto 0)) < 280000 then
y<=std_logic_vector(to_signed(360000,32)); 
elsif signed(x(23 downto 0)) >= 280000 and signed(x(23 downto 0)) < 300000 then
y<=std_logic_vector(to_signed(380000,32)); 
elsif signed(x(23 downto 0)) >= 300000 then
y<=std_logic_vector(to_signed(400000,32));
elsif signed(x(23 downto 0)) <=  0 and signed(x(23 downto 0)) > -50 then
y<=std_logic_vector(to_signed(-200,32)); 
elsif signed(x(23 downto 0)) <=  -50 and signed(x(23 downto 0)) > -100 then
y<=std_logic_vector(to_signed(-500,32)); 
elsif signed(x(23 downto 0)) <=  -100 and signed(x(23 downto 0)) > -200 then
y<=std_logic_vector(to_signed(-1000,32)); 
elsif signed(x(23 downto 0)) <= -200 and signed(x(23 downto 0)) > -500 then
y<=std_logic_vector(to_signed(-2000,32)); 
elsif signed(x(23 downto 0)) <= -500 and signed(x(23 downto 0)) > -1000 then
y<=std_logic_vector(to_signed(-3000,32)); 
elsif signed(x(23 downto 0)) <= -1000 and signed(x(23 downto 0)) > -2000 then
y<=std_logic_vector(to_signed(-4000,32)); 
elsif signed(x(23 downto 0)) <= -2000 and signed(x(23 downto 0)) > -3000 then
y<=std_logic_vector(to_signed(-5000,32)); 
elsif signed(x(23 downto 0)) <= -3000 and signed(x(23 downto 0)) > -4500 then
y<=std_logic_vector(to_signed(-5500,32)); 
elsif signed(x(23 downto 0)) <= -4000 and signed(x(23 downto 0)) > -5000 then
y<=std_logic_vector(to_signed(-6000,32)); 

elsif signed(x(23 downto 0)) <= -5000 and signed(x(23 downto 0)) > -5500 then
y<=std_logic_vector(to_signed(-7000,32)); 
elsif signed(x(23 downto 0)) <= -5500 and signed(x(23 downto 0)) > -6000 then
y<=std_logic_vector(to_signed(-8000,32)); 
elsif signed(x(23 downto 0)) <= -6000 and signed(x(23 downto 0)) > -6500 then
y<=std_logic_vector(to_signed(-9000,32)); 
elsif signed(x(23 downto 0)) <= -6500 and signed(x(23 downto 0)) > -7000 then
y<=std_logic_vector(to_signed(-10000,32)); 
elsif signed(x(23 downto 0)) <= -7000 and signed(x(23 downto 0)) > -7500 then
y<=std_logic_vector(to_signed(-20000,32)); 
elsif signed(x(23 downto 0)) <= -7500 and signed(x(23 downto 0)) > -8000 then
y<=std_logic_vector(to_signed(-30000,32)); 
elsif signed(x(23 downto 0)) <= -8000 and signed(x(23 downto 0)) > -8500 then
y<=std_logic_vector(to_signed(-50000,32)); 
elsif signed(x(23 downto 0)) <= -8500 and signed(x(23 downto 0)) > -9000 then
y<=std_logic_vector(to_signed(-70000,32)); 
elsif signed(x(23 downto 0)) <= -9000 and signed(x(23 downto 0)) > -9500 then
y<=std_logic_vector(to_signed(-95000,32)); 
elsif signed(x(23 downto 0)) <= -9500 and signed(x(23 downto 0)) > -10000 then
y<=std_logic_vector(to_signed(-105000,32)); 
elsif signed(x(23 downto 0)) <= -10000 and signed(x(23 downto 0)) > -15000 then
y<=std_logic_vector(to_signed(-110000,32)); 
elsif signed(x(23 downto 0)) <= -15000 and signed(x(23 downto 0)) > -20000 then
y<=std_logic_vector(to_signed(-115000,32)); 
elsif signed(x(23 downto 0)) <= -20000 and signed(x(23 downto 0)) > -25000 then
y<=std_logic_vector(to_signed(-120000,32)); 
elsif signed(x(23 downto 0)) <= -25000 and signed(x(23 downto 0)) > -30000 then
y<=std_logic_vector(to_signed(-125000,32)); 
elsif signed(x(23 downto 0)) <= -30000 and signed(x(23 downto 0)) > -35000 then
y<=std_logic_vector(to_signed(-130000,32)); 
elsif signed(x(23 downto 0)) <= -35000 and signed(x(23 downto 0)) > -40000 then
y<=std_logic_vector(to_signed(-135000,32)); 
elsif signed(x(23 downto 0)) <= -40000 and signed(x(23 downto 0)) > -45000 then
y<=std_logic_vector(to_signed(-140000,32)); 
elsif signed(x(23 downto 0)) <= -45000 and signed(x(23 downto 0)) > -50000 then
y<=std_logic_vector(to_signed(-145000,32)); 
elsif signed(x(23 downto 0)) <= -50000 and signed(x(23 downto 0)) > -60000 then
y<=std_logic_vector(to_signed(-150000,32)); 
elsif signed(x(23 downto 0)) <= -60000 and signed(x(23 downto 0)) > -70000 then
y<=std_logic_vector(to_signed(-160000,32));    
elsif signed(x(23 downto 0)) <= -70000 and signed(x(23 downto 0)) > -80000 then
y<=std_logic_vector(to_signed(-170000,32)); 
elsif signed(x(23 downto 0)) <= -80000 and signed(x(23 downto 0)) > -90000 then
y<=std_logic_vector(to_signed(-180000,32)); 
elsif signed(x(23 downto 0)) <= -90000 and signed(x(23 downto 0)) > -100000 then
y<=std_logic_vector(to_signed(-190000,32)); 
elsif signed(x(23 downto 0)) <= -100000 and signed(x(23 downto 0)) > -120000 then
y<=std_logic_vector(to_signed(-200000,32)); 
elsif signed(x(23 downto 0)) <= -120000 and signed(x(23 downto 0)) > -140000 then
y<=std_logic_vector(to_signed(-240000,32)); 
elsif signed(x(23 downto 0)) <= -140000 and signed(x(23 downto 0)) > -160000 then
y<=std_logic_vector(to_signed(-240000,32)); 
elsif signed(x(23 downto 0)) <= -160000 and signed(x(23 downto 0)) > -170000 then
y<=std_logic_vector(to_signed(-260000,32)); 
elsif signed(x(23 downto 0)) <= -170000 and signed(x(23 downto 0)) > -190000 then
y<=std_logic_vector(to_signed(-270000,32)); 
elsif signed(x(23 downto 0)) <= -190000 and signed(x(23 downto 0)) > -200000 then
y<=std_logic_vector(to_signed(-290000,32)); 
elsif signed(x(23 downto 0)) <= -200000 and signed(x(23 downto 0)) > -220000 then
y<=std_logic_vector(to_signed(-300000,32));   
elsif signed(x(23 downto 0)) <= -220000 and signed(x(23 downto 0)) > -240000 then
y<=std_logic_vector(to_signed(-320000,32)); 
elsif signed(x(23 downto 0)) <= -240000 and signed(x(23 downto 0)) > -260000 then
y<=std_logic_vector(to_signed(-340000,32)); 
elsif signed(x(23 downto 0)) <= -260000 and signed(x(23 downto 0)) > -280000 then
y<=std_logic_vector(to_signed(-360000,32)); 
elsif signed(x(23 downto 0)) <= -280000 and signed(x(23 downto 0)) > -300000 then
y<=std_logic_vector(to_signed(-380000,32)); 
elsif signed(x(23 downto 0)) <= -300000 then
y<=std_logic_vector(to_signed(-400000,32)); 
else
y<=x;
end if;
end if;
      
end if; --rising_edge(clk)

else --if effect not enabled 
y<=x;
end if;--en
end process;

end Behavioral;

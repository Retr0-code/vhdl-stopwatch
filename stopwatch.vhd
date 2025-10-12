library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch is
  generic (
    g_clock_divider : integer := 5000000  -- Passing generic to timer component
  );
  port (
    i_clk        : in std_logic; -- Clock input
    i_start_stop : in std_logic  -- Button input
  );
end entity stopwatch;

architecture structural of stopwatch is
	component timer
		generic (
			g_clock_divider : integer := 5000000 -- If 5 000 000 periods passed for 50 MHz clock then 100 ms added to time register
		);
		
		port (
			i_clk				: in std_logic; -- Assuming clock frequency is 50 MHz
			i_start_stop	: in std_logic; -- A signal pulse to set T-flipflop
			o_time			: out unsigned(15 downto 0) -- Amount of time in 100 ms
		);
	end component;
	
	signal elapsed_time : unsigned(15 downto 0);
	
	component bcd_register
		port (
			i_clk	: in std_logic;
			i_num	: in std_logic_vector(15 downto 0);
			o_digit0, o_digit1, o_digit2, o_digit3 : out std_logic_vector(4 downto 0)
		);
	end component;
	
	signal o_digit0, o_digit1, o_digit2, o_digit3 : std_logic_vector(4 downto 0);
	
begin

	u_timer : timer
		generic map (g_clock_divider)
		port map (i_clk, i_start_stop, elapsed_time);
		
	u_bcd_register : bcd_register
		port map (i_clk, std_logic_vector(elapsed_time), o_digit0, o_digit1, o_digit2, o_digit3);

end architecture structural;

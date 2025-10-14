library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
	generic (
		g_clock_divider	: integer := 5000000; -- If 5 000 000 periods passed for 50 MHz clock then 100 ms added to time register
		g_divider_nbit		: integer := 23; -- Default amount of bits for 5 000 000 periods accumulation
		g_timer_nbit		: integer := 14 -- Minimal amount of bits to store max of 16384 by 100ms
	);

	port (
		i_clk				: in std_logic; -- Assuming clock frequency is 50 MHz
		i_start_stop	: in std_logic; -- A signal pulse to set T-flipflop
		o_time			: out unsigned(g_timer_nbit - 1 downto 0) -- Amount of time in 100 ms
	);
end entity timer;

architecture behavioral of timer is
	signal r_start : std_logic := '0';
	signal r_time	: unsigned(g_timer_nbit - 1 downto 0) := (others => '0');
	signal r_period_counter	: unsigned(g_divider_nbit - 1 downto 0) := (others => '0');
begin

	-- Period counter & timer process
	process (i_clk) is
	begin
		if rising_edge(i_clk) then
			if r_start = '1' then
				
				if r_period_counter = to_unsigned(g_clock_divider, r_period_counter'length) then
					r_time <= r_time + 1;
					r_period_counter <= (others => '0');
				else
					r_period_counter <= r_period_counter + 1;
				end if;
			else
				r_period_counter <= (others => '0');
			end if;
		end if;
	end process;
	
	-- Start/Stop process
	process (i_start_stop) is
	begin
		if rising_edge(i_start_stop) then
			r_start <= not r_start;
		end if;
	end process;

	o_time <= r_time;
	
end architecture behavioral;

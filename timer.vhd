library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity timer is
	port (
		i_clk				: in std_logic; -- Assuming clock frequency is 50 MHz
		i_start_stop	: in std_logic;
		o_time			: out unsigned(15 downto 0) -- Amount of time in 100 ms
	);
end entity timer;

architecture behave of timer is
	signal r_start : std_logic := '0';
	signal r_time	: unsigned(15 downto 0) := (others => '0');
	signal r_period_counter	: unsigned(23 downto 0) := (others => '0');
begin

	-- Period counter & timer process
	process (i_clk) is
	begin
		if r_start = '1' then
			if rising_edge(i_clk) then
				-- If 5 000 000 periods passed for 50 MHz clock then 100 ms added to time register
				if r_period_counter = 5000000 then
					r_time <= r_time + 1;
					r_period_counter <= (others => '0');
				else
					r_period_counter <= r_period_counter + 1;
				end if;
			end if;
		else
			r_period_counter <= (others => '0');
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
	
end architecture behave;

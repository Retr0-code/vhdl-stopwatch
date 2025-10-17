library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stopwatch is
    generic (
        g_clock_divider     : integer := 5000000; -- If 5 000 000 periods passed for 50 MHz clock then 100 ms added to time register
        g_divider_nbit      : integer := 23; -- Default amount of bits for 5 000 000 periods accumulation
        g_timer_nbit        : integer := 14; -- Minimal amount of bits to store max of 16384 by 100ms
        g_digits_amount     : integer := 4
    );
    port (
        i_clk        : in std_logic; -- Clock input
        i_start_stop : in std_logic; -- Button input
        o_digit      : out std_logic_vector(7 downto 0); -- Digit to output
        o_digit_sel  : out std_logic_vector(3 downto 0)  -- Selected digit
    );
end entity stopwatch;

architecture structural of stopwatch is
    component timer
        generic (
            g_clock_divider     : integer := 5000000; -- If 5 000 000 periods passed for 50 MHz clock then 100 ms added to time register
            g_divider_nbit      : integer := 23; -- Default amount of bits for 5 000 000 periods accumulation
            g_timer_nbit        : integer := 14 -- Minimal amount of bits to store max of 16384 by 100ms
        );
        
        port (
            i_clk           : in std_logic; -- Assuming clock frequency is 50 MHz
            i_start_stop    : in std_logic; -- A signal pulse to set T-flipflop
            o_time          : out unsigned(g_timer_nbit - 1 downto 0) -- Amount of time in 100 ms
        );
    end component;
    
    component display4digits
        port (
            i_clk       : in std_logic;
            i_dp_pos    : in std_logic; -- Sets precision to 1 or 0 symbol after decimal point
            i_num       : in std_logic_vector(15 downto 0);
            o_digit     : out std_logic_vector(7 downto 0);
            o_digit_sel : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal w_elapsed_time : unsigned(g_timer_nbit - 1 downto 0);
    signal w_elapsed_time_converted : std_logic_vector(g_digits_amount * 4 - 1 downto 0);
    
begin

    w_elapsed_time_converted <= "00" & std_logic_vector(w_elapsed_time);

    u_timer : timer
        port map (i_clk, i_start_stop, w_elapsed_time);
        
    u_display4digits : display4digits
        port map (i_clk, '0', w_elapsed_time_converted, o_digit, o_digit_sel);

end architecture structural;

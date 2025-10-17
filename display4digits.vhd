library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity display4digits is
    port (
        i_clk       : in std_logic;
        i_dp_pos    : in std_logic; -- Sets precision to 1 or 0 symbol after decimal point
        i_num       : in std_logic_vector(15 downto 0);
        o_digit     : out std_logic_vector(7 downto 0);
        o_digit_sel : out std_logic_vector(3 downto 0)
    );
end entity display4digits;

architecture structural of display4digits is
    component bcd_register
        generic (
            g_digits_amount : integer := 4
        );

        port (
            i_clk       : in std_logic;
            i_num       : in std_logic_vector(g_digits_amount * 4 - 1 downto 0);
            o_digits    : out std_logic_vector(g_digits_amount * 4 - 1 downto 0)
        );
    end component;
    
    component display_7seg
        port (
            i_num   : in std_logic_vector(3 downto 0);
            i_dp    : in std_logic;
            o_seg_a : out std_logic;
            o_seg_b : out std_logic;
            o_seg_c : out std_logic;
            o_seg_d : out std_logic;
            o_seg_e : out std_logic;
            o_seg_f : out std_logic;
            o_seg_g : out std_logic;
            o_seg_dp : out std_logic
        );
    end component;
    
    signal w_output_digits : std_logic_vector(15 downto 0);
begin

    u_bcd_register : bcd_register
        port map (i_clk, i_num, w_output_digits);
        
    u_display_7seg_0 : display_7seg
        port map (w_output_digits(3 downto 0), '0');

end architecture structural;

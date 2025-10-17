library ieee;
use ieee.std_logic_1164.all;

entity display_7seg is
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
end entity display_7seg;

architecture dataflow of display_7seg is
begin
    o_seg_a <= (i_num(0) or i_num(1) or not i_num(2)) and (not i_num(0) or i_num(1) or i_num(2) or i_num(3));
    o_seg_b <= not (i_num(2) and (i_num(0) xor i_num(1)));
    o_seg_c <= i_num(0) or not i_num(1) or i_num(2) or i_num(3);
    o_seg_d <= (not i_num(0) or i_num(1) or i_num(2) or i_num(3)) and (not i_num(0) or not i_num(1) or i_num(2));
    o_seg_e <= (not i_num(0)) and (i_num(1) or not i_num(2));
    o_seg_f <= (i_num(2) and not i_num(3) and not (i_num(0) and i_num(1))) or not (i_num(0) or  i_num(1)) or (not i_num(2) and i_num(3));
    o_seg_g <= (i_num(1) or i_num(2) or i_num(3)) and (not i_num(0) or not i_num(1) or not i_num(2));
    o_seg_dp <= i_dp;
end architecture dataflow;

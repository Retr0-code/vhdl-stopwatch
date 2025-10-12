library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_register is
	port (
		i_clk	: in std_logic;
		i_num	: in std_logic_vector(15 downto 0);
		o_digit0, o_digit1, o_digit2, o_digit3	: out std_logic_vector(4 downto 0)
	);
end bcd_register;

architecture behavioral of bcd_register is
begin

end architecture behavioral;

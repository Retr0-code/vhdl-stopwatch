library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
	generic (
		g_port_bit : integer := 4
	);
	
	port (
		i_d0, i_d1, i_d2, i_d3 : in std_logic_vector(g_port_bit - 1 downto 0);
		i_addr : in std_logic_vector(1 downto 0);
		o_q : out std_logic_vector(g_port_bit - 1 downto 0)
	);
end entity mux4to1;

architecture dataflow of mux4to1 is
begin
	with i_addr select
		o_q	<= i_d0 when "00"
				<= i_d1 when "01"
				<= i_d2 when "10"
				<= i_d3 when others;
end architecture dataflow;

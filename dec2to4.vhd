library ieee;
use ieee.std_logic_1164.all;

entity dec2to4 is
    port (
        i_counter : in std_logic_vector(1 downto 0);
        o_decoder : out std_logic_vector(3 downto 0)
    );
end entity dec2to4;

architecture dataflow of dec2to4 is
begin
    with i_counter select
        o_decoder <= "0001" when "00",
                     "0010" when "01",
                     "0100" when "10",
                     "1000" when "11",
                     "0000" when others;
end architecture dataflow;

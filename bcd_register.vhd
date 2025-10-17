library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bcd_register is
    generic (
        g_digits_amount : integer := 4
    );

    port (
        i_clk    : in std_logic;
        i_num    : in std_logic_vector(g_digits_amount * 4 - 1 downto 0);
        o_digits : out std_logic_vector(g_digits_amount * 4 - 1 downto 0)
    );
end bcd_register;

architecture behavioral of bcd_register is
    signal r_enable : std_logic := '1';
    signal r_bcd    : std_logic_vector(g_digits_amount * 4 - 1 downto 0) := (others => '0');
    signal r_num    : std_logic_vector(g_digits_amount * 4 - 1 downto 0) := (others => '0');
    signal r_steps  : std_logic_vector(g_digits_amount * 4 - 1 downto 0) := (others => '1');
begin
    process (i_clk) is
        variable v_bcd : unsigned(g_digits_amount * 4 - 1 downto 0) := (others => '0');
    begin
        if rising_edge(i_clk) then
            if r_enable = '1' then
                r_bcd <= (others => '0');
                r_num <= i_num;
                r_steps <= (others => '1');
                r_enable <= '0';
            else
                if unsigned(r_steps) = 0 then
                    r_enable <= '1';
                else
                    v_bcd := unsigned(r_bcd);
                    
                    -- Thinking which approach is better synthesizable
                    -- Align digits
                    -- for i in g_digits_amount downto 1 loop
                    --     if v_bcd(i * 4 - 1 downto i * 4 - 4) > "0100" then
                    --         v_bcd := v_bcd + ("0011" sll i * 4 - 4);
                    --     end if;
                    -- end loop;

                    for i in g_digits_amount downto 1 loop
                        if v_bcd(i * 4 - 1 downto i * 4 - 4) > "0100" then
                            v_bcd(i * 4 - 1 downto i * 4 - 4) := v_bcd(i * 4 - 1 downto i * 4 - 4) + "0011" ;
                        end if;
                    end loop;
                    
                    -- Shift left
                    r_bcd <= std_logic_vector(v_bcd(g_digits_amount * 4 - 2 downto 0)) & r_num(g_digits_amount * 4 - 1);
                    r_num <= r_num(g_digits_amount * 4 - 2 downto 0) & '0';
                    r_steps <= r_steps(g_digits_amount * 4 - 2 downto 0) & '0';
                end if;
            end if;
        end if;
    end process;
    
    o_digits <= std_logic_vector(r_bcd);
end architecture behavioral;

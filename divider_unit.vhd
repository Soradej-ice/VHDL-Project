library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divider_unit is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;

        start   : in  std_logic;

        dividend    : in  unsigned(31 downto 0);
        divisor     : in  unsigned(15 downto 0);

        quotient    : out unsigned(15 downto 0);
        remainder   : out unsigned(15 downto 0);

        done        : out std_logic
    );
end divider_unit;

architecture skeleton of divider_unit is

    signal quotient_reg  : unsigned(15 downto 0);
    signal remainder_reg : unsigned(15 downto 0);
    signal busy          : std_logic;

begin

    process(clk, rst)
    begin
        if rst = '1' then
            quotient_reg  <= (others => '0');
            remainder_reg <= (others => '0');
            busy <= '0';
            done <= '0';

        elsif rising_edge(clk) then

            if start = '1' then
                busy <= '1';
                done <= '0';
            end if;

            -- TODO:
            -- ใส่ algorithm การหารที่เลือกในภายหลัง
            -- เช่น shift-subtract หรือ combinational

            -- เมื่อคำนวณเสร็จ
            -- busy <= '0';
            -- done <= '1';

        end if;
    end process;

    quotient  <= quotient_reg;
    remainder <= remainder_reg;

end skeleton;

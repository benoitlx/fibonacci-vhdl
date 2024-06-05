library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity clock_divider is
  generic (
    N : integer := 3
  );
  port (
    clk : in std_logic;
    raz : in std_logic;
    cout : out std_logic
  );
end entity clock_divider;

architecture Behavioral of clock_divider is
  signal counter : integer range 0 to N := 0;
  signal cout_reg : std_logic := '0';
begin
  process(clk, raz)
  begin
    if raz = '1' then
      counter <= 0;
      cout_reg <= '0';
    elsif rising_edge(clk) then
      if counter = N-1 then
        counter <= 0;
        cout_reg <= not cout_reg;
      else 
        counter <= counter + 1;
      end if;
    end if;
  end process;

  cout <= cout_reg;
end architecture Behavioral;

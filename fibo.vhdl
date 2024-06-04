library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fibo is
  port (
    ena : in std_logic;
    clk : in std_logic;
    raz : in std_logic;
    fib_out : out std_logic_vector(19 downto 0) := (others => '0')
  );
end entity fibo;

architecture Behavioral of fibo is
  signal fib_a : unsigned(19 downto 0) := (others => '0'); -- Fibo(n-2)
  signal fib_b : unsigned(19 downto 0) := to_unsigned(1, 20); -- Fibo(n-1)
  signal fib_next : unsigned(19 downto 0) := (others => '0'); -- Fibo(n)
begin

  compute_fibo: process(clk)
  begin
    if fib_next > to_unsigned(999999, 20) or raz = '1' then
      fib_a <= (others => '0');
      fib_b <= to_unsigned(1, 20);
      fib_next <= (others => '0');
    else
      fib_next <= fib_a + fib_b;
      if rising_edge(clk) and ena = '1' then 
        fib_a <= fib_b;
        fib_b <= fib_next;
      end if;
    end if; 
  end process compute_fibo; 
 
  fib_out <= std_logic_vector(fib_a);
end architecture Behavioral;

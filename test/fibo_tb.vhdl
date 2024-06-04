library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fibo_tb is
end entity fibo_tb;

architecture Behavioral of fibo_tb is
  component Fibo
    port(
      ena : in std_logic;
      clk : in std_logic;
      raz : in std_logic;
      fib_out : out std_logic_vector(19 downto 0) := (others => '0')
    );
  end component;

  signal ena : std_logic := '0';
  signal clk : std_logic := '0';
  signal raz : std_logic := '0';
  signal fib_out : std_logic_vector(19 downto 0) := (others => '0');
  
  -- Expected Fibonnacci values
  type fib_array is array (0 to 15) of integer;
  constant expected_values : fib_array := (0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610);

  constant clk_period : time := 10 ns;
begin

  -- Unit Under Test
  uut: Fibo 
    port map(
      clk => clk,
      ena => ena,
      raz => raz,
      fib_out => fib_out
    );

  -- Clock Process
  clk_process: process
  begin
    clk <= '0';
    wait for clk_period/2;
    clk <= '1';
    wait for clk_period/2;
  end process clk_process;

  -- Stimulus
  stim_proc: process
  begin
    -- hold reset state
    raz <= '1';
    wait for 20 ns;
    raz <= '0';

    -- enable the counter
    ena <= '1';

    -- loop through the expected values
    for i in 0 to expected_values'length-1 loop
      wait until falling_edge(clk);
      assert to_integer(unsigned(fib_out)) = expected_values(i)
      report "Test 1: Mismatch at index " & integer'image(i) & ": expected " & integer'image(expected_values(i)) & ", got " & integer'image(to_integer(unsigned(fib_out)))
      severity error;

    end loop;

    -- disable the counter
    ena <= '0';

    -- wait for 100ns
    wait for 100 ns;

    -- reset 
    raz <= '1';
    wait for 1 ns;
    assert to_integer(unsigned(fib_out)) = 0
    report "expected 0" & integer'image(0) & ", got " & integer'image(to_integer(unsigned(fib_out)))
    severity error;

    wait;

  end process stim_proc;
end architecture Behavioral;

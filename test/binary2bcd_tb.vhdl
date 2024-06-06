library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Use NUMERIC_STD instead of STD_LOGIC_ARITH and STD_LOGIC_UNSIGNED

entity binary2bcd_tb is
  end binary2bcd_tb;

architecture Behavioral of binary2bcd_tb is
  -- Component declaration for the Unit Under Test (UUT)
  component binary2bcd
    port (
           binary_in : in  STD_LOGIC_VECTOR(19 downto 0);
           ones      : out STD_LOGIC_VECTOR(3 downto 0);
           tens      : out STD_LOGIC_VECTOR(3 downto 0);
           hundreds  : out STD_LOGIC_VECTOR(3 downto 0);
           thousands : out STD_LOGIC_VECTOR(3 downto 0);
           ten_thousands : out STD_LOGIC_VECTOR(3 downto 0);
           hundred_thousands : out STD_LOGIC_VECTOR(3 downto 0)
         );
  end component;

  -- Signals to connect to UUT
  signal binary_in : STD_LOGIC_VECTOR(19 downto 0);
  signal ones      : STD_LOGIC_VECTOR(3 downto 0);
  signal tens      : STD_LOGIC_VECTOR(3 downto 0);
  signal hundreds  : STD_LOGIC_VECTOR(3 downto 0);
  signal thousands : STD_LOGIC_VECTOR(3 downto 0);
  signal ten_thousands : STD_LOGIC_VECTOR(3 downto 0);
  signal hundred_thousands : STD_LOGIC_VECTOR(3 downto 0);

  function to_string ( a: std_logic_vector) return string is
    variable b : string (a'length-1 downto 0) := (others => '0');
  begin
    for i in a'range loop
      b(i) := std_logic'image(a(i))(2);
    end loop;
    return b;
  end function;

begin
  -- Instantiate the Unit Under Test (UUT)
  uut: binary2bcd
  port map (
             binary_in => binary_in,
             ones => ones,
             tens => tens,
             hundreds => hundreds,
             thousands => thousands,
             ten_thousands => ten_thousands,
             hundred_thousands => hundred_thousands
           );

  -- Stimulus process
  stim_proc: process
  begin
    -- Test with various binary values
    binary_in <= "00000000000000000000"; -- 0
    wait for 10 ns;
    assert (ones = "0000" and tens = "0000" and hundreds = "0000" and thousands = "0000" and ten_thousands = "0000" and hundred_thousands = "0000")
    report "Test failed for input 0. Got ones=" & to_string(ones) & ", tens=" & to_string(tens) &
    ", hundreds=" & to_string(hundreds) & ", thousands=" & to_string(thousands) &
    ", ten_thousands=" & to_string(ten_thousands) & ", hundred_thousands=" & to_string(hundred_thousands)
    severity error;

    binary_in <= "00000000000001100100"; -- 100
    wait for 10 ns;
    assert (ones = "0000" and tens = "0000" and hundreds = "0001" and thousands = "0000" and ten_thousands = "0000" and hundred_thousands = "0000")
    report "Test failed for input 100. Got ones=" & to_string(ones) & ", tens=" & to_string(tens) &
    ", hundreds=" & to_string(hundreds) & ", thousands=" & to_string(thousands) &
    ", ten_thousands=" & to_string(ten_thousands) & ", hundred_thousands=" & to_string(hundred_thousands)
    severity error;

    binary_in <= "00000000001111101000"; -- 1000
    wait for 10 ns;
    assert (ones = "0000" and tens = "0000" and hundreds = "0000" and thousands = "0001" and ten_thousands = "0000" and hundred_thousands = "0000")
    report "Test failed for input 1000. Got ones=" & to_string(ones) & ", tens=" & to_string(tens) &
    ", hundreds=" & to_string(hundreds) & ", thousands=" & to_string(thousands) &
    ", ten_thousands=" & to_string(ten_thousands) & ", hundred_thousands=" & to_string(hundred_thousands)
    severity error;

    binary_in <= "00000011110100001000"; -- 15624 
    wait for 10 ns;
    assert (ones = "0100" and tens = "0010" and hundreds = "0110" and thousands = "0101" and ten_thousands = "0001" and hundred_thousands = "0000")
    report "Test failed for input 8008. Got ones=" & to_string(ones) & ", tens=" & to_string(tens) &
    ", hundreds=" & to_string(hundreds) & ", thousands=" & to_string(thousands) &
    ", ten_thousands=" & to_string(ten_thousands) & ", hundred_thousands=" & to_string(hundred_thousands)
    severity error;

    binary_in <= "11101000010010000000"; -- 951424
    wait for 10 ns;
    assert (ones = "0100" and tens = "0010" and hundreds = "0100" and thousands = "0001" and ten_thousands = "0101" and hundred_thousands = "1001")
    report "Test failed for input 999999. Got ones=" & to_string(ones) & ", tens=" & to_string(tens) &
    ", hundreds=" & to_string(hundreds) & ", thousands=" & to_string(thousands) &
    ", ten_thousands=" & to_string(ten_thousands) & ", hundred_thousands=" & to_string(hundred_thousands)
    severity error;

    -- End of simulation
    wait;
  end process;
end Behavioral;

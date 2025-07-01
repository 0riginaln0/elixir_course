defmodule GCD do
  def gcd(n1, 0), do: n1
  def gcd(n1, n2) when n2 < 0, do: gcd(n1, -n2)
  def gcd(n1, n2) when n1 < 0, do: gcd(-n1, n2)

  def gcd(n1, n2) do
    case rem(n1, n2) do
      0 -> n2
      r -> gcd(n2, r)
    end
  end
end

ExUnit.start()

defmodule GCDTest do
  use ExUnit.Case
  import GCD

  test "gcd base cases" do
    assert gcd(12, 9) == 3
    assert gcd(9, 12) == 3
    assert gcd(60, 48) == 12
  end

  test "gcd with negative arguments" do
    assert gcd(24, 18) == 6
    assert gcd(-24, 18) == 6
    assert gcd(24, -18) == 6
    assert gcd(-24, -18) == 6
  end

  test "gcd with zero arguments" do
    assert gcd(5, 0) == 5
    assert gcd(0, 5) == 5
    assert gcd(0, 0) == 0
  end
end

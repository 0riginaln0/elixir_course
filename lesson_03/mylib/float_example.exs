defmodule FloatExample do
  def equal?(f1, f2, precision \\ 0.01) do
    abs(f1-f2) < precision
  end
end

ExUnit.start()

defmodule FloatExampleTest do
  use ExUnit.Case
  import FloatExample

  test "equal?" do
  	assert equal?(0.3, 0.2 + 0.1)
  	assert equal?(5.5, 5.5)
  	refute equal?(5.5, 5.8)
  end

  test "equal? with precision" do
    assert equal?(5.5, 5.51)
    refute equal?(5.5, 5.51, 0.001)
    refute equal?(5.5, 5.52, 0.01)
  end
end
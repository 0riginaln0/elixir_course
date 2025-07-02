defmodule Convertor do
  def database() do
    [
      {"C1", "C2", 1.5, 1.6},
      {"C1", "C3", 2.5, 2.6},
      {"C2", "C3", 1.05, 1.07}
    ]
  end

  def init(convert_list) do
    Enum.reduce(convert_list, %{}, fn conversion, db ->
      {c1, c2, conv1to2, conv2to1} = conversion

      db
      |> Map.put({c1, c2}, conv1to2)
      |> Map.put({c2, c1}, conv2to1)
    end)
  end

  def convert(db, amount, from, to) do
    case Map.fetch(db, {from, to}) do
      {:ok, change_coef} -> {:ok, trunc(amount * change_coef)}
      :error -> :not_found
    end
  end
end

ExUnit.start()

defmodule ConvertorTest do
  use ExUnit.Case

  test "init" do
    assert Convertor.init([]) == %{}

    assert Convertor.init([{"usd", "eur", 1.1, 0.9}]) == %{
             {"usd", "eur"} => 1.1,
             {"eur", "usd"} => 0.9
           }

    assert Convertor.init([
             {"usd", "eur", 1.1, 0.9},
             {"gbp", "eur", 1.2, 0.8}
           ]) == %{
             {"usd", "eur"} => 1.1,
             {"eur", "usd"} => 0.9,
             {"gbp", "eur"} => 1.2,
             {"eur", "gbp"} => 0.8
           }
  end

  test "convert" do
    state = %{
      {"usd", "eur"} => 1.1,
      {"eur", "usd"} => 0.9,
      {"gbp", "eur"} => 1.2,
      {"eur", "gbp"} => 0.8
    }

    assert Convertor.convert(state, 1000, "usd", "eur") == {:ok, 1100}
    assert Convertor.convert(state, 10_000, "eur", "gbp") == {:ok, 8_000}
  end
end

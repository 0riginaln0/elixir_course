defmodule MapExample do
  def test_string() do
    """
    Elixir in Action is a tutorial book that aims to bring developers
    new to Elixir and Erlang to the point where they can develop complex systems on their own.
    """
  end

  def count_words(str) do
    words = String.split(str)

    Enum.reduce(words, %{}, fn word, acc ->
      case Map.fetch(acc, word) do
        {:ok, entries_num} -> Map.put(acc, word, entries_num + 1)
        :error -> Map.put(acc, word, 1)
      end
    end)

    # count_words(words, %{})
  end

  # defp count_words([], acc), do: acc

  # defp count_words([word | words], acc) do
  #   new_acc =
  #     case Map.fetch(acc, word) do
  #       {:ok, counter} -> %{acc | word => counter + 1}
  #       :error -> Map.put(acc, word, 1)
  #     end

  #   count_words(words, new_acc)
  # end
end

ExUnit.start()

defmodule MapExampleTest do
  use ExUnit.Case
  import MapExample

  test "count words" do
    assert %{} == count_words("")
    assert %{"Hello" => 1, "world" => 1} == count_words("Hello world")
    assert %{"Bip" => 2, "bop" => 5, "bip" => 2, "bam" => 1} ==
             count_words(" Bip bop bip bop bop Bip bop bip bop bam ")
  end
end
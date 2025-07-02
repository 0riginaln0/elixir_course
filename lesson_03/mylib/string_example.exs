defmodule StringExample do

  def example() do
    ["a", "bb", "hello", "world", "some-long-word", "short-word"]
  end

  @doc """
  |  a  |
  |  bb |
  | ccc |
  | dddd|
  |eeeee|
  """
  def align_words(words) do
    max_length = words |> Enum.max_by(&String.length/1) |> String.length()
    Enum.map(words, fn word -> align_word(word, max_length) end)
  end

  def align_word(word, length) do
    padding_length = max(length - String.length(word), 0)
    left_padding = String.duplicate(" ", ceil(padding_length / 2))
    right_padding = String.duplicate(" ", floor(padding_length / 2))
    left_padding <> word <> right_padding
  end
end


ExUnit.start()

defmodule StringExampleTest do
  use ExUnit.Case
  import StringExample

  test "align word" do
    assert align_word("aa", -7) == "aa"
    assert align_word("aa", 0) == "aa"
    assert align_word("aa", 1) == "aa"
    assert " bob " == align_word("bob", 5)
    assert "  bob " == align_word("bob", 6)
    assert "  bob  " == align_word("bob", 7)
  end

  test "align" do
    assert ["   cat  ", "  zebra ", "elephant"] == align_words(~w'cat zebra elephant')
  end

end

defmodule Caesar do
  # We consider only chars in range 32 - 126 as valid ascii chars
  # http://www.asciitable.com/
  @min_ascii_char 32
  @max_ascii_char 126
  @ascii_range @max_ascii_char - @min_ascii_char + 1

  @doc """
  Function shifts forward all characters in string. String could be double-quoted or single-quoted.

  ## Examples
  iex> Caesar.encode("Hello", 10)
  "Rovvy"
  iex> Caesar.encode('Hello', 5)
  'Mjqqt'
  """
  def encode(str, code) when is_bitstring(str) do
    str
    |> String.to_charlist()
    |> encode(code)
    |> List.to_string()
  end

  def encode(str, code) when is_list(str) do
    Enum.map(str, fn letter -> letter + code end)
  end

  @doc """
  Function shifts backward all characters in string. String could be double-quoted or single-quoted.

  ## Examples
  iex> Caesar.decode("Rovvy", 10)
  "Hello"
  iex> Caesar.decode('Mjqqt', 5)
  'Hello'
  """
  def decode(str, code) when is_bitstring(str) do
    str
    |> String.to_charlist()
    |> decode(code)
    |> List.to_string()
  end

  def decode(str, code) when is_list(str) do
    Enum.map(str, fn letter -> letter - code end)
  end

  @doc ~S"""
  Function shifts forward all characters in string. String could be double-quoted or single-quoted.
  All characters should be in range 32-126, otherwise function raises RuntimeError with message "invalid ascii str"
  If result characters are out of valid range, than function wraps them to the beginning of the range.

  ## Examples
  iex> Caesar.encode_ascii('hello world', 15)
  'wt{{~/\'~\"{s'
  """
  def encode_ascii(str, code) when is_bitstring(str) do
    str
    |> String.to_charlist()
    |> encode_ascii(code)
    |> List.to_string()
  end

  def encode_ascii(str, code) when is_list(str) do
    effective_code = rem(code, @ascii_range)

    Enum.map(str, fn letter ->
      valid_ascii!(letter)
      wrap_shifted_char(letter + effective_code)
    end)
  end

  def valid_ascii!(letter) do
    if letter < @min_ascii_char or letter > @max_ascii_char do
      raise "invalid ascii str"
    end
  end

  defp wrap_shifted_char(shifted_char) do
    cond do
      shifted_char > @max_ascii_char -> shifted_char - @ascii_range
      shifted_char < @min_ascii_char -> shifted_char + @ascii_range
      true -> shifted_char
    end
  end

  @doc ~S"""
  Function shifts backward all characters in string. String could be double-quoted or single-quoted.
  All characters should be in range 32-126, otherwise function raises RuntimeError with message "invalid ascii str"
  If result characters are out of valid range, than function wraps them to the end of the range.

  ## Examples
  iex> Caesar.decode_ascii('wt{{~/\'~\"{s', 15)
  'hello world'
  """
  def decode_ascii(str, code) when is_bitstring(str) do
    str
    |> String.to_charlist()
    |> decode_ascii(code)
    |> List.to_string()
  end

  def decode_ascii(str, code) when is_list(str) do
    effective_code = rem(code, @ascii_range)

    Enum.map(str, fn letter ->
      valid_ascii!(letter)
      wrap_shifted_char(letter - effective_code)
    end)
  end
end

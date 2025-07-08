defmodule Trim do
  # We only trim space character
  def is_space(char), do: char == 32

  @doc """
  Function trim spaces in the beginning and in the end of the string.
  It accepts both single-quoted and double-quoted strings.

  ## Examples
  iex> Trim.trim('   hello there   ')
  'hello there'
  iex> Trim.trim("  Привет   мир  ")
  "Привет   мир"
  """
  def trim(str) when is_list(str) do
    # We iterate string 4 times here
    str
    |> trim_left
    |> Enum.reverse()
    |> trim_left
    |> Enum.reverse()
  end

  def trim(str) when is_binary(str) do
    # And yet 2 more iterations here
    str
    |> to_charlist
    |> trim
    |> to_string
  end

  defp trim_left([]), do: []

  defp trim_left([head | tail] = str) do
    if is_space(head) do
      trim_left(tail)
    else
      str
    end
  end

  def effective_trim(str) when is_binary(str) do
    # And yet 2 more iterations here
    str
    |> to_charlist
    |> effective_trim
    |> to_string
  end

  def effective_trim(str) when is_list(str) do
    # Lets trim string with less than 4 iterations
    acc = %{
      found_first_non_space_index: false,
      first_non_space_index: -1,
      last_non_space_index: -1,
      current_index: 0
    }

    %{first_non_space_index: first_non_space_index, last_non_space_index: last_non_space_index} =
      # So this reduction is the first iteration.
      Enum.reduce(str, acc, fn char, acc ->
        found_space = is_space(char)

        cond do
          found_space and not acc.found_first_non_space_index ->
            %{acc | current_index: acc.current_index + 1}

          not found_space and not acc.found_first_non_space_index ->
            %{
              acc
              | found_first_non_space_index: true,
                first_non_space_index: acc.current_index,
                last_non_space_index: acc.current_index,
                current_index: acc.current_index + 1
            }

          not found_space ->
            %{
              acc
              | last_non_space_index: acc.current_index,
                current_index: acc.current_index + 1
            }

          true ->
            %{acc | current_index: acc.current_index + 1}
        end
      end)

    case first_non_space_index..last_non_space_index do
      # str contains of spaces only
      -1..-1 -> ~c""
      # And this Enum.slice is the second (third?) iteration. I'm not sure how it's implemented.
      # Nevertheless, 3 < 4. Victory!
      range -> Enum.slice(str, range)
    end
  end
end

# It was too dark outside, so I switched from Bass Fuji to dark theme. Leaving this comment to remember the light theme name

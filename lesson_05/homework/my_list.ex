defmodule MyList do
  @doc """
  Function takes a list that may contain any number of sublists,
  which themselves may contain sublists, to any depth.
  It returns the elements of these lists as a flat list.

  ## Examples
  iex> MyList.flatten([1, [2, 3], 4, [5, [6, 7, [8, 9, 10]]]])
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  """
  def flatten([]), do: []

  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)

  def flatten(item), do: [item]

  # ++ operator is not very effective.
  # It would be better to provide a more effective implementation,
  # which is possible, but a little bit tricky.
  def flatten_e(list) do
    # The complexity of a ++ b is proportional to length(a), so avoid repeatedly appending to lists of arbitrary length,
    # for example, list ++ [element]. Instead, consider prepending via [element | rest] and then reversing.

    # Ok... let me think.
    Enum.reverse(flatten_e(list, []))
  end

  defp flatten_e([], acc), do: acc

  defp flatten_e([el | rest], acc) when not is_list(el) do
    # dbg({1, el: el, rest: rest, acc: acc})
    flatten_e(rest, [el | acc])
  end

  defp flatten_e([el | rest], acc) when is_list(el) do
    # dbg({2, el: el, rest: rest, acc: acc})
    cond do
      Enum.empty?(el) ->
        flatten_e(rest, acc)

      true ->
        [first | other] = el
        flatten_e([first | [other | rest]], acc)
    end
  end
end

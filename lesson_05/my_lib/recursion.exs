defmodule Recursion do
  def len(list) do
    len(list, 0)
  end

  defp len(list, acc) do
    case list do
      [] -> acc
      [_head | tail] -> len(tail, acc + 1)
    end
  end

  def list_max([]), do: nil

  def list_max(list) do
    [first | tail] = list
    list_max(tail, first)
  end

  defp list_max([], maxelem), do: maxelem

  defp list_max([head | tail], maxelem) do
    list_max(tail, if(head > maxelem, do: head, else: maxelem))
  end

  def set_value_via_enum(list, position, value) do
    {left, [_ | right]} = Enum.split(list, position)
    left ++ [value | right]
  end

  def set_value(list, position, value) do
    cond do
      position > len(list) - 1 or position < 0 -> list
      true -> set_value(list, position, value, 0, [])
    end
  end

  defp set_value([], _, _, _, result_list) do
    result_list
  end

  defp set_value(list, set_position, value, current_position, result_list) do
    case current_position == set_position do
      false ->
        [head | tail] = list
        result_list = [head | result_list]
        set_value(tail, set_position, value, current_position + 1, result_list)

      true ->
        result_list = Enum.reverse([value | result_list])
        [_head | tail] = list
        result_list ++ tail
    end
  end

  def range(from, to) do
    range_build([], from, to)
  end

  defp range_build(range, from, to) when from > to, do: range

  defp range_build(range, from, to) do
    range_build([to | range], from, to - 1)
  end

  def swap(list) do
    swap_do(list, [])
  end

  defp swap_do([item1, item2 | tail], swapped_list) do
    swap_do(tail, [item1, item2 | swapped_list])
  end

  defp swap_do([_], _), do: raise "Can't swap list with odd number of elements"

  defp swap_do(_, swapped_list) do
    Enum.reverse(swapped_list)
  end
end

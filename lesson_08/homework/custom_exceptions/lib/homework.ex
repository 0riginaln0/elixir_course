defmodule IndexOutOfBoundsError do
  defexception [:index, :bounds]

  @impl true
  def exception({index, bounds}) do
    %__MODULE__{index: index, bounds: bounds}
  end

  @impl true
  def message(exception) do
    %{index: index, bounds: bounds} = exception
    "index #{index} is out of bounds [#{bounds.first}-#{bounds.last + 1})"
  end
end

defmodule Homework do
  @spec get_from_list!([any()], integer()) :: any()
  def get_from_list!(list, index) do
    valid_indexes = get_valid_indexes(list)

    if index in valid_indexes do
      Enum.at(list, index)
    else
      raise IndexOutOfBoundsError, {index, valid_indexes}
    end
  end

  @spec get_from_list([any()], integer()) :: {:ok, any()} | {:error, String.t()}
  def get_from_list(list, index) do
    valid_indexes = get_valid_indexes(list)

    if index in valid_indexes do
      {:ok, Enum.at(list, index)}
    else
      {:error,
       "index #{index} is out of bounds [#{valid_indexes.first}-#{valid_indexes.last + 1})"}
    end
  end

  defp get_valid_indexes(list), do: 0..(length(list) - 1)

  @spec get_many_from_list!([any()], [integer()]) :: [any()]
  def get_many_from_list!(list, indices) do
    Enum.map(indices, &get_from_list!(list, &1))
  end

  @spec get_many_from_list!([any()], [integer()]) :: {:ok, [any()]} | {:error, String.t()}
  def get_many_from_list(list, indices) do
    case do_get_many_from_list(list, indices) do
      result when is_list(result) -> {:ok, Enum.reverse(result)}
      reason -> {:error, reason}
    end
  end

  def do_get_many_from_list(list, indices) do
    Enum.reduce_while(indices, [], fn index, acc ->
      case get_from_list(list, index) do
        {:ok, element} -> {:cont, [element | acc]}
        {:error, reason} -> {:halt, reason}
      end
    end)
  end
end

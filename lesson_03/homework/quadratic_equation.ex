defmodule QuadraticEquation do
  @moduledoc """
  https://en.wikipedia.org/wiki/Quadratic_equation
  """

  @doc """
  function accepts 3 integer arguments and returns:
  {:roots, root_1, root_2} or {:root, root_1} or :no_root

  ## Examples
  iex> QuadraticEquation.solve(1, -2, -3)
  {:roots, 3.0, -1.0}
  iex> QuadraticEquation.solve(3, 5, 10)
  :no_roots
  """
  def solve(a, b, c) do
    d = b * b - 4 * a * c

    cond do
      d > 0 ->
        x1 = (-b + :math.sqrt(d)) / (2 * a)
        x2 = (-b - :math.sqrt(d)) / (2 * a)
        {:roots, x1, x2}

      equal?(d, 0) ->
        {:root, -(b / (2 * a))}

      true ->
        :no_roots
    end
  end

  def equal?(f1, f2, precision \\ 0.01) do
    abs(f1 - f2) < precision
  end
end

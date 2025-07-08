defmodule TailRecursion do
	def factorial(0), do: 1
  def factorial(n) do
    if rem(n, 10_000) == 0, do: report_memory()
    n * factorial(n - 1)
  end

  def factorial_t(n) do
    factorial_t(n, 1)
  end

  defp factorial_t(0, acc) do
    acc
  end
  defp factorial_t(n, acc) do
    if rem(n, 10_000) == 0, do: report_memory()
    factorial_t(n-1, n * acc)
  end

  def report_memory() do
    res = :erlang.process_info(self(), [:memory, :total_heap_size, :stack_size])
    dbg(res)
  end

  def sum_list([]) do
    0
  end
  def sum_list([head | tail]) do
    report_memory()
    head + sum_list(tail)
  end

  def sum_list_t(list) do
    sum_list_t(list, 0)
  end
  def sum_list_t([], acc), do: acc
  def sum_list_t([head | tail], acc) do
    report_memory()
    sum_list_t(tail, head + acc)
  end
  
end
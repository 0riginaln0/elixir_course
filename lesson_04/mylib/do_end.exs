defmodule DoEnd do
  def my_fun(arg1, options) do
    dbg(arg1)
    dbg(options)
  end

  def if_1(condition) do
    branch_1 =
      (
        a = 42
        {:branch1, a}
      )

    branch_2 =
      (
        b = 100
        {:branch2, b + 10}
      )

    if(condition, do: branch_1, else: branch_2)
  end

  def(some_fun(arg1, arg2),
    do:
      (
        a = arg1 + arg2
        a + 42
      )
  )

  
  defmodule(MyModule, [{:do, (def f1(), do: 42; def f2(), do: 100)}])

end

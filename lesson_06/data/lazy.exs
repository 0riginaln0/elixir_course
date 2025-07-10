defmodule Lazy do
  def get_longest_term(file) do
    File.read!(file)
    |> String.split("\n")
    |> Enum.map(fn line -> String.split(line, ":") end)
    |> Enum.map(fn [term, _] -> term end)
    |> Enum.map(fn term -> {String.length(term), term} end)
    |> Enum.max_by(fn {len, _} -> len end)
    |> elem(1)
  end

  def get_longest_term_lazy(file) do
    File.stream!(file)
    |> Stream.map(fn line -> String.split(line, ":") end)
    |> Stream.map(fn [term, _] -> term end)
    |> Stream.map(fn term -> {String.length(term), term} end)
    |> Enum.max_by(fn {len, _} -> len end)
    |> elem(1)
  end

  def test_data do
    [
      {"Bob", 24},
      {"Bill", 25},
      {"Kate", 26},
      {"Helen", 34},
      {"Yury", 16}
    ]
  end

  def make_table(data) do
    styles =
      Stream.cycle([
        # white
        ~s|style="background-color: #ffffff;"|,
        # gray
        ~s|style="background-color: #f2f2f2;"|
      ])

    iterator = Stream.iterate(1, fn i -> i + 1 end)

    rows =
      Stream.zip(styles, iterator)
      |> Stream.zip(data)
      |> Enum.map(fn {{style, index}, {name, age}} ->
        """
        <tr #{style}>
          <td>#{index}</td>
          <td>#{name}</td>
          <td>#{age}</td>
        </tr>
        """
      end)
      |> Enum.join("\n")

    """
    <table style="border-collapse: collapse; text-align: center;" border="1" cellpadding="6">
    #{rows}
    </table>
    """
  end

  def make_table_2(users) do
    initial_state = {true, 1}

    unfolder = fn {odd, index} ->
      value = %{odd: odd, index: index}
      new_state = {not odd, index + 1}
      {value, new_state}
    end

    rows =
      Stream.unfold(initial_state, unfolder)
      |> Stream.zip(users)
      |> Enum.map(fn {state, user} ->
        style =
          if state.odd,
            do: ~s|style="background-color: #ffffff;"|,
            else: ~s|style="background-color: #f2f2f2;"|

        {name, age} = user

        """
        <tr #{style}>
          <td>#{state.index}</td>
          <td>#{name}</td>
          <td>#{age}</td>
        </tr>
        """
      end)
      |> Enum.join("\n")

    """
    <table style="border-collapse: collapse; text-align: center;" border="1" cellpadding="6">
    #{rows}
    </table>
    """
  end
end

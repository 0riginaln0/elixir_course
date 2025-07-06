defmodule TicTacToe do
  @type cell :: :x | :o | :f
  @type row :: {cell, cell, cell}
  @type game_state :: {row, row, row}
  @type game_result :: {:win, :x} | {:win, :o} | :no_win

  @spec valid_game?(game_state) :: boolean
  def valid_game?(state) do
    case state do
      {row1, row2, row3} -> Enum.all?([row1, row2, row3], &valid_row?/1)
      _ -> false
    end
  end

  @spec valid_row?(row) :: boolean
  defp valid_row?(row) do
    case row do
      {cell1, cell2, cell3} -> Enum.all?([cell1, cell2, cell3], &valid_cell?/1)
      _ -> false
    end
  end

  @spec valid_cell?(cell) :: boolean
  defp valid_cell?(cell) do
    cell in [:x, :o, :f]
  end

  @spec check_who_win(game_state) :: game_result
  def check_who_win(state) do
    case state do
      # Horizontal win
      {
        {w, w, w},
        {_, _, _},
        {_, _, _}
      }
      when w != :f ->
        {:win, w}

      {
        {_, _, _},
        {w, w, w},
        {_, _, _}
      }
      when w != :f ->
        {:win, w}

      {
        {_, _, _},
        {_, _, _},
        {w, w, w}
      }
      when w != :f ->
        {:win, w}

      # Vertical win
      {
        {w, _, _},
        {w, _, _},
        {w, _, _}
      }
      when w != :f ->
        {:win, w}

      {
        {_, w, _},
        {_, w, _},
        {_, w, _}
      }
      when w != :f ->
        {:win, w}

      {
        {_, _, w},
        {_, _, w},
        {_, _, w}
      }
      when w != :f ->
        {:win, w}

      # Diagonal win
      {
        {w, _, _},
        {_, w, _},
        {_, _, w}
      }
      when w != :f ->
        {:win, w}

      {
        {_, _, w},
        {_, w, _},
        {w, _, _}
      }
      when w != :f ->
        {:win, w}

      _ ->
        :no_win
    end
  end
end

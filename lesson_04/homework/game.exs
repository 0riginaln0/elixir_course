defmodule Game do
  def join_game({:user, _, _, role}) when role == :admin or role == :moderator, do: :ok

  def join_game({:user, _, age, _}) do
    if age >= 18 do
      :ok
    else
      :error
    end
  end

  def move_allowed?(current_color, figure) do
    {figure, figure_color} = figure

    if (figure == :pawn or figure == :rock) and current_color == figure_color do
      true
    else
      false
    end
  end

  def single_win?(a_win, b_win) do
    a_win != b_win
  end

  def double_win?(a_win, b_win, c_win) do
    case {a_win, b_win, c_win} do
      {true, true, false} -> :ab
      {true, false, true} -> :ac
      {false, true, true} -> :bc
      _ -> false
    end
  end
end

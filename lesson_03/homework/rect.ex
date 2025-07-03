defmodule Rect do
  def intersect(
        {:rect, left_top_1, right_bottom_1} = rect1,
        {:rect, left_top_2, right_bottom_2} = rect2
      ) do
    if !valid_rect(rect1) do
      raise "invalid rect 1"
    end

    if !valid_rect(rect2) do
      raise "invalid rect 2"
    end

    # AABB
    {:point, lt1_x, lt1_y} = left_top_1
    {:point, lt2_x, lt2_y} = left_top_2
    {:point, rb1_x, rb1_y} = right_bottom_1
    {:point, rb2_x, rb2_y} = right_bottom_2

    not (lt1_x > rb2_x or
           lt1_y < rb2_y or
           rb1_x < lt2_x or
           rb1_y > lt2_y)
  end

  def valid_rect({:rect, left_top, right_bottom}) do
    {:point, lt_x, lt_y} = left_top
    {:point, rb_x, rb_y} = right_bottom

    cond do
      lt_x > rb_x -> false
      lt_y < rb_y -> false
      true -> true
    end
  end
end

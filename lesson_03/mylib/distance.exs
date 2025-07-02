defmodule Distance do
  def distance({:point, x1, y1}, {:point, x2, y2}) do
    x_dist = x1 - x2
    y_dist = y1 - y2

    (:math.pow(x_dist, 2) + :math.pow(y_dist, 2))
    |> :math.sqrt()
  end

  def point_inside_figure?(point, {:circle, center, radius}) do
    distance(point, center) <= radius
  end

  def point_inside_figure?(
        {:point, x, y},
        {:rectangle, {:point, nw_x, nw_y}, {:point, se_x, se_y}}
      ) do
    nw_x <= x and x <= se_x and nw_y <= y and y <= se_y
  end
end

ExUnit.start()

defmodule DistanceTest do
  use ExUnit.Case
  import Distance
  Code.require_file("float_example.exs")

  test "distance" do
    assert FloatExample.equal?(distance({:point, 0, 0}, {:point, 0, 100}), 100.0)
    assert FloatExample.equal?(distance({:point, 0, 0}, {:point, 100, 0}), 100.0)
    assert FloatExample.equal?(distance({:point, 0, 0}, {:point, 3, 4}), 5.0)
  end

  test "distance crash" do
    p = {:point, 0, - 16}
    c = {:circle, {:point, 5, 5}, 20}
    assert_raise FunctionClauseError, fn -> distance(p, c) end
  end

  test "point inside circle" do
    p1 = {:point, 10, 10}
    p2 = {:point, 10, 100}
    p3 = {:point, 0, 0}
    p4 = {:point, 0, - 16}
    c = {:circle, {:point, 5, 5}, 20}

    assert point_inside_figure?(p1, c)
    refute point_inside_figure?(p2, c)
    assert point_inside_figure?(p3, c)
    refute point_inside_figure?(p4, c)
  end

  test "point inside rectangle" do
    p1 = {:point, 10, 10}
    p2 = {:point, 10, 100}
    p3 = {:point, 0, 0}
    p4 = {:point, 0, - 16}
    r = {:rectangle, {:point, 0, 0}, {:point, 20, 20}}

    assert point_inside_figure?(p1, r)
    refute point_inside_figure?(p2, r)
    assert point_inside_figure?(p3, r)
    refute point_inside_figure?(p4, r)
  end

  test "point inside figure crash" do
    p = {:point, 5, 5}
    p1 = {:point, 10, 10}
    p2 = {:point, 10, 100}
    p3 = {:point, 0, 0}
    t = {:triangle, p1, p2, p3}
    assert_raise FunctionClauseError, fn -> point_inside_figure?(p, t) end
  end
end

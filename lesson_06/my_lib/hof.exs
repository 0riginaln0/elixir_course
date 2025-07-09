defmodule HOF do
  def test_data() do
    # {:user, id, name, age}
    [
      {:user, 1, "Bob", 15},
      {:user, 2, "Bill", 25},
      {:user, 3, "Helen", 10},
      {:user, 4, "Kate", 11},
      {:user, 5, "Yura", 31},
      {:user, 6, "Dima", 65},
      {:user, 7, "Yana", 35},
      {:user, 8, "Diana", 41}
    ]
  end

  def split_by_age(users, age_limit) do
    Enum.reduce(users, {[], []}, fn {:user, _, _, age} = user, {younger, older} ->
      if age < age_limit do
        {[user | younger], older}
      else
        {younger, [user | older]}
      end
    end)
  end

  def get_avg_age(users) do
    {num_users, total_age} =
      Enum.reduce(users, {0, 0}, &avg_age_reducer/2)

    total_age / num_users
  end

  def avg_age_reducer({:user, _, _, age}, {num_users, total_age}) do
    {num_users + 1, total_age + age}
  end

  def get_oldest_user(users) do
    Enum.reduce(users, fn curr_user, acc ->
      {:user, _, _, curr_age} = curr_user
      {:user, _, _, max_age} = acc

      if curr_age > max_age do
        curr_user
      else
        acc
      end
    end)
  end

  # Enum
  # List, Map, Range, Tuple. String
  # protocol Enumerable

  @type user :: {:user, integer(), String.t(), integer()}
  @type attr_type :: :id | :name | :age
  @type direction :: :asc | :desc

  @spec sort_by_attr([user()], attr_type(), direction()) :: [user()]
  def sort_by_attr(users, attr, direction) do
    sorter =
      case {attr, direction} do
        {:id, :asc} -> &compare_by_id/2
        {:id, :desc} -> invertor(&compare_by_id/2)
        {:name, :asc} -> &compare_by_name/2
        {:name, :desc} -> invertor(&compare_by_name/2)
        {:age, :asc} -> &compare_by_age/2
        {:age, :desc} -> invertor(&compare_by_age/2)
      end

    Enum.sort(users, sorter)
  end

  def compare_by_id(user1, user2) do
    {:user, id1, _, _} = user1
    {:user, id2, _, _} = user2
    id1 < id2
  end

  def compare_by_name(user1, user2) do
    {:user, _, name1, _} = user1
    {:user, _, name2, _} = user2
    name1 < name2
  end

  def compare_by_age(user1, user2) do
    {:user, _, _, age1} = user1
    {:user, _, _, age2} = user2
    age1 < age2
  end

  def invertor(predicate) do
    fn arg1, arg2 -> not predicate.(arg1, arg2) end
  end

  def group_users(users) do
    grouper = fn {:user, _, _, age} ->
      cond do
        age <= 14 -> :child
        age > 14 and age <= 18 -> :teen
        age > 18 -> :adult
        true -> :old
      end
    end

    Enum.group_by(users, grouper)
  end
end

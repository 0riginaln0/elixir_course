defmodule RecursionWithAcc do
  def test_data() do
    # {:user, id, name, age}
    [
      {:user, 1, "Bob", 23},
      {:user, 2, "Helen", 20},
      {:user, 3, "Bill", 15},
      {:user, 4, "Kate", 14},
      {:user, 5, "Yury", 46}
    ]
  end

  def filter_adults(users) do
    filter_adults(users, [])
  end

  defp filter_adults([], acc), do: Enum.reverse(acc)

  defp filter_adults([user | users], acc) do
    {:user, _id, _name, age} = user

    if age >= 16 do
      filter_adults(users, [user | acc])
    else
      filter_adults(users, acc)
    end
  end

  def get_id_name(users) do
    get_id_name(users, [])
  end

  defp get_id_name([], acc) do
    Enum.reverse(acc)
  end

  defp get_id_name([user | users], acc) do
    {:user, id, name, _age} = user
    get_id_name(users, [{id, name} | acc])
  end

  def split_adults_and_childs(users) do
    acc = %{
      adults: [],
      childs: []
    }
    split_adults_and_childs(users, acc)
  end

  defp split_adults_and_childs([], acc) do
    %{
      adults: Enum.reverse(acc.adults),
      childs: Enum.reverse(acc.childs)
    }
  end

  defp split_adults_and_childs([user | users], acc) do
    {:user, _id, _name, age} = user
    new_acc = if age >= 16 do
      update_in(acc.adults, fn list -> [user | list] end)
    else
      update_in(acc.childs, fn list -> [user | list] end)
    end
    split_adults_and_childs(users, new_acc)
  end

  def get_average_age(users) do
    total_age = get_total_age(users, 0)
    total_users = length(users)
    total_age / total_users
  end

  defp get_total_age([], total_age) do
    total_age
  end
  defp get_total_age([user | users], total_age) do
    {:user, _, _, age} = user
    get_total_age(users, age + total_age)
  end

end

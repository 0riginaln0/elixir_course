defmodule ChatRoom do
  alias ChatRoomModel, as: M

  @spec join_room(M.user_name(), M.room_name()) :: :ok | {:error, atom}
  def join_room(user_name, room_name) do
    case get_user(user_name) do
      {:ok, user} -> join_room_for_user(user, room_name)
      {:error, _} -> {:error, :user_not_found}
    end
  end

  defp join_room_for_user(user, room_name) do
    case get_room(room_name) do
      {:ok, room} -> check_room_access(user, room)
      {:error, _} -> {:error, :room_not_found}
    end
  end

  defp check_room_access(user, room) do
    cond do
      reached_limit?(room) -> {:error, :room_reached_limit}
      public?(room) -> :ok
      member?(user, room) -> :ok
      true -> {:error, :not_allowed}
    end
  end

  @users [
    %M.User{name: "User 1"},
    %M.User{name: "User 2"},
    %M.User{name: "User 3"}
  ]

  @rooms [
    %M.Room{name: "Room 1", type: :public},
    %M.Room{name: "Room 2", type: :private, members: ["User 1", "User 2"]},
    %M.Room{name: "Room 3", type: :public, limit: 10}
  ]

  @online %{
    "Room 1" => 60,
    "Room 2" => 30,
    "Room 3" => 10
  }

  @spec get_user(M.user_name()) :: {:ok, M.User.t()} | {:error, :not_found}
  def get_user(name) do
    res =
      Enum.find(
        @users,
        fn user -> user.name == name end
      )

    if res, do: {:ok, res}, else: {:error, :not_found}
  end

  @spec get_room(M.room_name()) :: {:ok, M.Room.t()} | {:error, :not_found}
  def get_room(name) do
    res =
      Enum.find(
        @rooms,
        fn %M.Room{name: room_name} -> room_name == name end
      )

    if res, do: {:ok, res}, else: {:error, :not_found}
  end

  @spec public?(M.Room.t()) :: boolean
  def public?(room), do: room.type == :public

  @spec member?(M.User.t(), M.Room.t()) :: boolean
  def member?(user, room) do
    Enum.member?(room.members, user.name)
  end

  @spec reached_limit?(M.Room.t()) :: boolean
  def reached_limit?(room) do
    room.limit <= @online[room.name]
  end
end

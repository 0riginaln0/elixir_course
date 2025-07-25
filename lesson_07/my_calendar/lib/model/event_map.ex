defmodule Model.EventMap do
  # Meeting:
  # - place
  # - time
  # - participants
  # - agenda

  # - place: Office #1, 7th floor, room #1
  # - time: 11 Jule 2026 15:00
  # - participants: Vasya, Petya, Lena
  # - agenda: interview candidate, discuss tomorrow weather.
  defmodule Place do
    def new(office, room) do
      %{
        office: office,
        room: room
      }
    end
  end

  defmodule Participant do
    def new(name, role) do
      %{
        name: name,
        role: role
      }
    end
  end

  defmodule Topic do
    def new(title, description) do
      %{
        title: title,
        description: description
      }
    end
  end

  defmodule Event do
    alias Model.CalendarItem

    def new(title, place, time, participants, agenda) do
      %{
        title: title,
        place: place,
        time: time,
        participants: participants,
        agenda: agenda
      }
    end

    def add_participant(event, participant) do
      Map.update(
        event,
        :participants,
        [],
        fn participants -> [participant | participants] end
      )
    end

    defimpl CalendarItem, for: Map do
      @spec get_title(CalendarItem.t()) :: String.t()
      def get_title(item), do: Map.get(item, :title, "No Title")

      @spec get_time(CalendarItem.t()) :: DateTime.t()
      def get_time(item), do: Map.get(item, :time)
    end
  end

  # get_in, put_in, update_in
  # Access
end

defmodule Model.EventStruct do
  defmodule Place do
    @behaviour Access

    defstruct [:office, :room]

    @impl true
    def fetch(place, :office), do: {:ok, place.office}
    def fetch(place, :room), do: {:ok, place.room}
    def fetch(_place, _), do: :error

    @impl true
    def get_and_update(place, :office, f) do
      {curr_val, new_val} = f.(place.office)
      new_place = %Place{place | office: new_val}
      {curr_val, new_place}
    end

    def get_and_update(place, _, _f) do
      {nil, place}
    end

    @impl true
    def pop(data, _key) do
      # TODO
      data
    end
  end

  defmodule Participant do
    @enforce_keys [:name, :role]
    defstruct [:name, :role]
  end

  defmodule Topic do
    @enforce_keys [:title]
    defstruct [
      :title,
      :description,
      {:priority, :medium}
    ]
  end

  defmodule Event do
    alias Model.CalendarItem
    @enforce_keys [:title, :place, :time]
    defstruct [
      :title,
      :place,
      :time,
      {:participants, []},
      {:agenda, []}
    ]

    def add_participant(
          %Event{participants: participants} = event,
          %Participant{} = participant
        ) do
      participants = [participant | participants]
      %Event{event | participants: participants}
    end

    def replace_participant(
          %Event{participants: participants} = event,
          %Participant{} = new_participant
        ) do
      participants = Enum.filter(participants, fn p -> p.name != new_participant.name end)
      participants = [new_participant | participants]
      %Event{event | participants: participants}
    end

    defimpl CalendarItem do
      @spec get_title(CalendarItem.t()) :: String.t()
      def get_title(event), do: event.title

      @spec get_time(CalendarItem.t()) :: DateTime.t()
      def get_time(event), do: event.time
    end
  end
end

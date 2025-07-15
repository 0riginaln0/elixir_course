defmodule Model.EventTypedStruct do
  defmodule Place do
    @type t() :: %__MODULE__{
            office: String.t(),
            room: String.t()
          }
    @enforce_keys [:office, :room]
    defstruct [:office, :room]
  end

  defmodule Participant do
    @type t() :: %__MODULE__{
            name: String.t(),
            role: atom()
          }
    @enforce_keys [:name, :role]
    defstruct [:name, :role]
  end

  defmodule Topic do
    @type t() :: %__MODULE__{
            title: String.t(),
            description: String.t(),
            priority: :hight | :medium | :low
          }
    @enforce_keys [:title]
    defstruct [
      :title,
      :description,
      {:priority, :medium}
    ]
  end

  defmodule Event do
    @type t() :: %__MODULE__{
            title: String.t(),
            place: Place.t(),
            time: DateTime.t(),
            participants: [Participant.t()],
            agenda: [Topic.t()]
          }
    @enforce_keys [:title, :place, :time]
    defstruct [
      :title,
      :place,
      :time,
      {:participants, []},
      {:agenda, []}
    ]

    @spec add_participant(Event.t(), Participant.t()) :: Event.t()
    def add_participant(event, _participant) do
      event
    end
  end
end

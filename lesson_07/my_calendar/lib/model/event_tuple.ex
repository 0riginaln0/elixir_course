defmodule Model.EventTuple do
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
      {:place, office, room}
    end
  end

  defmodule Participant do
    def new(name, role) do
      {:participant, name, role}
    end

  end

  defmodule Topic do
    def new(title, description) do
      {:topic, title, description}
    end
  end

  defmodule Event do
    def new(title, place, time, participants, agenda) do
      {:event, title, place, time, participants, agenda}
    end
  end
end

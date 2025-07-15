defmodule MyCalendar do
  @moduledoc """
  Meeting:
    - place
    - time
    - participants
    - agenda

    - place: Office #1, 7th floor, room #1
    - time: 11 Jule 2025 15:00
    - participants: Vasya, Petya, Lena
    - agenda: interview candidate, discuss tomorrow weather.

  Tuples, Lists
  Dicts,
  Structs,
  Typed structs

  """

  def sample_event_tuple() do
    alias Model.EventTuple, as: T

    place = T.Place.new("Office #1", "Room 42")
    time = ~U[2025-07-11 15:00:00Z]

    participants = [
      T.Participant.new("Bob", :project_manager),
      T.Participant.new("Petya", :developer),
      T.Participant.new("Kate", :qa),
      T.Participant.new("Helen", :devops)
    ]

    agenda = [
      T.Topic.new("Interview", "candidate for developer position"),
      T.Topic.new("Weather", "discuss tomorrow weather"),
      T.Topic.new("COokies", "what to buy")
    ]

    T.Event.new("Weekly Team Meeting", place, time, participants, agenda)
  end

  def sample_event_map() do
    alias Model.EventMap, as: M

    place = M.Place.new("Office #1", "Room 42")
    time = ~U[2025-07-11 15:00:00Z]

    participants = [
      M.Participant.new("Bob", :project_manager),
      M.Participant.new("Petya", :developer),
      M.Participant.new("Kate", :qa),
      M.Participant.new("Helen", :devops)
    ]

    agenda = [
      M.Topic.new("Interview", "candidate for developer position"),
      M.Topic.new("Weather", "discuss tomorrow weather"),
      M.Topic.new("COokies", "what to buy")
    ]

    M.Event.new("Weekly Team Meeting", place, time, participants, agenda)
  end

  def sample_event_struct() do
    alias Model.EventStruct, as: S

    place = %S.Place{office: "Office #1", room: "Room 42"}
    time = ~U[2025-07-11 15:00:00Z]

    participants = [
      %S.Participant{name: "Bob", role: :project_manager},
      %S.Participant{name: "Petya", role: :developer},
      %S.Participant{name: "Kate", role: :qa},
      %S.Participant{name: "Helen", role: :devops}
    ]

    agenda = [
      %S.Topic{
        title: "Interview",
        description: "candidate for developer position",
        priority: :high
      },
      %S.Topic{title: "Weather", description: "discuss tomorrow weather"}
    ]

    %S.Event{
      title: "Weekly Team Meeting",
      place: place,
      time: time,
      participants: participants,
      agenda: agenda
    }
  end

  def sample_event_typed_struct() do
    alias Model.EventTypedStruct, as: TS

    place = %TS.Place{office: "Office #1", room: "Room 42"}
    time = ~U[2025-07-11 15:00:00Z]

    participants = [
      %TS.Participant{name: "Bob", role: :project_manager},
      %TS.Participant{name: "Petya", role: :developer},
      %TS.Participant{name: "Kate", role: :qa},
      %TS.Participant{name: "Helen", role: :devops}
    ]

    agenda = [
      %TS.Topic{
        title: "Interview",
        description: "candidate for developer position",
        priority: :high
      },
      %TS.Topic{title: "Weather", description: "discuss tomorrow weather"}
    ]

    event = %TS.Event{
      title: "Weekly Team Meeting",
      place: place,
      time: time,
      participants: participants,
      agenda: agenda
    }

    TS.Event.add_participant(event, nil)

    event
  end
end

defmodule Model do
  defmodule Calendar do
    alias Model.CalendarItem

    @type t :: %__MODULE__{
            items: [CalendarItem.t()]
          }

    @enforce_keys [:items]
    defstruct [:items]

    @spec add_item(Calendar.t(), CalendarItem.t()) :: Calendar.t()
    def add_item(calendar, item) do
      items = [item | calendar.items]
      %__MODULE__{calendar | items: items}
    end

    @spec show(Calendar.t()) :: String.t()
    def show(calendar) do
      Enum.map(
        calendar.items,
        fn item ->
          title = CalendarItem.get_title(item)
          time = CalendarItem.get_time(item) |> DateTime.to_iso8601()
          "#{title} at #{time}"
        end
      )
      |> Enum.join("\n")
    end
  end

  defprotocol CalendarItem do
    @spec get_title(CalendarItem.t()) :: String.t()
    def get_title(item)

    @spec get_time(CalendarItem.t()) :: DateTime.t()
    def get_time(item)
  end
end

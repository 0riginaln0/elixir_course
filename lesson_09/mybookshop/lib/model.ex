defmodule Model do
  defmodule Cat do
    defstruct [:id, :name]

    @type t :: %__MODULE__{id: String.t, name: String.t}
  end

  defmodule Address do
    defstruct [:state, :city, :other]

    @type t :: %__MODULE__{state: String.t, city: String.t, other: String.t}
  end

  defmodule Book do
    defstruct [:title, :author]

    @type t :: %__MODULE__{title: String.t, author: String.t}
  end

  defmodule Order do
    defstruct [:client, :address, :books]

    @type t :: %__MODULE__{client: String.t, address: String.t, books: String.t}

    def create(client, address, books) do
      %__MODULE__{
        client: client,
        address: address,
        books: books
      }
    end
  end
end

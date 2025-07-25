defmodule AuthData do
  #@derive {Inspect, except: [:password]}
	defstruct [:login, :password]

  defimpl Inspect do
    alias Inspect.Algebra, as: A

    def inspect(data, opts) do
      A.concat(["AuthData<", A.to_doc(data.login, opts), ">"])
    end
  end

  defimpl String.Chars do
    def to_string(data) do
      "AuthData, login: #{data.login}"
    end
  end
end

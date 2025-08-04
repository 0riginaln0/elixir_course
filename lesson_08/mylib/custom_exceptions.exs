defmodule CustomExceptions do

  def request1(), do: %{token: "aaa", data: %{a: 42}}


  defmodule Controller do
    alias CustomExceptions.Model, as: M

    def handle(request) do
      try do
        authorize(request)
        authentificate(request)
        validate(request)
        result = do_something_useful(request)
        {200, result}
      rescue
        error in [M.AuthentificationError, M.AuthorizationError] ->
          {403, Exception.message(error)}

        error in [M.SchemaValidationError] ->
          {409, Exception.message(error)}

        error ->
          IO.puts(Exception.format(:error, error, __STACKTRACE__))
          {500, "Internal Server Error"}
      end
    end

    def authorize(request) do
      case request.token do
        "aaa" -> :ok
        "bbb" -> :ok
        _ -> raise M.AuthorizationError, {:token, request.token}
      end
    end

    def authentificate(request) do
      case request.token do
        "aaa" -> :ok
        _ -> raise M.AuthorizationError, {:guest, :reconfigure}
      end
    end

    def validate(request) do
      if Map.has_key?(request, :data) do
        :ok
      else
        raise M.SchemaValidationError, "some_schema.json"
      end
    end

    def do_something_useful(%{data: %{a: 100}}) do
      raise "Something happened"
    end

    def do_something_useful(%{data: %{a: a}}) do
      "handler #{a}"
    end
  end

  defmodule Model do
    defmodule AuthentificationError do
      @enforce_keys [:type]
      defexception [:type, :token, :login]

      @impl true
      def exception({type, data}) do
        case type do
          :token -> %__MODULE__{type: :token, token: data}
          :login -> %__MODULE__{type: :login, login: data}
        end
      end

      @impl true
      def message(exception) do
        case exception.type do
          :token -> "AuthentificationError: invalid token"
          :login -> "AuthentificationError: invalid login"
        end
      end
    end

    defmodule AuthorizationError do
      @enforce_keys [:role, :action]
      defexception [:role, :action]

      @impl true
      def exception({role, action}) do
        %__MODULE__{role: role, action: action}
      end

      @impl true
      def message(exception) do
        "AuthorizationError: role #{exception.role} is not allowed to do action #{exception.action}"
      end
    end

    defmodule SchemaValidationError do
      defexception [:schema_name]

      @impl true
      def exception(schema_name) do
        %__MODULE__{schema_name: schema_name}
      end

      @impl true
      def message(exception) do
        "SchemaValidationError: data does not match schema #{exception.schema_name}"
      end
    end
  end
end

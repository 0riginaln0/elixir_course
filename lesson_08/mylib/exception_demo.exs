defmodule ExceptionDemo do
  def try_rescue(exc_type) do
    try do
      generate_exception(exc_type)
    catch
      err_type, error ->
        IO.puts("clause 3, Unknown error #{inspect(err_type)} - #{error}")
    after
      IO.puts("After is always called")
    end
  end

  def generate_exception(:raise), do: raise("sh")
  def generate_exception(:throw), do: throw("sh")
  def generate_exception(:error), do: :erlang.error("sh")
  def generate_exception(:exit), do: exit("sh")

  def start_server() do
    GenServer.start(MyServer, [], name: MyServer)
  end

  def hello() do
    GenServer.call(MyServer, {:hello, 101})
  end
end

defmodule MyServer do
   use GenServer

   @impl true
   def init(_) do
     state = %{}
     {:ok, state}
   end

   @impl true
   def handle_call({:hello, data}, _from, state) do
      IO.puts("MyServer got message :hello with data #{inspect data}")
      response = 42
      {:reply, response, state}
   end

   def handle_call(:get_something, _from, state) do
      IO.puts("MyServer got message :get_something")
      :timer.sleep(6000)
      response = 24
      {:reply, response, state}
   end
end

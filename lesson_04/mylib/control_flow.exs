defmodule ControlFlow do
  def handle(animal, action) do
    case animal do
      {:dog, name} ->
        case action do
          :feed -> IO.puts("feed the dog #{name}")
          :pet -> IO.puts("pet the dog #{name}")
        end

      {:cat, name} ->
        case action do
          :feed -> IO.puts("feed the cat #{name}")
          :pet -> IO.puts("pet the cat #{name}")
        end

      {:rat, name} ->
        case action do
          :feed -> IO.puts("feed the rat #{name}")
          :pet -> IO.puts("pet the rat #{name}")
        end
    end
  end

  def handle2(animal, action) do
    case {animal, action} do
      {{:dog, name}, :feed} -> IO.puts("feed the dog #{name}")
      {{:dog, name}, :pet} -> IO.puts("ped the dog #{name}")
      {{:cat, name}, :feed} -> IO.puts("feed the cat #{name}")
      {{:cat, name}, :pet} -> IO.puts("ped the cat #{name}")
      {{:rat, name}, :feed} -> IO.puts("feed the rat #{name}")
      {{:rat, name}, :pet} -> IO.puts("ped the rat #{name}")
    end
  end

  def handle3({:dog, name}, :feed) do
    IO.puts("feed the dog #{name}")
  end

  def handle3({:dog, name}, :pet) do
    IO.puts("feed the dog #{name}")
  end

  def handle3({:cat, name}, :feed) do
    IO.puts("feed the cat #{name}")
  end

  def handle3({:cat, name}, :pet) do
    IO.puts("feed the cat #{name}")
  end

  def handle3({animal_type, name}, action) do
    IO.puts("do action '#{action}' with animal '#{inspect(animal_type)}' #{name}")
  end
end

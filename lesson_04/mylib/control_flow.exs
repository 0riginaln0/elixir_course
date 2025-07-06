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

  def handle4(animal) do
    case animal do
      {:dog, name, age} when age <= 2 ->
        IO.puts("dog #{name} is a young dog")

      {:dog, name, age} ->
        IO.puts("dog #{name} is an adult")

      {:cat, name, age} when age > 10 ->
        IO.puts("cat #{name} is an old cat")

      {:cat, name, age} ->
        IO.puts("cat #{name} is not so old")
    end
  end

  def handle5({:dog, name, age}) when age <= 2 do
    IO.puts("dog #{name} is a young dog")
  end

  def handle5({:dog, name, age}) do
    IO.puts("dog #{name} is an adult")
  end

  def handle6({:library, rating, books}) when rating > 4 and length(books) > 2 do
    IO.puts("a good library")
  end

  def handle6({:library, rating, books}) when rating > 4 or length(books) > 2 do
    IO.puts("Not so good library")
  end

  def handle6({:library, rating, books}) do
    IO.puts("not recommended")
  end

  # Подключает макросы, определённые в модуле Integer
  require Integer

  def handle7(a) when Integer.is_odd(a) do
    IO.puts("#{a} is odd")
  end

  def handle7(a) when Integer.is_even(a) do
    IO.puts("#{a} is even")
  end

  def handle8(a, b) when 10 / a > 2 do
    {:clause_1, b}
  end

  def handle8(a, b) do
    {:clause_2, b}
  end

  def handle10(num) do
    cond do
      num > 10 -> IO.puts("num is more than 10")
      num > 5 -> IO.puts("num is more than 5")
      true -> IO.puts("num is 5 or less")
    end
  end

  def handle11(num) do
    if num > 5 do
      IO.puts("num is more than 5")
    end
  end

  def fizzbuzz(n) do
    devisible_by_3 = rem(n, 3) == 0
    devisible_by_5 = rem(n, 5) == 0

    case n do
      _ when devisible_by_3 and devisible_by_5 -> "FizzBuzz"
      _ when devisible_by_3 -> "Fizz"
      _ when devisible_by_5 -> "Buzz"
      _ -> to_string(n)
    end
  end

  def divisible_by?(n, d), do: rem(n, d) == 0
end

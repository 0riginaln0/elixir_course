defmodule Controller do
  alias Model, as: M

  @spec validate_incoming_data(map()) :: {:ok, map()} | {:error, :invalid_incoming_data}
  def validate_incoming_data(data) do
    if rand_success() do
      {:ok, data}
    else
      {:error, :invalid_incoming_data}
    end
  end


  @spec validate_cat(name :: String.t()) :: {:ok, M.Cat.t()} | {:error, :cat_not_found}
  def validate_cat(name) do
    if rand_success() do
      {:ok, %M.Cat{name: name, id: name}}
    else
      {:error, :cat_not_found}
    end
  end

  @spec validate_address(data :: String.t()) :: {:ok, M.Address.t()} | {:error, :invalid_address}
  def validate_address(data) do
    if rand_success() do
      {:ok, %M.Address{other: data}}
    else
      {:error, :invalid_address}
    end
  end

  @spec validate_book(data :: map()) :: {:ok, M.Book.t()} | {:error, :book_not_found}
  def validate_book(data) do
    if rand_success() do
      {:ok, %M.Book{title: data["title"], author: data["author"]}}
    else
      {:error, :book_not_found}
    end
  end

  def rand_success do
    Enum.random(1..10) > 1
  end
end
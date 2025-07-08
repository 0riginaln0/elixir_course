ExUnit.start()

defmodule TrimTest do
  use ExUnit.Case
  doctest Trim
  import Trim

  test "trim binary" do
    assert trim("") == ""
    assert trim("a") == "a"
    assert trim(" ") == ""
    assert trim("   ") == ""
    assert trim("hello") == "hello"
    assert trim("  hello") == "hello"
    assert trim("hello  ") == "hello"
    assert trim("  hello  ") == "hello"
    assert trim("  hello  there  ") == "hello  there"
    assert trim("  check for  spaces   in  the middle  ") == "check for  spaces   in  the middle"
    assert trim(" Привет мир! ") == "Привет мир!"
    assert trim("ё") == "ё"
    assert trim(" ё ") == "ё"

    assert trim(" Ёу, проверим пробелы  в середине     сроки!   ") ==
             "Ёу, проверим пробелы  в середине     сроки!"
  end

  test "trim list" do
    assert trim(~c"") == ~c""
    assert trim(~c"a") == ~c"a"
    assert trim(~c" ") == ~c""
    assert trim(~c"   ") == ~c""
    assert trim(~c"hello") == ~c"hello"
    assert trim(~c"  hello") == ~c"hello"
    assert trim(~c"hello  ") == ~c"hello"
    assert trim(~c"  hello  ") == ~c"hello"
    assert trim(~c"  hello  there  ") == ~c"hello  there"

    assert trim(~c"  check for  spaces   in  the middle  ") ==
             ~c"check for  spaces   in  the middle"

    assert trim(~c" Привет мир! ") == ~c"Привет мир!"
    assert trim(~c"ё") == ~c"ё"
    assert trim(~c" ё ") == ~c"ё"

    assert trim(~c" Ёу, проверим пробелы  в середине     сроки!   ") ==
             ~c"Ёу, проверим пробелы  в середине     сроки!"
  end

  test "effective trim list" do
    assert effective_trim(~c"") == ~c""
    assert effective_trim(~c"a") == ~c"a"
    assert effective_trim(~c" ") == ~c""
    assert effective_trim(~c"   ") == ~c""
    assert effective_trim(~c"hello") == ~c"hello"
    assert effective_trim(~c"  hello") == ~c"hello"
    assert effective_trim(~c"hello  ") == ~c"hello"
    assert effective_trim(~c"  hello  ") == ~c"hello"
    assert effective_trim(~c"  hello  there  ") == ~c"hello  there"

    assert effective_trim(~c"  check for  spaces   in  the middle  ") ==
             ~c"check for  spaces   in  the middle"

    assert effective_trim(~c" Привет мир! ") == ~c"Привет мир!"
    assert effective_trim(~c"ё") == ~c"ё"
    assert effective_trim(~c" ё ") == ~c"ё"

    assert effective_trim(~c" Ёу, проверим пробелы  в середине     сроки!   ") ==
             ~c"Ёу, проверим пробелы  в середине     сроки!"
  end

  test "effective trim binary" do
    assert effective_trim("") == ""
    assert effective_trim("a") == "a"
    assert effective_trim(" ") == ""
    assert effective_trim("   ") == ""
    assert effective_trim("hello") == "hello"
    assert effective_trim("  hello") == "hello"
    assert effective_trim("hello  ") == "hello"
    assert effective_trim("  hello  ") == "hello"
    assert effective_trim("  hello  there  ") == "hello  there"

    assert effective_trim("  check for  spaces   in  the middle  ") ==
             "check for  spaces   in  the middle"

    assert effective_trim(" Привет мир! ") == "Привет мир!"
    assert effective_trim("ё") == "ё"
    assert effective_trim(" ё ") == "ё"

    assert effective_trim(" Ёу, проверим пробелы  в середине     сроки!   ") ==
             "Ёу, проверим пробелы  в середине     сроки!"
  end
end

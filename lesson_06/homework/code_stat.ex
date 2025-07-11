defmodule CodeStat do
  @types [
    {"Elixir", [".ex", ".exs"]},
    {"Erlang", [".erl"]},
    {"Python", [".py"]},
    {"JavaScript", [".js"]},
    {"SQL", [".sql"]},
    {"JSON", [".json"]},
    {"Web", [".html", ".htm", ".css"]},
    {"Scripts", [".sh", ".lua", ".j2"]},
    {"Configs", [".yaml", ".yml", ".conf", ".args", ".env"]},
    {"Docs", [".md"]}
  ]

  @ignore_names [".git", ".gitignore", ".idea", "_build", "deps", "log", ".formatter.exs"]

  @ignore_extensions [".beam", ".lock", ".iml", ".log", ".pyc"]

  @ignore_list @ignore_names ++ @ignore_extensions

  @max_depth 5

  def analyze(path) do
    browse_dir(%{}, path, 0)
  end

  def get_file_type(path) do
    Enum.find(@types, fn {_type_name, type_extensions} ->
      Enum.any?(type_extensions, fn type_extension ->
        String.ends_with?(path, type_extension)
      end)
    end)
  end

  def analyze_file!(acc, path) do
    case get_file_type(path) do
      {type, _} ->
        %{files: type_files, lines: type_lines, size: type_size} =
          Map.get(acc, type, %{files: 0, lines: 0, size: 0})

        Map.put(acc, type, %{
          files: type_files + 1,
          lines: type_lines + (File.read!(path) |> String.split("\n") |> length()),
          size: type_size + File.stat!(path).size
        })

      _ ->
        %{files: type_files, lines: type_lines, size: type_size} =
          Map.get(acc, "Other", %{files: 0, lines: 0, size: 0})

        Map.put(acc, "Other", %{
          files: type_files + 1,
          lines: type_lines + (File.read!(path) |> String.split("\n") |> length()),
          size: type_size + File.stat!(path).size
        })
    end
  end

  def ignore?(path) do
    Enum.any?(@ignore_list, fn ignored ->
      String.ends_with?(path, ignored)
    end)
  end

  def browse_dir(acc, _path, @max_depth), do: acc

  def browse_dir(acc, path, depth) do
    {:ok, contents} = File.ls(path)

    full_path_contents =
      Enum.map(contents, fn content ->
        Path.join(path, content)
      end)

    Enum.reduce(full_path_contents, acc, fn content, acc ->
      cond do
        ignore?(content) -> acc
        File.regular?(content) -> analyze_file!(acc, content)
        File.dir?(content) -> browse_dir(acc, content, depth + 1)
        true -> acc
      end
    end)
  end
end

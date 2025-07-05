defmodule ProgressCount do
	def update_progress!() do
    file_path = "README.md"
    content = File.read!(file_path)

    {overall_lessons, completed_lessons} = count_lessons(content)
    new_first_line = IO.inspect("Progress: #{completed_lessons}/#{overall_lessons}")
    
    lines = String.split(content, "\n")
    updated_lines = [new_first_line | Enum.drop(lines, 1)]
    updated_content = Enum.join(updated_lines, "\n")
    
    File.write(file_path, updated_content)
  end

  defp count_lessons(content) do
    overall_lessons = length(String.split(content, "- [")) - 1
    completed_lessons = length(String.split(content, "- [x")) - 1
    {overall_lessons, completed_lessons}
  end
end

ProgressCount.update_progress!()
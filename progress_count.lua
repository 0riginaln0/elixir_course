local function count_lessons(content)
    local overall_lessons = select(2, content:gsub("- %[", ""))
    local completed_lessons = select(2, content:gsub("- %[x", ""))

    return overall_lessons, completed_lessons
end

local function update_progress()
    local file_path = "README.md"
    local file = io.open(file_path, "r")
    if not file then
        error("Could not open file: " .. file_path)
    end
    local content = file:read("*a")
    file:close()

    local overall_lessons, completed_lessons = count_lessons(content)
    local new_first_line = string.format("Progress: %d/%d", completed_lessons, overall_lessons)

    local lines = {}
    for line in content:gmatch("([^\r\n]*)[\r\n]?") do
        table.insert(lines, line)
    end

    if #lines > 0 then
        lines[1] = new_first_line
    end

    local updated_content = table.concat(lines, "\n")

    file = io.open(file_path, "w")
    if not file then
        error("Could not open file for writing: " .. file_path)
    end
    file:write(updated_content)
    file:close()
end

update_progress()

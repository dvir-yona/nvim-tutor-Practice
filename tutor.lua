local json_file = "tutor.json" 

local function read_file(filename)
  local file = io.open(filename, "r")
  if not file then
    return nil, "Error opening file: " .. filename
  end
  local content = file:read("*all")
  file:close()
  return content, nil
end

local function get_random_lesson()
  local json_content, err = read_file(json_file)
  if err then
    print("Error reading JSON file: " .. err)
    return nil
  end

  local lessons = vim.json.decode(json_content)

  if not lessons or #lessons == 0 then
    print("No lessons found in JSON file or invalid JSON format.")
    return nil
  end

  math.randomseed(os.time()) -- Seed the random number generator
  local random_index = math.random(1, #lessons)
  return lessons[random_index]
end

local lesson = get_random_lesson()

if lesson then
  vim.cmd("enew")
  local current_buffer = vim.api.nvim_get_current_buf()

  local lines = vim.split(lesson.content, "\n")
  vim.api.nvim_buf_set_lines(current_buffer, 0, 0, false, lines)

  vim.api.nvim_buf_set_name(current_buffer, "Neovim Tutor Lesson: " .. lesson.lesson) 
  vim.opt_local.filetype = "md"
  print("Opened random lesson: " .. lesson.lesson)
else
  print("Failed to load a random lesson.")
end

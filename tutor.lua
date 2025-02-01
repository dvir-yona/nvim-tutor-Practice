local json_file = vim.fn.stdpath("config") .. "/nvim-tutor-Practice/tutor.json"

local function read_file(filename)
  local file = io.open(filename, "r")
  if not file then
    return nil, "Error opening file: " .. filename
  end
  local content = file:read("*all")
  file:close()
  return content, nil
end

local function get_lesson(index)
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

  if index then
    index = tonumber(index)
    if not index or index < 1 or index > #lessons then
      print("Invalid lesson index: " .. tostring(index))
      return nil
    end
    return lessons[index]
  else
    math.randomseed(os.time())
    local random_index = math.random(1, #lessons)
    return lessons[random_index]
  end
end

local function open_lesson(lesson)
  if lesson then
    local has_buffer = false
    local buffers = vim.api.nvim_list_bufs()
    for _, bufnr in ipairs(buffers) do
      if vim.api.nvim_buf_is_valid(bufnr) then
        local name = vim.api.nvim_buf_get_name(bufnr)
        if string.find(name, "Neovim Practice", 1, true) then
          vim.api.nvim_win_set_buf(0, bufnr)
          has_buffer = true
          break
        end
      end
    end
    local current_buffer = vim.api.nvim_get_current_buf()
    if not has_buffer then
	    vim.cmd("enew")
    	current_buffer = vim.api.nvim_get_current_buf()
      vim.api.nvim_buf_set_name(current_buffer, "Neovim Practice")
    else
    end
    local lines = vim.split(lesson.content, "\n")
    vim.api.nvim_buf_set_lines(current_buffer, 0, -1, false, lines)
    vim.opt_local.filetype = "md"
    print("Opened lesson: " .. lesson.lesson)
  else
    print("Failed to load lesson.")
  end
end

local tutor_module = {}

function tutor_module.open(index)
  local lesson = get_lesson(index)
  open_lesson(lesson)
end

return tutor_module

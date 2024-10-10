-- ~/.config/nvim/lua/myplugin/init.lua

-- Function to get the project name or use "curry" as a placeholder
local function get_project_name()
  local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null | xargs basename 2>/dev/null")
  if handle then
    local result = handle:read("*a")
    handle:close()
    if result:gsub("%s+", "") ~= "" then
      return result:gsub("%s+", "")
    end
  end
  return "curry"
end

-- Function to get the current year
local function get_current_year()
  return os.date("%Y")
end

-- Function to create Epitech header based on file type
local function create_epitech_header(filetype, filename)
  local project_name = get_project_name()
  local current_year = get_current_year()
  local file_description = vim.fn.input("Enter file description: ")

  local header
  if filename:match("%.h$") then
    local guard = filename:upper():gsub("%.", "_"):gsub("[^%w_]", "_") .. "_"
    header = string.format([[
/*
** EPITECH PROJECT, %s
** %s
** File description:
** %s
*/

#ifndef %s
    #define %s
#endif /* !%s */
]], current_year, project_name, file_description, guard, guard, guard)
    elseif filename == "Makefile" then
    -- Handle Makefile
    header = string.format([[
##
## EPITECH PROJECT, %s
## %s
## File description:
## %s
##
]], current_year, project_name, file_description)
  else
    header = string.format([[
/*
** EPITECH PROJECT, %s
** %s
** File description:
** %s
*/
]], current_year, project_name, file_description)
  end

  return header
end

-- Function to insert the Epitech header
local function insert_header()
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand("%:t")
  local header = create_epitech_header(filetype, filename)
  local header_lines = {}
  for line in header:gmatch("[^\r\n]+") do
    table.insert(header_lines, line)
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, header_lines)
end

-- Create the :Header command in Neovim
vim.api.nvim_create_user_command('Header', insert_header, {})

-- Add an 80-character line
vim.opt.colorcolumn = "80"

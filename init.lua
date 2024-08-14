-- NVimTek/init.lua

local function get_project_name()
    local handle = io.popen("git rev-parse --show-toplevel")
    local result = handle:read("*a")
    handle:close()

    return vim.fn.fnamemodify(result, "t"):gsub("\n", "")
end

local function insert_header()
    local filetype = vim.bo.filetype
    local header = ""
    local year = os.date("%Y")
    local project_name = get_project_name()

    local file_description = vim.fn.input("File description: ")

    if filetype == "c" or filetype == "h" then
        header = string.format([[
/*
** EPITECH PROJECT, %s
** %s
** File description:
** %s
*/
]], year, project_name, file_description)
    elseif filetype == "make" then
        header = string.format([[
##
## EPITECH PROJECT, %s
## %s
## File description:
## %s
##
]], year, project_name, file_description)
end

vim.api.nvim_buf_set_lines(0, 0, 0, false, vim.split(header, "\n"))
end

vim.api.nvim_create_user_command('TekHeader', insert_header, {})

local function set_80_char_line()
    vim.wo.colorcolumn = "80"
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = { "*.c", "*.h" },
        callback = set_80_char_line,
})

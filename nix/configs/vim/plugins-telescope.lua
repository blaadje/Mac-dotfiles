local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local open_after_tree = function(prompt_bufnr)
    local entry = action_state.get_selected_entry()
    if not entry then return end
    actions.close(prompt_bufnr)

    vim.defer_fn(function()
        vim.cmd("edit " ..
                    vim.fn.fnameescape(tostring(entry.path or entry.value)))
    end, 100)
end

require("telescope").setup({
    defaults = {
        layout_strategy = "vertical",
        layout_config = {width = 0.85, height = 0.85, prompt_position = "top"},
        sorting_strategy = "ascending",
        border = true,
        selection_caret = "➤ ",
        borderchars = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"},
        mappings = {
            i = {["<CR>"] = open_after_tree},
            n = {["<CR>"] = open_after_tree}
        },
        prompt_prefix = '🔍 ',
        file_ignore_patterns = {'node_modules'}
    },
    extensions = {
        frecency = {
            default_workspace = "CWD",
            ignore_patterns = {'node_modules'},
            show_filter_column = false
        }
    }
})

require("telescope").load_extension("recent-files")

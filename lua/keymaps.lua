vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- telescope keymaps

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>pf", builtin.find_files)
vim.keymap.set("n", "<C-g>", builtin.git_files)
vim.keymap.set("n", "<leader>ps", function()
   builtin.grep_string ({search = vim.fn.input("Grep > ")})
end)

-- fugitive keymaps

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

-- harpoon keymaps

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
local term = require("harpoon.term")

vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-j>", ui.nav_next)
vim.keymap.set("n", "<C-k>", ui.nav_prev)
vim.keymap.set("n", "<C-t>", function() term.gotoTerminal(1) end)

-- undotree keymaps

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- lsp && mason keymaps

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.hover)

-- gen keymaps

vim.keymap.set('v', '<leader>ia', ':Gen<CR>')

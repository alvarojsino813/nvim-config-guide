vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<M-x>", ":bdelete<CR>")

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

vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>a", mark.add_file)
vim.keymap.set("n", "<C-n>", ui.nav_next)
vim.keymap.set("n", "<C-p>", ui.nav_prev)

-- undotree keymaps

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- markdown preview

vim.keymap.set("n", "<leader>mp", vim.cmd.MarkdownPreviewToggle)

-- lsp && mason keymaps

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)

-- dap 

vim.keymap.set('n', '<F5>', function()
   if vim.fn.filereadable('.vscode/launch.json') then
      require('dap.ext.vscode').load_launchjs()
   end
   require('dap').continue()
end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
   require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
   require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
   local widgets = require('dap.ui.widgets')
   widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
   local widgets = require('dap.ui.widgets')
   widgets.centered_float(widgets.scopes)
end)

vim.keymap.set('n', '<Leader>dc', function() require('dapui').close() end)
vim.keymap.set('n', '<Leader>do', function() require('dapui').open() end)

-- User command + keymap para ejecutar `cargo clippy` y mostrar resultados en quickfix
local function run_clippy()
  -- Usa el parser de errores de rustc (sirve para la salida de clippy)
  vim.cmd('compiler rustc')

  -- Define el comando de compilación solo para esta sesión (puedes usar setlocal si prefieres buffer-local)
  vim.o.makeprg = 'cargo clippy'

  -- Ejecuta y captura en quickfix
  vim.cmd('silent make')

  -- Abre quickfix si hay resultados
  local qf = vim.fn.getqflist({ size = 0 })
  if (qf.size or 0) > 0 then
    vim.cmd('copen')
  else
    print('Clippy: sin diagnósticos')
  end
end

vim.api.nvim_create_user_command('Clippy', run_clippy, {})
vim.keymap.set('n', '<leader>cc', ':Clippy<CR>', { silent = true, desc = 'Run cargo clippy' })

-- Diagnósticos LSP (incluye Clippy)
vim.keymap.set("n", "<leader>dn", ":cnext<CR>", { desc = "Next diagnostic (quickfix)" })
vim.keymap.set("n", "<leader>dp", ":cprev<CR>", { desc = "Previous diagnostic (quickfix)" })
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix" })


-- Code actions (algunas lints de Clippy sugieren fix)
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Send diagnostics to quickfix" })

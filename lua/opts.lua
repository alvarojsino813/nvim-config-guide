vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
-- Comment this line
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- And uncomment this one in case you use Windows
-- vim.opt.undodir = os.getenv("UserProfile") .. /".vim/undodir" 

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50

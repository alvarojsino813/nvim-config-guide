local M = {
   "ThePrimeagen/harpoon",
   lazy = true,
   dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
   require("harpoon").setup({
      tabline = true,
      tabline_prefix = "   ",
      tabline_sufix = "   ",
   })

   vim.cmd("highlight! HarpoonInactive guibg=NONE guifg=#63698c")
   vim.cmd("highlight! HarpoonActive guibg=NONE guifg=white")
   vim.cmd("highlight! HarpoonNumberActive guibg=NONE guifg=#7aa2f7")
   vim.cmd("highlight! HarpoonNumberInactive guibg=NONE guifg=#7aa2f7")
   vim.cmd("highlight! TabLineFill guibg=NONE guifg=white")

end

return M

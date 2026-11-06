local M = {
   "nvim-treesitter/nvim-treesitter",
   build = ":TSUpdate",
   branch = "main",
   lazy = false,
}

function M.config()
   require "nvim-treesitter.config".setup {
      ensure_installed = { "c", "lua", "rust", "bash" },
      sync_install = true,
      auto_install = true,
      highlight = {
         enable = true,
         disable = { "sql" },
      },
      indent = {
         enable = true,
         disable = { "sql" }
      }
   }
end

return M

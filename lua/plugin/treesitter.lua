local M = {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = "TSUpdate",
}

function M.config()
   require "nvim-treesitter.configs".setup {
      ensure_installed = { "c", "lua", "rust"},
      sync_install = true,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
   }
end

return M

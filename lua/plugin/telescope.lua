local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	cmd = "Telescope",
}

function M.config()
    local actions = require "telescope.actions"
    require("telescope").setup { }
end

return M

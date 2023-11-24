local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	lazy = true,
	cmd = "Telescope",
}

function M.config()
   local actions = require "telescope.actions"

   require("telescope").setup({
      defaults = {
         mappings = {
            i = {
               ["<C-j>"] = actions.move_selection_next,
               ["<C-k>"] = actions.move_selection_previous,
               ["<C-q>"] = actions.close,
               ["<C-n>"] = actions.cycle_history_next,
               ["<C-p>"] = actions.cycle_history_prev
            },

            n = {
               ["j"] = actions.move_selection_next,
               ["k"] = actions.move_selection_previous,
               ["q"] = actions.close,
               ["n"] = actions.cycle_history_next,
               ["p"] = actions.cycle_history_prev
            }
         }
      }
   })

end

return M

local M = {
   "meatballs/notebook.nvim"
}

function M.config()
   require("notebook")
   local api = require("notebook.api")
   local settings = require("notebook.settings")

   function _G.define_cell(extmark)
      if extmark == nil then
         local line = vim.fn.line(".")
         extmark, _ = api.current_extmark(line)
      end
      local start_line = extmark[1] + 1
      local end_line = extmark[3].end_row
      pcall(function() vim.fn.MagmaDefineCell(start_line, end_line) end)
   end

   function _G.define_all_cells()
      local buffer = vim.api.nvim_get_current_buf()
      local extmarks = settings.extmarks[buffer]
      for id, cell in pairs(extmarks) do
         local extmark = vim.api.nvim_buf_get_extmark_by_id(
            0, settings.plugin_namespace, id, { details = true }
         )
         if cell.cell_type == "code" then
            define_cell(extmark)
         end
      end
   end

   vim.api.nvim_create_autocmd(
      { "BufRead", },
      { pattern = { "*.ipynb" }, command = "MagmaInit" }
   )
   vim.api.nvim_create_autocmd(
      "User",
      { pattern = { "MagmaInitPost", "NBPostRender" }, callback = _G.define_all_cells }
   )
end

return M

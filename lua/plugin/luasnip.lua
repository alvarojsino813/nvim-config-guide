local M = {
   'L3MON4D3/LuaSnip',
   dependencies = { 
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip',
   },
}

function M.config()
   require("luasnip.loaders.from_vscode").load({ include = { "html", "css", "javascript" } })
end

return M


local M = {
	'williamboman/mason.nvim',
	dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'nvim-lua/plenary.nvim',
	},
}

M.servers = {
   "lua_ls",
   "clangd",
   "rust_analyzer",
}

function M.config()

   local lsp = require("lsp-zero")
	lsp.preset("recommended")

   lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
         error = 'E',
         warn = 'W',
         hint = 'H',
         info = 'I'
      }
   })

	require("lsp-zero").setup()
	require("mason").setup()

	require("mason-lspconfig").setup_handlers {
		function (server_name)
		    require "lspconfig" [server_name].setup {}
		end
	}


	require("mason-lspconfig").setup {
      ensure_installed = M.servers,
      automatic_installation = true,
	}

   vim.diagnostic.config({
      virtual_text = true
   })

end

return M

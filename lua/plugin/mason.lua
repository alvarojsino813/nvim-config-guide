local M = {
	'williamboman/mason.nvim',
	dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'nvim-lua/plenary.nvim',

      -- Autocompletetion
      'hrsh7th/nvim-cmp',
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-calc',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'FelipeLema/cmp-async-path',
      "saadparwaiz1/cmp_luasnip"
	},
}

M.servers = {
   "lua_ls",
   "clangd",
   "rust_analyzer",
}

function M.config()

   require("mason").setup()

   local capabilities = require("cmp_nvim_lsp").default_capabilities()

   require("mason-lspconfig").setup({
      ensure_installed = {
         "lua_ls",
         "clangd",
         "rust_analyzer",
      },
      handlers = {
         function(server)
            vim.lsp.config[server] = {
               capabilities = capabilities,
            }
            vim.lsp.start(vim.lsp.config[server])
         end,
      }
   })

   vim.lsp.config('rust_analyzer', {
      capabilities = capabilities,
      settings = {
         ["rust-analyzer"] = {
            cargo = { allFeatures = true },
         },
      },
   })

   vim.diagnostic.config({
      virtual_text = false,
   })

   local cmp = require("cmp")

   cmp.setup({
      mapping = cmp.mapping.preset.insert({
         ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Ctrl+Y accepts
         ["<C-Space>"] = cmp.mapping.complete(),
         ['<C-e>'] = cmp.mapping.abort(),                  -- Ctrl+E rejects 
      }),
      sources = {
         { name = "nvim_lsp" },
         { name = "luasnip" },
         { name = "async_path" },
         { name = "nvim_lua" },
         { name = "path" },
         { name = "calc" },
      },
   })

end

return M

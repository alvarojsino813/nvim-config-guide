local M = {
   'jay-babu/mason-nvim-dap.nvim',
   'rcarriga/nvim-dap-ui',
   'theHamsta/nvim-dap-virtual-text',
   'mfussenegger/nvim-dap',
   'nvim-neotest/nvim-nio',
	dependencies = {
      'williamboman/mason.nvim',
	},
}

function M.config()

   require("nvim-nio").setup()
   require("mason-nvim-dap").setup()
   require("nvim-dap-virtual-text").setup()
   require("dapui").setup()

end

return M

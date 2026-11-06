local M = {
   "iamcco/markdown-preview.nvim",
   lazy = true,
   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
   ft = { "markdown" },
   build = "cd app && ./install.sh",
}

function M.init()
   vim.g.mkdp_filetypes = { "markdown" }
   vim.g.mkdp_auto_start = 0
   vim.g.mkdp_auto_close = 1
   vim.g.mkdp_echo_preview_url = 1
   vim.g.mkdp_theme = "dark"
end

return M

print("Hola mundo")
require "opts"
require "launch"

spec("plugin.colorscheme")
spec("plugin.treesitter")
spec("plugin.telescope")
spec("plugin.fugitive")
spec("plugin.harpoon")
spec("plugin.undotree")
spec("plugin.lsp-zero")
spec("plugin.mason")
spec("plugin.gen")

require "plugin.lazy"
require "keymaps"

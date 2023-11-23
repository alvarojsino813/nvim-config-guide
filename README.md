## Nvim Installation
---
Neovim is a fork of Vim aiming to improve the code base for easier API implementation, a better user experience and plugin implementations. It is known for having really tricky keybindings and a step learning curve, so my aim with this guide is to make the editor more accessible for anyone. So let's get started, you can install the editor following the [official guide](https://github.com/neovim/neovim/wiki/Installing-Neovim).

Once installed you can execute the editor with:

```
nvim
```

## Configuration structure
---
For this guide is highly recommended to know vim keybindings, so if you are not familiar with them you should try the nvim tutorial by typing `:Tutor<Enter>` once you are in the editor. You can also check this [keybindings cheat sheet](https://vim.rtorr.com).

When you know your way through the editor, you can start by getting deeper into the nvim config. Nvim checks the config file in `~/.config/nvim/` 

Now you should go to `~/.config/nvim/`directory by:

```bash
cd ~/.config/nvim 
```

Lua is the language used by nvim to configure the text editor. This is an interpreted highly modular language. You don't need a deep knowledge about this language for the guide, as you will discover all you need step by step. Still you can find here its [documentation](https://www.lua.org/docs.html). Here you have also a [nvim focused lua guide](https://github.com/nanotee/nvim-lua-guide).

We will structure the configuration files as follows:

```
~/.config/nvim
├── init.lua
└── lua
    ├── plugin1.lua
    ├── plugin2.lua
	├── ...
	├── keymaps.lua
	└── opts.lua

```

- `init.lua` : This is the root of any module of Lua, as it acts as a main function and brings into scope the rest of files / modules.
- `/lua`: This is the folder where lua looks for other modules by default.
- `plugin[x].lua` : An specific file to configure and set up a certain plugin.
- `keymaps.lua` : A file to set the keybindings.
- `opts.lua` : A file to set some vim environment settings.

We will create all the files step by step, so let's start by creating this folders and files:

```
~/.config/nvim
├── init.lua
└── lua
	├── keymaps.lua
	└── opts.lua
```

You can write your username instead of `user`.

And now, nvim will try the `~/.config/nvim/init.lua`. We can test it writing into it:

```lua
print("Hello world")
```

Now if you type in normal mode (`<Esc>`) and type `:w` to save the file and `:so` to execute it, you should see a `Hello world` message written at the bottom of the editor screen.

And let's bring into scope the rest of files by adding into `~/.config/nvim/init.lua`:

```lua
require "opts"
require "keymaps"
```


## General configuration
---
Let's add some general configurations in `opts.lua`:

```lua
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 3
vim.opt.softtabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.smartindent = true

vim.opt.wrap = false

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
-- Comment this line
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- And uncomment this one in case you use Windows
-- vim.opt.undodir = os.getenv("UserProfile") .. /".vim/undodir" 

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.updatetime = 50
```

And let's add also a keybinding at `user/keybindings.lua` so we can check files from nvim with `<Space>pv`, "pv" as in project view, or try any one you like.

```lua
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
```

Feel free to restart nvim and check the changes. There are some different aspects like the tabs, a column marker, the relative numbers of line according to your cursor position. Also you can now access the project view by `<Space>pv`. For more information about this changes and all the modules you can check and change go to [nvim documentation](https://neovim.io/doc/user/lua.html#lua-stdlib).
## Plugins
---
This is the best way to customize our editor, so we will install some of the ones I use the most.
### [Lazy](https://github.com/folke/lazy.nvim)

First we will install lazy as our plugins manager to make our life easier, so we can check their documentation in [lazy](https://github.com/folke/lazy.nvim) for further information. By now we can create `user/lazy.lua` and add this code:

```lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require "lazy".setup(LAZY_PLUGIN_SPEC)
```

And if we source the file (`:w` to save it and `:so` to source it), we can use our plugin manager by typing `:Lazy` in our editor. This will open a window that we can close by typing `q` as we don't need it right now.

To install new plugins we will need to send a table (lua data structure comparable to a JSON) to the `setup()` function of `lazy`. For this, we will create a `launch.lua` file with a function that will append to this table every plugin. So we write in `user/launch.lua`:

```lua
LAZY_PLUGIN_SPEC = {}

function spec(item)
	table.insert(LAZY_PLUGIN_SPEC, { import = item })
end
```

- `LAZY_PLUGIN_SPEC` is the table we will give to `require "lazy".setup(LAZY_PLUGIN_SPEC)` as argument, where all the information about our plugins will be

- `spec(item)` is the function that we will invoke every time we need to append more information about a new plugin to our `LAZY_PLUGIN_SPEC` table.

And let's also add this new function so our `init.lua` should look like this (the order is important):

```lua
require "opts"
require "launch"
require "lazy"
require "keymaps"
```

The full layout of a normal table can be checked at the [documentation](https://github.com/folke/lazy.nvim#-plugin-spec), and some [examples](https://github.com/folke/lazy.nvim#examples) as well. But to summarize we will typically follow this:

```lua
LAZY_PLUGIN_SPEC = {
	{
		"github-plugin1-creator/plugin1"
		lazy = true -- This allows the plugin to load just when used
	},
	{
		"github-plugin2-creator/plugin2"
		lazy = true -- This allows the plugin to load just when used
	},
}
```

Yes, it works directly with github pulls.

### [Colorscheme](https://github.com/rose-pine/neovim)

The default colors of nvim are not really my favorite, so let's change them. We can understand a colorscheme as a plugin as well, so let's create our `colorscheme.lua`file at our `user` folder and add:

```lua
local M = {
    "rose-pine/nvim",
    lazy = false, -- Loads this plugin at the beginning
    priority = 1000, 
  }

  function M.config()
    vim.cmd.colorscheme "rose-pine"
  end

  return M

```

In this case there's no point on `lazy = true` as we want our colorscheme full loaded since the beginning, so we set `lazy = false` and `priority = 1000` just to ensure this is the very first to load. The `M.config()` function is invoked after building the plugin and sets our colorscheme in the nvim environment.

So now we call out `spec()` function in `init.lua` with this `M` module as an argument writing it as follows (all the `spec()`'s  calls will be done after the `opts` and `launch` requires and before the rest requires):

```lua
require "opts"
require "launch"

spec("colorscheme")

require "lazy"
require "keymaps"
```

Now if we restart nvim we will have a nice colorscheme. The process to install the rest of plugins will be almost identical.

### [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

The default syntax highlighter of nvim does't really do the thing, so let's try adding a new one. So, following the same process we can add a `treesitter.lua` file like:

```lua
local M = {
    "nvim-treesitter/nvim-treesitter",
    build = "TSUpdate",
    lazy = true,
  }

function M.config()
    require "nvim-treesitter.configs".setup {
        ensure_installed = { "c", "lua", "rust" },
        sync_install = true,
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
end

return M
```

- The `bulid = "TSUpdate"` field makes `Lazy` to invoke this cmd instruction every time `Treesitter` is built to ensure all its  _parsers_ are up to date, as its [documentation](https://github.com/nvim-treesitter/nvim-treesitter#installation) suggests.

- The `require "nvim-treesitter.configs".setup()` function sets the configuration of the plugin. The fields changed at it are pretty self-explanatory, but you can check the [documentation]() for further information. This is a really typical way to configure any plugin.

So now we just have to add the spec at `init.lua`:

```lua
spec("treesitter")
```

By restarting the editor we can then open the packer manager by typing `:Lazy` and see how the new plugin is installed.

### [Telescope](https://github.com/nvim-telescope/telescope.nvim)

Now that we have an acceptable layout let's get true functionality. Telescope is a highly extendable fuzzy finder, which will give us a better way to navigate through files than the native nvim way. First we need some system dependencies to allow this features:

```bash
sudo apt install ripgrep 
```

Or find out how to install it for your system on the [official guide](https://github.com/BurntSushi/ripgrep#installation).

Now let's as always let's create a `telescope.lua` file and write into it:

```lua
local M = {
	"nvim-telescope/telescope.nvim",
    dependencies = { 'nvim-lua/plenary.nvim' },
    lazy = true,
    cmd = "Telescope",
}

function M.config()
    local actions = require "telescope.actions"
    require("telescope").setup {
        defaults = {
            mappings = {
                i = {
                  ["<C-n>"] = actions.cycle_history_next,
                  ["<C-p>"] = actions.cycle_history_prev,
        
                  ["<C-j>"] = actions.move_selection_next,
                  ["<C-k>"] = actions.move_selection_previous,

                  ["<C-q>"] = actions.close,
                },
                n = {
                  ["<esc>"] = actions.close,
                  ["j"] = actions.move_selection_next,
                  ["k"] = actions.move_selection_previous,
                  ["q"] = actions.close,
                },
              },
        }
    }
end

return M
```

Let's see what's new in this configuration from top to bottom:
- `cmd = "Telescope"`: This is the command that will trigger the lazy-load of this plugin, so we will be able to use it.

- `dependencies`: This plugin needs the `plenary.nvim` plugin to work, so we can specify it as shown and our packer manager will handle the rest.

- `local actions = require "telescope.actions"`: As our module has sub-modules, other plugins may have them to. To access to the functionality we are about to use we need to access this `actions` sub-module inside the `telescope` module, so we can know type `actions` instead of `require "telescope.actions"` each time we need it.

- `mappings`: Into the plugin settings we can find this table with some extra keybindings that I defined. We define this keybindings here and not at the `keybindings.lua` file because these ones only affects the actual context of this plugin. When we invoke the plugin with `:Telescope` a pop-up menu will appear, so we will be able to use this keybindings.

- `i` stands for keybindings in insert mode in vim, and `n` in normal mode.

Now we add the `spec` to our `init.lua` file:

```lua
spec("telescope")
```

And after restarting the editor `lazy` should load install the plugin that we can now use by typing `:Telescope`. Feel free to try this new feature, but here are some tips:

- After executing `:Telescope` you will see a menu with all the possible actions you can do with this plugin, you can try typing `find_files` and pressing `<enter>` to find files within the directory.

- You can also navigate through the options with the `<C-j>` and `<C-i>` keybindings we set earlier (`C-` stands for `<control>`). Or even press `<esc>` and use `i` and `j` in normal mode.

- If you type `fnfl` instead of `find_files` you will notice that the `find_files` will be marked anyways. This is thanks to its regex support via `ripgrep`.

- You can use the proper keybinding to close the menu as well.

Once you get familiar with this plugin let's set some more keybindings to invoke certain features of this plugin, this time we will do it in `keybindings.lua` as we want to use these from anywhere, not just when we open the `telescope` menu.

```lua
-- telescope keymaps

local builtin = require "telescope.builtin"
vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.git_files, {})
vim.keymap.set("n", "<leader>ps", function()
   builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
```

- `find_files` is a direct way we can invoke this functionality we have just try with just three quick key strokes.

- `git_files` works as `find_files` but for git files. Yes, git is integrated into this one also.

- `grep_string` will match a regex inside all files of the project. We define it into a function so we can get this `"Grep >"` message when we use it.

By just sourcing this file `:so` you should be able to use these new keybindings. Get comfortable with the new features and feel free to explore the [official documentation](https://github.com/nvim-telescope/telescope.nvim) to add as many keybindings and configurations as you want.

### [Fugitive](https://github.com/tpope/vim-fugitive)

This plugin allows to integrate github with the editor. It's really simple so let's just add a `fugitive.lua` file:

```lua
local M = {
	"tpope/vim-fugitive",
	lazy = true,
	cmd = "Git",
}
return M
```

And the spec to `init.lua`:

```lua
spec("fugitive")
```

Once we restart the editor we can use the plugin with `:Git`, but we can set a keybinding for easier use in `keybinding.lua`:

```lua
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
```

So after sourcing the file we will be able to use this plugin.

### [Harpoon](https://github.com/ThePrimeagen/harpoon/tree/master)

Now that we can find any file easily, we can speed it up with this plugin. Harpoon aims to allow this fast navigation among files by marking them and permits fast navigation among these marked files. More information in the [official documentation](https://github.com/ThePrimeagen/harpoon/tree/master).

So to install it we create, as always, a `harpoon.lua` file in our `/user` folder and write into it:

```lua
local M = {
   "ThePrimeagen/harpoon",
   lazy = true,
   dependencies = "nvim-lua/plenary.nvim",
}

return M
```

Just notice this plugin depends also on `plenary`, but as `telescope` depends on it too, we could not add it here, although is not recommended.

Add also the `spec` in `init.lua`:

```lua
spec("harpoon")
``` 

Restart the editor and you will see how `lazy` installs the new plugin, but we didn't set any keybindings to use it, so let's set them in `keybindings.lua`:

```lua
-- harpoon keymaps

local mark = require "harpoon.mark"
local ui = require "harpoon.ui"
local term = require "harpoon.term"
vim.keymap.set("n", "<leader>e", ui.toggle_quick_menu, {})
vim.keymap.set("n", "<leader>a", mark.add_file, {})
vim.keymap.set("n", "<C-j>", ui.nav_next, {})
vim.keymap.set("n", "<C-k>", ui.nav_prev, {})
vim.keymap.set("n", "<C-t>", function()
   term.gotoTerminal(1)
end)
```

You can try source the file (`:so`) and try to figure out how to use this plugin, but here you have some tips:

- You can try to mark some files with the proper keybinding and check these marked files in the menu.

- At the menu you can try to change the order of the marked up files with the standard vim keybindings.

- Try as well the navigation keybindings we set.

 - Harpoon also allows to manage terminals.

This plugin gives you more options, so dive into the [official documentation](https://github.com/ThePrimeagen/harpoon/tree/master) and try them. For example you can try to set the tabline and highlight it, or check the support of `telescope`. The tabline is set in the files so you can check how is done if you don't get your way through the documentation of this plugin.


### [Undotree](https://github.com/mbbill/undotree)

This plugin will allow us to track every version of each file we ever had. It works similarly to git. We can install it adding a `undotree.lua` file with:

```lua
local M = {
    "mbbill/undotree",
    lazy = true,
    cmd = "UndotreeToggle"
}

return M
```

And the `spec` to `init.lua`:

```lua
spec("undotree")
```

Now we can use restart the editor and after the installation we can use it with `:UndotreeToggle`. This will open a side window with all the different versions. You can change type `?` to see the help panel. To change from one window to another use `<C-ww>` and use `<C-wq>` to close a window. You can check this [vim cheat sheet](https://vim.rtorr.com) for more information about default keybindings.

Let's also add a keybinding to invoke undotree anytime at `keybindings.lua`:

```lua
--- undotree keymaps

vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
```

So now make your way through this plugin. Here you have the [official documentation](https://github.com/mbbill/undotree).

### [LSP-Zero](https://github.com/VonHeikemen/lsp-zero.nvim) && [Mason](https://github.com/williamboman/mason.nvim)

This is the main argument why people prefer an IDE like Vs Code: LSP. LSP stands for Language Service Provider, and it is related with all the recommendations and syntax corrections that we find easily in other IDEs. Actually this is not an exclusive IDE feature, as every language has its own LSP that is maintained by them and has nothing to do with a particular IDE. So in order to use all this features we will use `LSP-Zero` and `Mason`, which are an LSP installer and an LSP manager.
First we will install LSP-Zero, so we create our `lsp-zero.lua` file and add some dependencies:

```lua
local M = {
   'VonHeikemen/lsp-zero.nvim',
   branch = "v1.x",
   dependencies = {
      -- LSP support
      'neovim/nvim-lspconfig',

      -- Autocompletetion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
   },
}

return M
```

Don't forget to add it to our `init.lua`:

```lua
spec("lsp-zero")
```

Now we can use `Lazy` and get our plugin initialized, but we won't see any difference as there are no LSPs installed. We could install them manually each time using `LSP-Zero`, but this will be a task for `Mason` so let's install it adding a `mason.lua` file:

```lua
local M = {
	'williamboman/mason.nvim',
	dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'nvim-lua/plenary.nvim',
	},
}

M.servers = {
	"lua_ls",
	"rust_analyzer",
	"clangd"
}

function M.config()

	local lsp = require("lsp-zero")
	lsp.preset("recommended")
	
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

end

return M
```

- `lsp.preset("recommended")` sets some defaults configurations so we don't have to set them all.

- `setup()` starts each module so we can configure it.

- `"mason-lspconfig"` is a nvim focused module that allows us to configure `Mason` for nvim.

- `setup_handlers` sets the function that will call mason each time a new LSP needs to be installed. It can be understood as the point that joins `LSP-Zero` and `Mason`.

- `M.serves` is a table that stores some must-install LSPs, so in the `setup` function for `mason-lspconfig` we can make `Mason` to always ensure these LSPs.

And add it to our `init.lua`:

```lua
spec("mason")
```

So now `Lazy` can install all the dependencies and we could use `:Mason` to start installing some LSPs. Look for them with the `/` command and press `i` to install one. 

If you try to type any keyword in a `.lua` file as `require` you should see a little menu with some suggestions to complete your code. Also you should see warnings, hints and errors if your code has them, but this is not still all the potencial, let's add some keybindings in `keymaps.lua`:

```lua
-- lsp keymaps

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references)
vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename)
```

These keybindings allow you actions like rename a symbol, go to the definition of a function or a variable, view code diagnostic, actions etc... Explore them. 

Now our LSP should be fully functional, but let's add some custom configurations to show some of the options it has:

```lua
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
	
	require "lsp-zero".setup()
	require("mason").setup()
	
	require "mason-lspconfig".setup_handlers {
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
```

Our `M.config()` function should look as shown now.

- `lsp.set_preferences` we can change some options like suggestions or `sign_icons`. I like to have simple icons, but you can try to use a `Nerd font` if you want to.

- `vim.diagnostic.config` sets how LSP shows its information, the option I like the most is the `virtual_text`, so you can see the diagnosis of a code before even compiling or executing the file.

Here you have the official documentation for [lsp-zero](https://github.com/vonheikemen/lsp-zero.nvim) and [Mason](https://github.com/williamboman/mason.nvim) as well so you can check all the options. You should as well check the nvim configuration documentation for the [diagnostic tools](https://neovim.io/doc/user/diagnostic.html) and for the [LSP functionality](https://neovim.io/doc/user/lsp.html)
### [Nvim.gen](https://github.com/David-Kunz/gen.nvim)

The last plugin included in this config will be Nvim.gen. This plugin needs you to install Ollama, an API that allows you to create, run and manage AI models. You can install it with:

```bash
curl https://ollama.ai/install.sh | sh
```

And now let's create our `gen.lua` file:

```lua
local M = {
   'David-Kunz/gen.nvim',
   lazy = true,
   cmd = "Gen",
}

return M
```

Add the spec to the `init.lua`:

```lua
spec("gen")
```

And finally we can use it easily by typing `:Gen` or we can set a keybinding in our `keybindings.lua` file:

```lua
-- gen keymaps

vim.keymap.set({"n", "i"}, "<leader>ia", ":Gen<CR>")
```

## Extra
---
These were the plugins that I use the most in my nvim configuration, but here are some more suggestions for you to try to install by yourself and explore further:

- [NerdTree](https://github.com/preservim/nerdtree): Shows a tree view of files in the current project or folder.
- [Lualine](https://github.com/nvim-lualine/lualine.nvim): A better command prompt.
- [vim-sneak](https://github.com/justinmk/vim-sneak): A faster way to move around the screen. 
- [Lens.vim](https://github.com/camspiers/lens.vim): Automatic resizing of several splits.
- [sniprun](https://github.com/michaelb/sniprun): Allows executing one or several lines of code without exiting nvim.

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	 {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" }
	 },
	 'Vimjas/vim-python-pep8-indent',
	 'stevearc/conform.nvim',
	 'mbbill/undotree',
	 'norcalli/nvim-colorizer.lua',
     'junegunn/fzf',
	 'junegunn/fzf.vim', --requires fzf.vim and fzf installed
	 'mattn/emmet-vim',
	 'EdenEast/nightfox.nvim',
	 'iamcco/markdown-preview.nvim',
     'sho-87/kanagawa-paper.nvim',
	 'mfussenegger/nvim-jdtls',
     'windwp/nvim-autopairs',
     'nvim-tree/nvim-tree.lua',
	 'neovim/nvim-lspconfig',
     'nvim-tree/nvim-web-devicons',
	 'hrsh7th/nvim-cmp',
	 'hrsh7th/cmp-path',
	 'hrsh7th/cmp-nvim-lsp',
	 'hrsh7th/cmp-nvim-lsp-signature-help',
	 'williamboman/mason.nvim',
	 'sainnhe/gruvbox-material',
	 'scottmckendry/cyberdream.nvim',
	 'simaxme/java.nvim', -- java renaming
	 { 'akinsho/toggleterm.nvim', version = "*", config = true },
	 {
    "lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate"
	},
	{
	  "folke/trouble.nvim",
	  opts = {}, -- for default options, refer to the configuration section for custom setup.
	  cmd = "Trouble",
	  keys = {
		{
		  "gtd",
		  "<cmd>Trouble diagnostics toggle<cr>",
		  desc = "Diagnostics (Trouble)",
		},
		{
		  "gtb",
		  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
		  desc = "Buffer Diagnostics (Trouble)",
		},
		{
		  "gts",
		  "<cmd>Trouble symbols toggle focus=false<cr>",
		  desc = "Symbols (Trouble)",
		},
		{
		  "<leader>cl",
		  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
		  desc = "LSP Definitions / references / ... (Trouble)",
		},
		{
		  "<leader>xL",
		  "<cmd>Trouble loclist toggle<cr>",
		  desc = "Location List (Trouble)",
		},
		{
		  "gtq",
		  "<cmd>Trouble qflist toggle<cr>",
		  desc = "Quickfix List (Trouble)",
		},
	  },
	}
  },
})

-- code formatting (conform)
require("conform").setup({
	formatters_by_ft = {
		kotlin = { "ktlint" }
	}
})
vim.keymap.set("n", "gf", function()
    require("conform").format({ bufnr = 0 })
  end
)


-- terminal
require('toggleterm').setup({
	size = 20,
	open_mapping = [[<c-t>]]
})

-- colorscheme
vim.o.termguicolors = true

-- scroll off (keep cursor away from the very top)
vim.o.scrolloff = 5

-- Default options
require('nightfox').setup({
  options = {
    -- Compiled file's destination location
    compile_path = vim.fn.stdpath("cache") .. "/nightfox",
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = false,     -- Disable setting background
    terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = true,    -- Non focused panes set to alternative background
    module_default = true,   -- Default enable value for modules
    styles = {               -- Style to be applied to different syntax groups
      comments = "italic",     -- Value is any valid attr-list value `:help attr-list`
      conditionals = "italic",
      constants = "NONE",
      functions = "italic",
      keywords = "italic",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "NONE",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {
		all = {
			sel0 = "#4f6074" -- visual color
		},
		dayfox = {
			bg1 = "#e4dcd4",
			bg0 = "#faf4ed",
			sel0 = "#e7d2be"
		},
		dawnfox = {
			bg1 = "#ebe5df",
			sel0 = "#e7d2be"
		}

	},
  specs = {},
  groups = {},
})


require("cyberdream").setup(
	{
		variant = "default",
		italic_comments = true
	}
)

-- setup must be called before loading
vim.cmd("colorscheme nordfox")

-- relative and absolute line numbers
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.statuscolumn = "%s %l %r "

-- no highlight search
vim.o.hlsearch = false

-- wrap
vim.o.wrap = false

-- indent
vim.o.breakindent = false

-- save undo history
vim.opt.undofile = true

-- ignore case unless \C in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- enable mouse
vim.o.mouse = 'a'

-- zero escape time
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 100

-- highlight yank
vim.cmd[[
	augroup highlight_yank
	autocmd!
	au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=300})
	augroup END
]]

-- shift width
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- cursor line
vim.o.cursorline = true

-- timeout len

-- autopairs
require('nvim-autopairs').setup({})

-- nvim tree
require("nvim-tree").setup({view = { width = 50 }})

-- mason
require('mason').setup()

-- completion
local cmp = require'cmp'
cmp.setup({
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered()
	},
	mapping = cmp.mapping.preset.insert({
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	  ['<Down>'] = function () end,
	  ['<Up>'] = function () end
    }),
	sources = cmp.config.sources({
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
	}, {
		name = 'buffer'
	}),
})


local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp
require('lspconfig').basedpyright.setup({ capabilities = capabilities })
require('lspconfig').lua_ls.setup({ capabilities = capabilities })
require('lspconfig').html.setup({ capabilities = capabilities })
require'lspconfig'.ts_ls.setup {}
require'lspconfig'.kotlin_language_server.setup({ capabilities = capabilities })

-- key map
vim.keymap.set('n', '<C-n>', function() vim.cmd('NvimTreeToggle') end)
vim.keymap.set('n', 'H', function() vim.diagnostic.open_float() end)
vim.keymap.set('n', 'S', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end)
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'gre', function() vim.lsp.buf.references() end)
vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', 'gca', function() vim.lsp.buf.code_action() end)

-- disable arrow keys... your pinky will thank you
vim.keymap.set('i', '<Down>', function() end)
vim.keymap.set('i', '<Right>', function() end)
vim.keymap.set('i', '<Left>', function() end)
vim.keymap.set('i', '<Up>', function() end)
vim.keymap.set('v', '<Down>', function() end)
vim.keymap.set('v', '<Right>', function() end)
vim.keymap.set('v', '<Left>', function() end)
vim.keymap.set('v', '<Up>', function() end)
vim.keymap.set('n', '<Down>', function() end)
vim.keymap.set('n', '<Right>', function() end)
vim.keymap.set('n', '<Left>', function() end)
vim.keymap.set('n', '<Up>', function() end)

vim.keymap.set('i', '<C-o>', function() 
	vim.api.nvim_input('<Esc>')
	vim.api.nvim_input('o')
end)

vim.keymap.set('i', '<C-O>', function() 
	vim.api.nvim_input('<Esc>')
	vim.api.nvim_input('o')
end)

vim.keymap.set('i', '<C-e>', function() 
	vim.api.nvim_input('<Esc>')
	vim.api.nvim_input('A')
end)

vim.keymap.set('i', '<C-a>', function() 
	vim.api.nvim_input('<Esc>')
	vim.api.nvim_input('I')
end)

-- map ctrl+arrow keys to window size control in normal mode
vim.keymap.set('n', '<C-LEFT>', '<C-w>2<')
vim.keymap.set('n', '<C-DOWN>', '<C-w>2-')
vim.keymap.set('n', '<C-UP>', '<C-w>2+')
vim.keymap.set('n', '<C-RIGHT>', '<C-w>2>')

-- map ctrl+hjkl to window control in normal mode
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- map ctrl+hjkl to arrow keys in insert mode
vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- fzf (fuzzy findor)
-- https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim
vim.keymap.set('n', 'g/', function() vim.cmd('BLines') end)
vim.keymap.set('n', '<C-f>', function() vim.cmd('call fzf#vim#files("", fzf#vim#with_preview(), 1)') end)
vim.keymap.set('n', '<C-g>', function() vim.cmd('call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".fzf#shellescape(""), fzf#vim#with_preview(), 1)') end)


-- treesitter
-- vim.opt.smartindent = false -- disable smartindent bc it interferes

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "typescript", "java", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "kotlin"},
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    additional_vim_regex_highlighting = false,
  },
  indent = {
	  enable = false
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>", -- set to `false` to disable one of the mappings
      node_incremental = "<CR>",
      scope_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
}

-- harpoon
local harpoon = require("harpoon")
harpoon:setup()
vim.keymap.set("n", "ga", function() harpoon:list():add() end)
vim.keymap.set("n", "gh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

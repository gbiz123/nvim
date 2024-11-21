-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	 'mattn/emmet-vim',
	 'ggandor/leap.nvim',
	 'norcalli/nvim-colorizer.lua',
	 'EdenEast/nightfox.nvim',
	 'junegunn/fzf',
	 'junegunn/fzf.vim', --requires fzf.vim and fzf installed
	 'iamcco/markdown-preview.nvim',
     'sho-87/kanagawa-paper.nvim',
	 'mfussenegger/nvim-jdtls',
     'windwp/nvim-autopairs',
     'nvim-tree/nvim-tree.lua',
	 'neovim/nvim-lspconfig',
     'nvim-tree/nvim-web-devicons',
	 'hrsh7th/nvim-cmp',
	 'hrsh7th/cmp-nvim-lsp',
	 'hrsh7th/cmp-nvim-lsp-signature-help',
	 'williamboman/mason.nvim',
	 'sainnhe/gruvbox-material',
	 'simaxme/java.nvim', -- java renaming
	 {
	  -- python renaming/import stuff, requires cargo to be installed and in PATH
	  -- Also requires ripgrep
	  -- also requires fd https://github.com/sharkdp/fd
	 "alexpasmantier/pymple.nvim",
	 dependencies = {
	   "nvim-lua/plenary.nvim",
	   "MunifTanjim/nui.nvim",
	   -- optional (nicer ui)
	   -- "stevearc/dressing.nvim",
	   "nvim-tree/nvim-web-devicons",
	 },
	 build = ":PympleBuild",
	  },
	 { 'akinsho/toggleterm.nvim', version = "*", config = true },
     { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },
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

-- terminal
require('toggleterm').setup({
	size = 20,
	open_mapping = [[<c-t>]]
})

-- colorscheme
vim.o.termguicolors = true

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
    colorblind = {
      enable = false,        -- Enable colorblind support
      simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
      severity = {
        protan = 0,          -- Severity [0,1] for protan (red)
        deutan = 0,          -- Severity [0,1] for deutan (green)
        tritan = 0,          -- Severity [0,1] for tritan (blue)
      },
    },
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

-- setup must be called before loading
vim.cmd("colorscheme terafox")

vim.o.background = 'dark'

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

-- autopairs
require('nvim-autopairs').setup({})

-- nvim tree
require("nvim-tree").setup()

-- LSP STUFF BELOW
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
      ['<C-p>'] = cmp.mapping.scroll_docs(-4),
      ['<C-n>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<TAB>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
	sorting = {
		priority_weight = 2,
		comparators = {
			cmp.config.compare.locality,
			cmp.config.compare.recently_used,
			cmp.config.compare.exact,
			cmp.config.compare.kind,
			cmp.config.compare.score,
			cmp.config.compare.order
		}
	},
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' },
	}, {
		name = 'buffer'
	}),
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp
-- require('lspconfig').jdtls.setup({ 
-- 	capabilities = capabilities,
-- 	-- Enable signature help: https://github.com/mfussenegger/nvim-jdtls/issues/88
-- 	on_init = function(client)
-- 	  client.server_capabilities.semanticTokensProvider = nil -- Disable lsp highlighting 
-- 	  if client.config.settings then
-- 		client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
-- 	  end
-- 	end
-- })
require('lspconfig').basedpyright.setup({ capabilities = capabilities })
require('lspconfig').lua_ls.setup({ capabilities = capabilities })
require('lspconfig').html.setup({ capabilities = capabilities })
require'lspconfig'.ts_ls.setup {}

-- key map
vim.keymap.set('n', '<C-n>', function() vim.cmd('NvimTreeToggle') end)
vim.keymap.set('n', 'K', function() vim.diagnostic.open_float() end)
vim.keymap.set('n', 'H', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', 'gt', function() vim.lsp.buf.type_definition() end)
vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end)
vim.keymap.set('n', 'gre', function() vim.lsp.buf.references() end)
vim.keymap.set('n', 'grn', function() vim.lsp.buf.rename() end)
vim.keymap.set('n', 'gca', function() vim.lsp.buf.code_action() end)
vim.keymap.set('n', 'g/', function() vim.cmd('BLines') end)
vim.keymap.set('n', '<C-f>', function() vim.cmd('call fzf#vim#files("", fzf#vim#with_preview(), 1)') end)
-- https://github.com/junegunn/fzf.vim/blob/master/plugin/fzf.vim
vim.keymap.set('n', '<C-g>', function() vim.cmd('call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case -- ".fzf#shellescape(""), fzf#vim#with_preview(), 1)') end)


require('leap').create_default_mappings()



-- treesitter
-- vim.opt.smartindent = false -- disable smartindent bc it interferes

require'nvim-treesitter.configs'.setup {
  ensure_installed = { "python", "typescript", "java", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },
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

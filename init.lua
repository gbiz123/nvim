-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	 'mattn/emmet-vim',
	 'norcalli/nvim-colorizer.lua',
	 'EdenEast/nightfox.nvim',
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

-- vim.g.gruvbox_material_enable_italic = true
-- vim.g.gruvbox_material_enable_bold = true
-- vim.g.gruvbox_material_background = 'hard'
-- vim.g.gruvbox_material_dim_inactive_windows = true
-- vim.g.gruvbox_material_visual = 'blue background'
-- vim.g.gruvbox_material_current_word = 'underline'
-- vim.g.gruvbox_material_better_performance = 1
-- vim.cmd('colorscheme gruvbox-material')

-- require('kanagawa-paper').setup({
--   undercurl = true,
--   transparent = false,
--   gutter = false,
--   dimInactive = true, -- disabled when transparent
--   terminalColors = true,
--   commentStyle = { italic = true },
--   functionStyle = { italic = false },
--   keywordStyle = { italic = false, bold = false },
--   statementStyle = { italic = false, bold = false },
--   typeStyle = { italic = false },
--   colors = { theme = {}, palette = {} }, -- override default palette and theme colors
--   overrides = function()  -- override highlight groups
--     return {}
--   end,
-- })
-- vim.cmd('colorscheme kanagawa-paper')

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
  palettes = {},
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
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lsp_signature_help' }
	}, {
		name = 'buffer'
	}),
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp
require('lspconfig').jdtls.setup({ 
	capabilities = capabilities,
	-- Enable signature help: https://github.com/mfussenegger/nvim-jdtls/issues/88
	on_init = function(client)
	  client.server_capabilities.semanticTokensProvider = nil -- Disable lsp highlighting 
	  if client.config.settings then
		client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
	  end
	end
})
require('lspconfig').basedpyright.setup({ capabilities = capabilities })
require('lspconfig').lua_ls.setup({ capabilities = capabilities })
require('lspconfig').html.setup({ capabilities = capabilities })
require'lspconfig'.ts_ls.setup {}

-- key map
vim.keymap.set('n', '<C-n>', function() vim.cmd('NvimTreeToggle') end)
vim.keymap.set('n', '<C-f>', function() vim.cmd('Telescope find_files') end)
vim.keymap.set('n', '<C-g>', function() vim.cmd('Telescope live_grep') end)
vim.keymap.set('n', 'H', function() vim.diagnostic.open_float() end)
vim.keymap.set('n', 'S', function() vim.lsp.buf.signature_help() end)
vim.keymap.set('n', '<C-j><C-t>', function() vim.lsp.buf.type_definition() end)
vim.keymap.set('n', '<C-j><C-d>', function() vim.lsp.buf.definition() end)


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
	  enable = true
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

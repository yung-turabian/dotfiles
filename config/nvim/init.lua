-- ========================================================================== --
-- ==                           EDITOR SETTINGS                            == --
-- ========================================================================== --

vim.opt.number = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.termguicolors = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.signcolumn = 'yes'

vim.opt.undofile = true
-- Set crotab -e >> 0 0 * * * find ~/.nvim/undodir -type f -mtime +15 -delete
vim.opt.undodir = vim.fn.expand("~/.nvim/undotrunk")


vim.loader.enable()

-- Space as leader key
vim.g.mapleader = ' '

-- Basic clipboard interaction
vim.keymap.set({'n', 'x', 'o'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x', 'o'}, 'gp', '"+p', {desc = 'Paste clipboard content'})

vim.keymap.set('n', ';', ':', { noremap = true })

local default_path = vim.fn.expand("~/")

if vim.g.neovide then
		vim.g.neovide_hide_mouse_when_typing = false

		vim.g.neovide_theme = 'auto'
		vim.g.neovide_refresh_rate = 60
		vim.g.neovide_confirm_quit = true

		vim.g.neovide_remember_window_size = true
		vim.g.neovide_cursor_animation_length = 0
		vim.g.neovide_scroll_animation_length = 0

		vim.api.nvim_set_current_dir(default_path)
end

vim.api.nvim_create_augroup('filetypedetect', { clear = true })
vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile' }, {
		pattern = '*.he.txt',
		command = 'set filetype=hebrew-text',
		group = 'filetypedetect',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'hebrew-text',
  command = 'setlocal textwidth=0 | setlocal formatoptions=cqt | setlocal spelllang=he | setlocal rightleft | setlocal rightleftcmd | setlocal keymap=hebrew | setlocal revins',
})

local function get_window_width()
    local width = vim.api.nvim_win_get_width(0)  -- 0 refers to the current window
    print("Window width in cursor blocks: " .. width)
end

-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
  if not vim.loop.fs_stat(path) then
    print('Installing lazy.nvim....')
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      path,
    })
  end
end

function lazy.setup(plugins)
  if vim.g.plugins_ready then
    return
  end

  -- You can "comment out" the line below after lazy.nvim is installed
  -- lazy.install(lazy.path)

  vim.opt.rtp:prepend(lazy.path)

  require('lazy').setup(plugins, lazy.opts)
  vim.g.plugins_ready = true
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

-- Learn more about lazy.nvim
-- https://dev.to/vonheikemen/lazynvim-plugin-configuration-3opi
lazy.setup({
  {'yung-turabian/woke-moralist'},
	{dir = '~/test'},
  {'nvim-lualine/lualine.nvim'},
  {'nvim-lua/plenary.nvim', build = false},
  {'nvim-treesitter/nvim-treesitter'},
  {'nvim-telescope/telescope.nvim', branch = '0.1.x', build = false},
  {'natecraddock/telescope-zf-native.nvim', build = false},
  {'echasnovski/mini.nvim', branch = 'stable'},
	{'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Mandatory
        'nvim-tree/nvim-web-devicons', -- Optional but recommended
    },
	},
	{
			'sainnhe/everforest',
			lazy = false,
			priority = 1000,
			config = function()

						vim.g.everforest_enable_italic = true
						vim.g.everforest_better_performance = 1
						vim.cmd.colorscheme('everforest')

						require'lualine'.setup {
										options = {
										theme = 'everforest'
								}
						}	
		  end
	},
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --


vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

-- See :help netrw-browse-maps
vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<cr>', {desc = 'Toggle file explorer'})
vim.keymap.set('n', '<leader>E', '<cmd>Lexplore %:p:h<cr>', {desc = 'Open file explorer in current file'})

require('render-markdown').setup({
		heading = {
				enabled = true,
				sign = true,
				icons = { '', '', '', '', '', '' },
				signs = { '§' },
		},
		bullet = {
				enabled = true,

				icons = { '+', '▶', '±'},
		},
})

-- See :help lualine.txt
require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
		lualine_b = {},
    lualine_c = {
		{'filename', padding = {left=2, right=8}, color = {gui='bold'}},

		{'progress', padding = {right = 1}}, {'location', padding = {left = 0, right = 2}},

		 'branch',
		
		{ 	function() 
						local filetype = vim.bo.filetype
						return filetype ~= '' and '(' .. filetype .. ')'  or '(?)' 
				end, 
				padding = { left = 2, right = 10 }, 
		},

		},

    lualine_x = {'encoding'},
    lualine_y = {},
    lualine_z = {}
  },
}

-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
  highlight = { enable = true, },
  auto_install = true,
  ensure_installed = {'lua', 'vim', 'vimdoc', 'json'},
})

-- See :help MiniAi-textobject-builtin
require('mini.ai').setup({n_lines = 500})

-- See :help MiniComment.config
require('mini.comment').setup({})

-- See :help MiniSurround.config
require('mini.surround').setup({})

-- See :help MiniBufremove.config
require('mini.bufremove').setup({})

-- See :help MiniNotify.config
require('mini.notify').setup({
  lsp_progress = {enable = false},
})

-- See :help MiniNotify.make_notify()
vim.notify = require('mini.notify').make_notify({})

-- Close buffer and preserve window layout
vim.keymap.set('n', '<leader>bc', '<cmd>lua pcall(MiniBufremove.delete)<cr>', {desc = 'Close buffer'})

-- See :help telescope.builtin
vim.keymap.set('n', '<leader>?', '<cmd>Telescope oldfiles<cr>', {desc = 'Search file history'})
vim.keymap.set('n', '<leader><space>', '<cmd>Telescope buffers<cr>', {desc = 'Search open files'})
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {desc = 'Search all files'})
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {desc = 'Search in project'})
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope diagnostics<cr>', {desc = 'Search diagnostics'})
vim.keymap.set('n', '<leader>fs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', {desc = 'Buffer local search'})

require('telescope').load_extension('zf-native')

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

vim.opt.undodir = "."
vim.opt.undofile = true

-- Space as leader key
vim.g.mapleader = ' '

-- Basic clipboard interaction
vim.keymap.set({'n', 'x', 'o'}, 'gy', '"+y', {desc = 'Copy to clipboard'})
vim.keymap.set({'n', 'x', 'o'}, 'gp', '"+p', {desc = 'Paste clipboard content'})

vim.keymap.set('n', ';', ':', { noremap = true })

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
  {'folke/which-key.nvim'},
	{dir = '~/test'},
  {'nvim-lualine/lualine.nvim'},
  {'nvim-lua/plenary.nvim', build = false},
  {'nvim-treesitter/nvim-treesitter'},
  {'nvim-telescope/telescope.nvim', branch = '0.1.x', build = false},
  {'natecraddock/telescope-zf-native.nvim', build = false},
  {'echasnovski/mini.nvim', branch = 'stable'},
	{
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- Mandatory
        'nvim-tree/nvim-web-devicons', -- Optional but recommended
    },
    config = function()
        require('render-markdown').setup({})
    end,
	},
	{'dimfeld/section-wordcount.nvim',
		config = function()
			require('section-wordcount').setup{
				highlight = "String",
				virt_text_pos = "eol",
			}


			vim.api.nvim_exec([[
				augroup SectionWordcount
					autocmd!
					autocmd FileType markdown lua require('section-wordcount').wordcounter{ header_char = '##' }
					autocmd FileType asciidoc lua require('section-wordcount').wordcounter{ header_char = '=' }
				augroup END
			]], false)
		end,
	},
	{'rktjmp/lush.nvim'},
})

-- ========================================================================== --
-- ==                         PLUGIN CONFIGURATION                         == --
-- ========================================================================== --

vim.cmd.colorscheme('retrobox')

vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

-- See :help netrw-browse-maps
vim.keymap.set('n', '<leader>e', '<cmd>Lexplore<cr>', {desc = 'Toggle file explorer'})
vim.keymap.set('n', '<leader>E', '<cmd>Lexplore %:p:h<cr>', {desc = 'Open file explorer in current file'})

-- See :help lualine.txt
require('lualine').setup({
  options = {
    icons_enabled = true,
    component_separators = '|',
    section_separators = '',
  },
})

-- See :help nvim-treesitter-modules
require('nvim-treesitter.configs').setup({
  highlight = { enable = true, },
  auto_install = true,
  ensure_installed = {'lua', 'vim', 'vimdoc', 'json'},
})

-- See :help which-key.nvim-which-key-configuration
require('which-key').setup({})
require('which-key').register({
  ['<leader>f'] = {name = 'Fuzzy Find', _ = 'which_key_ignore'},
  ['<leader>b'] = {name = 'Buffer', _ = 'which_key_ignore'},
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

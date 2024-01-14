vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Don't require settings
  'tpope/vim-sleuth',                                     -- Detect tabstop and shiftwidth automatically
  'ap/vim-css-color',                                     -- HEX colors
  'vim-pandoc/vim-pandoc',                                -- Markdown Pandoc
  'vim-pandoc/vim-pandoc-syntax',                         -- Markdown Pandoc syntax

  -- Loading default settings
  { 'numToStr/Comment.nvim', opts = {} },                 -- "gc" to comment visual regions/lines

  -- Setting options while calling
  {
    'navarasu/onedark.nvim',                              -- Theme inspired by Atom
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',                -- Add indentation guides even on blank lines
    main = 'ibl',
    opts = {
      scope = { show_start = false, show_end = false }
    },
  },

  -- Settings are further ahead
  'lewis6991/gitsigns.nvim',                              -- Git related plugins
  'nvim-lualine/lualine.nvim',                            -- Set lualine as status line
  { 'folke/which-key.nvim', opts = {} },                  -- Useful plugin to show you pending keybinds.
  {
    'nvim-telescope/telescope.nvim',                      -- Fuzzy Finder (files, lsp, etc)
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
    'neovim/nvim-lspconfig',                              -- LSP Configuration & Plugins
    dependencies = {
      { 'williamboman/mason.nvim', config = true },       -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} }                  -- Help with nvim lua configuration
    },
  },
  {
    'hrsh7th/nvim-cmp',                                   -- Autocompletion
    dependencies = {
      -- Snippet Engine
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'f3fora/cmp-spell',
      -- 'jc-doyle/cmp-pandoc-references'
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',                    -- Highlight, edit, and navigate code
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    build = ':TSUpdate',
  },
  {
    'quarto-dev/quarto-nvim',                             -- Quarto suit of stuff
    dependencies = {
      'jmbuhr/otter.nvim',
    }
  }
}, {})

-- [[ Setting options ]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Line options
vim.o.cursorline = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.breakindent = false

-- Tabs
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4

-- Search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
vim.o.clipboard = 'unnamedplus'

-- Save undo history
vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Window decoration
vim.o.signcolumn = 'yes'
vim.o.showtabline = 2

-- Split windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Good colors
vim.o.termguicolors = true

-- Buffer movement
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- Command prompt
vim.o.showmode = false

-- Diable folding
vim.o.foldenable = false

-- Set language options
vim.o.spell = true

-- [[ Basic Keymaps ]]

-- Getting rid of annoying keymaps
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<F1>", "<Esc>")
vim.keymap.set("i", "<F1>", "<Esc>")

-- Stay in visual mode after indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Moving selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Retain copied text
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Send copied text to register +
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Plantillas
vim.keymap.set("n", "<leader>,Rmd", ":-1read $HOME/.vim/plantillas/pl_mitra.Rmd<CR>")
vim.keymap.set("n", "<leader>,r", ":-1read $HOME/.vim/plantillas/pl_mitra.r<CR>")
vim.keymap.set("n", "<leader>,jl", ":-1read $HOME/.vim/plantillas/pl_mitra.jl<CR>")

-- Spell check
vim.keymap.set("n", "<leader>se", ":setlocal spell spelllang=es<CR>")
vim.keymap.set("n", "<leader>si", ":setlocal spell spelllang=en<CR>")
vim.keymap.set("n", "<leader>sa", ":setlocal spell spelllang=es,en<CR>")
vim.keymap.set("n", "<leader>sx", ":set nospell<CR>")

-- Open keymap file
vim.keymap.set('n', '<leader>km', ':tabnew ~/.config/nvim/keymaps.md', {desc = 'Open keymaps file in a separate Tab'})
vim.keymap.set('n', '<leader>kM', ':vsplit ~/.config/nvim/keymaps.md', {desc = 'Open keymaps file in a vertical window'})

-- [[ Configure nvim diagnostics ]]

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = 'X',
      [vim.diagnostic.severity.WARN] = '!',
      [vim.diagnostic.severity.INFO] = '?',
      [vim.diagnostic.severity.HINT] = '+',
    }
  }
})

-- [[ Configure lualine ]]

require('lualine').setup({
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',
        sources = {'nvim_diagnostic', 'nvim_lsp'},
        symbols = {error = 'X', warn = '!', info = '?', hint = '+'},
      }
    },
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

-- [[ Configure gitsigns ]]

require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end
    map('n', '<leader>gs', gs.stage_buffer, { desc = 'git Stage buffer' })
    map('n', '<leader>gr', gs.reset_buffer, { desc = 'git Reset buffer' })
    map('n', '<leader>gb', function() gs.blame_line { full = false } end, { desc = 'git blame line' })
    map('n', '<leader>gf', gs.diffthis, { desc = 'git diff against index' })
    map('n', '<leader>gd', gs.toggle_deleted, { desc = 'toggle git show deleted' })
  end,
}

-- [[ Configure telescope ]]

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  if current_file == '' then
    current_dir = cwd
  else
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end
vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f/', require('telescope.builtin').current_buffer_fuzzy_find, { desc = '[/] Fuzzily search current buffer' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]

vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'lua', 'python', 'vimdoc', 'vim', 'bash', 'r', 'julia', 'html' },
    auto_install = false,
    sync_install = false,
    ignore_install = { "markdown", "markdown_inline" },
    modules = {},
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-i>',
        node_decremental = '<c-d>'
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = { ['[f'] = '@function.outer', },
        goto_previous_start = { [']f'] = '@function.outer', },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>lgd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('<leader>lgr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>lgi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  -- nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>lds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>lws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- [[ Configure which-key ]]

require('which-key').register {
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- [[ Configure mason ]]

require('mason').setup()
require('mason-lspconfig').setup()
local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
}

-- [[ Configure nvim-cmp + mason ]]

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- [[ Configure nvim-cmp ]]

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'buffer' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'spell' },
  },
}


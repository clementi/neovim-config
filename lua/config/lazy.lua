-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { 'airblade/vim-gitgutter' },
    { 'editorconfig/editorconfig-vim' },
    { 'jiangmiao/auto-pairs' },
    { 'preservim/nerdcommenter' },
    { 'tpope/vim-surround' },
    { 'ibhagwan/fzf-lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {},
    },
    -- { 'mistweaverco/kulala.nvim',
      -- keys = {
        -- { "<leader>Rs", desc = "Send request" },
        -- { "<leader>Ra", desc = "Send all requests" },
        -- { "<leader>Rb", desc = "Open scratchpad" },
      -- },
      -- ft = {"http", "rest"},
      -- opts = {
        -- global_keymaps = true,
      -- },
    -- },
    { 'nvim-lualine/lualine.nvim',
      dependencies = { 
        'nvim-tree/nvim-web-devicons'
      },
      config = function()
        require('lualine').setup({
          theme = 'auto'
        })
      end
    },
    {
      'serhez/bento.nvim',
      opts = {},
    },
    {
      'shadyalfred/electric-quotes.nvim',
      dependencies = { 'uga-rosa/utf8.nvim' },
      cmd = 'ElectricQuotesToggle',
    },
    { 'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      opts = function(_, opts)
        require("nvim-treesitter.install").prefer_git = true

        if opts.ensure_installed then
          table.insert(opts.ensure_installed, 'context')
        end
        local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

        parser_configs.context = {
          install_info = {
            url = 'https://github.com/pmazaitis/tree-sitter-context',
            files = { 'src/parser.c', 'src/scanner.c' },
            branch = 'main',
            generate_requires_npm = false,
            requires_generate_from_grammar = false,
          },
          filetype = 'context',
        }
      end,
      config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
          ensure_installed = { 
            'c',
            'context',
            'cpp',
            'go',
            'haskell',
            'html',
            'java',
            'javascript',
            'json',
            'jsonc',
            'latex',
            'lua',
            'nu',
            'jinja',
            'python',
            'racket',
            'rust',
            'scala',
            'scheme',
            'typescript',
            'typst',
            'vim',
            'vimdoc',
            'xml',
            'zig',
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end
    },
    { 'romgrk/barbar.nvim' },
    { 
      'nvim-neo-tree/neo-tree.nvim',
      branch = 'v3.x', 
      dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        'nvim-tree/nvim-web-devicons',
      },
      lazy = false,
    },
    { 'leafgarland/typescript-vim' },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        'https://git.myzel394.app/Myzel394/jsonfly.nvim',
      },
      config = function()
        require('telescope').load_extension('jsonfly')
      end,
      keys = {
        {
          '<leader>j',
          '<cmd>Telescope jsonfly<cr>',
          desc = 'Optn json(fly)',
          ft = { 'json', 'xml', 'yaml' },
          mode = 'n',
        }
      }
    },
    { 
      'catppuccin/nvim', 
      name = "catppuccin",
      priority = 1000,
      config = function()
        require('catppuccin').setup({
          no_italic = true,
        })
      end,
    },
    { 'clementi/ghostty-dark.nvim', priority = 1000, },
    { 'neovimhaskell/haskell-vim' },
    { 'pangloss/vim-javascript' },
    { 'stefanos82/nelua.vim' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "hybrid" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

vim.cmd.colorscheme 'catppuccin-macchiato'

-- Refresh filetype detection
vim.api.nvim_set_keymap(
  'n',
  '<F10>',
  [[:filetype detect<CR>]],
  { noremap = true, silent = true }
)

-- Open URL under cursor with gx
vim.api.nvim_set_keymap(
  'n',
  'gx',
  [[:lua _G.open_url_under_cursor()<CR>]],
  { noremap = true, silent = true }
)

-- Function to open URL under cursor
function _G.open_url_under_cursor()
  -- Get the current word under cursor
  local word = vim.fn.expand('<cWORD>')

  -- Attempt to extract URL inside parentheses, brackets, or quotes
  local url = word:match("https?://[%w-_%.%?%.:/%+=&]+")
  
  if url then
    local open_cmd
    if vim.fn.has('mac') == 1 then
      open_cmd = 'open'
    elseif vim.fn.has('unix') == 1 then
      open_cmd = 'xdg-open'
    else
      print('Unsupported OS')
      return
    end
    vim.fn.jobstart({open_cmd, url}, {detach = true})
  else
    print('No valid URL under cursor')
  end
end


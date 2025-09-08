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
    { 'mattn/emmet-vim' },
    { 'preservim/nerdcommenter' },
    { 'tpope/vim-surround' },
    { 'ibhagwan/fzf-lua',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {},
    },
    { 'mistweaverco/kulala.nvim',
      keys = {
        { "<leader>Rs", desc = "Send request" },
        { "<leader>Ra", desc = "Send all requests" },
        { "<leader>Rb", desc = "Open scratchpad" },
      },
      ft = {"http", "rest"},
      opts = {
        global_keymaps = true,
      },
    },
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
    { 'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
          ensure_installed = { 
            'c',
            'cpp',
            'go',
            'haskell',
            'html',
            'java',
            'javascript',
            'json',
            'jsonc',
            'lua',
            'nu',
            'python',
            'racket',
            'rust',
            'scala',
            'scheme',
            'typescript',
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
    -- { 'kaicataldo/material.vim' },
    -- { 'rebelot/kanagawa.nvim' },
    -- { 'EdenEast/nightfox.nvim' },
    -- { 'joshdick/onedark.vim' },
    -- { 'navarasu/onedark.nvim',
      -- priority = 1000,
      -- config = function()
        -- require('onedark').setup {
          -- style = 'darker'
        -- }
        -- require('onedark').load()
      -- end
    -- },
    -- {
      -- 'marko-cerovac/material.nvim',
    -- },
    -- { 'RRethy/base16-nvim' },
    { 'catppuccin/nvim', name = "catppuccin", priority = 1000 },
    { 'clementi/ghostty-dark.nvim', priority = 1000 },
    -- { 'w0ng/vim-hybrid' },
    -- { 'ColinKennedy/hybrid2.nvim' },
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

vim.cmd.colorscheme 'ghostty-dark'

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
    { 'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    { 'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        local configs = require('nvim-treesitter.configs')

        configs.setup({
          ensure_installed = { 
            'c', 'cpp', 'lua', 'vim', 'vimdoc',
            'javascript', 'html', 'scala', 'java',
            'typescript', 'haskell', 'python',
            'xml', 'json',
          },
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
      end
    },
    { 'rafi/awesome-vim-colorschemes' },
    { 'leafgarland/typescript-vim' },
    { 'kaicataldo/material.vim' },
    { 'neovimhaskell/haskell-vim' },
    { 'pangloss/vim-javascript' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "hybrid" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

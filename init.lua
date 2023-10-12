local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt
local api = vim.api

g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

cmd.filetype 'plugin indent on'

opt.autoindent = true
opt.expandtab = true
opt.linebreak = true
opt.number = true
opt.shiftwidth = 4
opt.shortmess = opt.shortmess + 'I'
opt.tabstop = 4
opt.termguicolors = true

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    if opts.desc then
      opts.desc = "keymaps.lua: " .. opts.desc
    end
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

function remove_trailing_whitespace()
  cmd '%s/\\s\\+$//e'
end

api.nvim_create_autocmd(
  'FileType',
  {
    pattern = {
      'haskell', 'scala', 'c', 'cpp', 'java',
      'python', 'fsharp', 'fstar', 'ocaml', 'sml',
      'csharp', 'json', 'jsonc', 'javascript', 'scheme',
      'racket', 'clojure', 'lisp', 'd', 'rust',
      'go', 'typescript' },
    command = 'autocmd BufWritePre <buffer> lua remove_trailing_whitespace()'
  }
)

map('n', '<F12>', ':set nu!<CR>')
map('n', '<leader>n', ':set nu!<CR>')
map('n', '<F11>', ':set cursorline!<CR>')
map('n', '<leader>l', ':set cursorline!<CR>')
map('n', '<leader>p', ':w!!pf<CR>')
map('n', '<leader>t', ':NvimTreeToggle<CR>')

map('n', '<C-Tab>', ':bn!<CR>')
map('n', '<C-S-Tab>', ':bp!<CR>')
map('n', '<C-j>', ':bp!<CR>')
map('n', '<C-k>', ':bn!<CR>')

map('n', '<Up>', '<Nop>')
map('n', '<Down>', '<Nop>')
map('n', '<Left>', '<Nop>')
map('n', '<Right>', '<Nop>')
map('i', '<Up>', '<Nop>')
map('i', '<Down>', '<Nop>')
map('i', '<Left>', '<Nop>')
map('i', '<Right>', '<Nop>')

map('n', '<leader>s', ':lua remove_trailing_whitespace()<CR>', { desc = 'Remove trailing whitespace' })

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
end

require('packer').startup(function(use)
  use "wbthomason/packer.nvim"

  -- Tools & Settings
  use 'airblade/vim-gitgutter'
  use 'editorconfig/editorconfig-vim'
  use 'github/copilot.vim'
  use 'jiangmiao/auto-pairs'
  use 'mattn/emmet-vim'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'preservim/nerdcommenter'
  use 'tpope/vim-surround'
  use { 'wfxr/minimap.vim', ["do"] = ':!cargo binstall --locked code-minimap' }

  -- Color Schemes
  -- use 'rafi/awesome-vim-colorschemes'
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Languages
  use 'cespare/vim-toml'
  use 'fatih/vim-go'
  use 'leafgarland/typescript-vim'
  use 'neovimhaskell/haskell-vim'
  use 'pangloss/vim-javascript'
  use 'PProvost/vim-ps1'
  use 'rust-lang/rust.vim'
  use 'tomlion/vim-solidity'
  use 'NoahTheDuke/vim-just'
  -- use { 'unisonweb/unison', tag = 'latest', rtp = 'editor-support/vim' }
  use 'ziglang/zig.vim'

  if packer_bootstrap then
    require('packer').sync()
  end

  require('nvim-tree').setup()
  require('lualine').setup({
    tabline = {
      lualine_a = {'buffers'},
      lualine_b = {'branch'},
      lualine_c = {'filename'},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {'tabs'}
    }
  })
end)

cmd.colorscheme 'catppuccin'

g.NERDSpaceDelims = 1
g.NERDCustomDelimiters = {
  fstar = { left = '(*', right = '*)' },
  jsonc = { left = '//', right = '' },
  qs = { left = '//', right = '' }
}
g.user_emmet_leader_key = '<C-Z>'

g.minimap_auto_start = 1

-- cmd ":NvimTreeOpen"

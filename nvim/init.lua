---------------------------------------------------------------------------------
-- [Section A]                   Basic Configs                                 --
---------------------------------------------------------------------------------

-- A.1 Core Configs 
---------------------------
vim.cmd("let g:netrw_liststyle = 3")
vim.opt.clipboard:append("unnamedplus") 
vim.g.loaded_netrw                          = 1
vim.g.loaded_netrwPlugin                    = 1
local opt                                   = vim.opt
opt.relativenumber                          = true
opt.number                                  = true
opt.tabstop                                 = 2 
opt.shiftwidth                              = 2 
opt.expandtab                               = true 
opt.autoindent                              = true 
opt.wrap                                    = false
opt.ignorecase                              = true 
opt.smartcase                               = true 
opt.cursorline                              = true
opt.termguicolors                           = true
opt.background                              = "dark" 
opt.signcolumn                              = "yes" 
opt.backspace                               = "indent,eol,start" 
opt.splitright                              = true 
opt.splitbelow                              = true 
opt.swapfile                                = false

-- A.2 Key Binds 
---------------------------
vim.g.mapleader = " "
local keymap = vim.keymap
keymap.set("n", "<leader>j", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle NvimTree File Explorer"})
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find todos" })



---------------------------------------------------------------------------------
-- [Section B]                      Plugins                                    --
---------------------------------------------------------------------------------

--- B.1  Plugin Source
---------------------------
vim.pack.add({
  -->> Colorscheme
  {src = "https://github.com/0xstepit/flow.nvim"},

  -->> Netrw Directory Tree navigation
  {src = "https://github.com/nvim-tree/nvim-tree.lua.git"},

  -->> Telescope Grep Wizardry
  {src = "https://github.com/nvim-telescope/telescope.nvim.git"},
  {src = "https://github.com/nvim-lua/plenary.nvim.git"},
  {src = "https://github.com/nvim-tree/nvim-web-devicons.git"},

  -->> TODO Comments
  {src = "https://github.com/folke/todo-comments.nvim.git"},

  -->> Neoscroll Buffer Scrolling Animation
  {src = "https://github.com/karb94/neoscroll.nvim.git"},

  -->> LSP Configs Plugins
  {src = "https://github.com/nvim-treesitter/nvim-treesitter.git"},
  {src = "https://github.com/mason-org/mason.nvim.git"},
  {src = "https://github.com/neovim/nvim-lspconfig"},
  {src = "https://github.com/saghen/blink.cmp.git"},
})


-- B.2  Nvim-Tree
---------------------------
require("nvim-tree").setup()


-- B.3  Colorscheme
---------------------------
require("flow").setup({
  theme = {
    mode = "dark",
    contrast = "high",
    transparent = true
  },
  colors = {
    mode = "light",
    fluo = "green"
  },
  ui = {
    borders = "fluo"
  }
})
vim.cmd("colorscheme flow")


-- B.4  NeoScroll 
---------------------------
require("neoscroll").setup({
  mappings = {
    "<C-u>", "<C-d>",
    "<C-b>", "<C-f>",
    "<C-y>", "<C-e>",
    "zt", "zz", "zb"
  },
  hide_cursor = true,
  stop_eof = true,
  easing = "linear"
})


-- B.5  LSP  
---------------------------
require("mason").setup()

vim.lsp.enable({
  "tailwindcss-language-server",
  "typescript-language-server",
  "lua-language-server",
  "eslint-lsp",
  "html-lsp",
  "pyright",
  "css-lsp"
})


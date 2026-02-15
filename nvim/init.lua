---------------------------
--    Basic Configs      --
---------------------------
-->> NetRW stuff for NvimTree
vim.cmd("let g:netrw_liststyle = 3")
vim.g.loaded_netrw                          = 1
vim.g.loaded_netrwPlugin                    = 1

-->> Leader and Binds
vim.g.mapleader = " "
local keymap = vim.keymap
keymap.set("n", "<leader>j", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle NvimTree File Explorer"})
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find todos" })



-->> Core Optipons
local opt = vim.opt
opt.clipboard:append("unnamedplus") 
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



---------------------------
--   Plugin Management   --
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


})
---------------------------
-- END Plugin Management --
---------------------------


---------------------------
--       Nvim-Tree       --
---------------------------
require("nvim-tree").setup()




---------------------------
--      Colorscheme      --
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

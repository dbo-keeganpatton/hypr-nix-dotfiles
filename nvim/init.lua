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



---------------------------------------------------------------------------------
-- [Section B]                   Key Binds                                  --
---------------------------------------------------------------------------------

-- B.1 Leader and Globals
---------------------------
vim.g.mapleader = " "
local keymap = vim.keymap


-- B.2 NvimTree 
---------------------------
keymap.set("n", "<leader>j", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle NvimTree File Explorer"})


-- B.3 Telescope 
---------------------------
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Find todos" })


-- B.4 Trouble 
---------------------------
keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix (Trouble)" })
keymap.set("n", "<leader>xt", "<cmd>Trouble todo toggle<cr>", { desc = "Todo (Trouble)" })


-- B.5 Multicursor 
---------------------------
keymap.set({"n", "x"}, "<up>", function() require("multicursor-nvim").lineAddCursor(-1) end)
keymap.set({"n", "x"}, "<down>", function() require("multicursor-nvim").lineAddCursor(1) end)
keymap.set(
  {"n"},
  "<esc>",
  function()
    if not require("multicursor-nvim").cursorsEnabled() 
      then require("multicursor-nvim").enableCursors()
    else require("multicursor-nvim").clearCursors()
    end
  end
)


---------------------------------------------------------------------------------
-- [Section C]                      Plugins                                    --
---------------------------------------------------------------------------------

-- C.1  Plugin Source
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
  {src = "https://github.com/mason-org/mason-lspconfig.nvim.git"},
  {src = "https://github.com/neovim/nvim-lspconfig"},
  {src = "https://github.com/hrsh7th/nvim-cmp.git"},
  {src = "https://github.com/hrsh7th/cmp-nvim-lsp.git"},
  {src = "https://github.com/hrsh7th/cmp-buffer.git"},
  {src = "https://github.com/hrsh7th/cmp-path.git"},

  -->> Quality of Life
  {src = "https://github.com/windwp/nvim-autopairs.git"},
  {src = "https://github.com/jake-stewart/multicursor.nvim.git"},
  {src = "https://github.com/MeanderingProgrammer/render-markdown.nvim.git"},
  {src = "https://github.com/nvim-lualine/lualine.nvim.git"},
  {src = "https://github.com/lewis6991/gitsigns.nvim.git"},

  -->> Debugging
  {src = "https://github.com/folke/trouble.nvim.git"},
})


-- C.2  Nvim-Tree
---------------------------
require("nvim-tree").setup()


-- C.3  Colorscheme
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


-- C.4  NeoScroll 
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


-- C.5  LSP  
---------------------------
require("mason").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.enable({
  "tailwindcss",
  "ts_ls",
  "lua-language-server",
  "vim-language-server",
  "eslint-lsp",
  "html",
  "pyright",
  "cssls"
}, {capabilities = capabilities})

--> Auto Completions and dropdown
--> documentation
local cmp = require("cmp")
cmp.setup({

  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  --> Auto Complete Menu Navigation Binds
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping.scroll_docs(-4),
    ["<S-Tab>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), 
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp" }, 
    { name = "path" },
  }, {{ name = "buffer" },}),

})


-- C.6  Formatting  
---------------------------
require("nvim-autopairs").setup({})
local cmp_autopairs = require("nvim-autopairs.completion.cmp")


-- C.7  Debugging
---------------------------
require("trouble").setup({})
require("todo-comments").setup({})
require("gitsigns").setup({})


-- C.8  Quality of Life 
---------------------------
require("multicursor-nvim").setup({})
require("render-markdown").setup({})
require("lualine").setup({
  options = {
    icons_enabled = false,
    theme = "16color"
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
})





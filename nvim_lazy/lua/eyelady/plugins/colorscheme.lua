--! CyberDream -->>
-- return {
--   "scottmckendry/cyberdream.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("cyberdream").setup({
--       transparent = true,
--       italic_comments = true,
--       terminal_colors = true,
--       hide_fillchars = true,
--       borderless_telescope = true,
--       theme = {
--         saturation = 1,
--       },
--     })
--     vim.cmd("colorscheme cyberdream")
--   end,
-- }
--

--! Flow -->>
return {
  "0xstepit/flow.nvim",
  lazy = false,
  priority = 1000,
  tag = "v2.0.1",
  opts = {
    theme = {
      style = "dark", --  "dark" | "light"
      contrast = "high", -- "default" | "high"
      transparent = true, -- true | false
    },
    colors = {
      mode = "dark", -- "default" | "dark" | "light"
      fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
      custom = {
        saturation = "70", -- "" | string representing an integer between 0 and 100
        light = "50", -- "" | string representing an integer between 0 and 100
      },
    },
    ui = {
      borders = "fluo", -- "theme" | "inverse" | "fluo" | "none"
      aggressive_spell = true, -- true | false
    },
  },
  config = function(_, opts)
    require("flow").setup(opts)
    vim.cmd("colorscheme flow")
  end,
}
--
-- Jonathan Blow inspired
-- return {
--   "vague-theme/vague.nvim",
--   lazy = false,
--   priority = 1000,
--   config = function()
--     require("vague").setup({
--       transparent = false,
--       bold = true,
--       italic = true,
--       colors = {
--         bg = "#052329",
--         inactivebg = "#183848",
--         fg = "#D0C0A0",
--         floatborder = "#ff0000",
--         line = "#0e2632",
--         comment = "#40c040",
--         builtin = "#fff2c9",
--         func = "#b0ffb0",
--         string = "#40b0a0",
--         number = "#80f0e0",
--         property = "#d0c0a0",
--         constant = "#b0ffb0",
--         parameter = "#d0c0a0",
--         visual = "#0c242a",
--         error = "#d8647e",
--         warning = "#f3be7c",
--         hint = "#7e98e8",
--         operator = "#90a0b5",
--         keyword = "#b0ffb0",
--         type = "#a0d0e0",
--         search = "#184d68",
--         plus = "#7fa563",
--         delta = "#f3be7c",
--       },
--     })
--     vim.cmd("colorscheme vague")
--   end,
-- }

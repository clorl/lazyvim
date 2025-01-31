return {
  {
    "sheerun/vim-polyglot",
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    lazy = false,
    keys = {
      { "<BS>", "<cmd>Oil<cr>" },
      { "<leader>e", "<cmd>Oil<cr>" },
    },
  },
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "folke/lazydev.nvim",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  {
    "MagicDuck/grug-far.nvim",
    enabled = false,
  },
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "folke/noice.nvim",
    enabled = false,
  },
  {
    "MunifTanjim/nui.nvim",
    enabled = false,
  },
  {
    "snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      scope = { enabled = false },
      scroll = { enabled = false },
      statuscolumn = { enabled = false }, -- we set this in options.lua
      zen = { enabled = true },
    },
  },
  {
    "folke/lazydev.nvim",
    enabled = false,
  },
}

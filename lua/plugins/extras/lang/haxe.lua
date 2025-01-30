return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "haxe",
      root = {
        "*.hxml",
      },
    })
  end,
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        haxe_language_server = {},
      },
    },
  },
}

local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")
local builtin = require("telescope.builtin")

local common_keymaps = {
  ["<Tab>"] = false,
  ["<S-Tab>"] = false,
  ["<C-/>"] = false,
  ["<C-_>"] = false,
  ["<C-,>"] = actions.which_key,
  ["<C-l>"] = actions_layout.cycle_layout_next,
}

local telescope_any_config = {
  [":"] = builtin.commands,
  ["/"] = builtin.live_grep,
  ["h "] = builtin.help_tags,

  ["m "] = builtin.marks,
  ["q "] = builtin.quickfix,
  ["l "] = builtin.loclist,
  ["j "] = builtin.jumplist,

  ["man "] = builtin.man_pages,
  ["opt "] = builtin.vim_options,
  ["k "] = builtin.keymaps,

  ["b "] = builtin.buffers,

  ["d "] = builtin.diagnostics,
  ["@"] = builtin.lsp_document_symbols,

  [""] = builtin.find_files,
}

return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        layout_config = {},
        path_display = {
          "filename_first",
        },
        mappings = {
          n = common_keymaps,
          i = common_keymaps,
        },
        cycle_layout_list = {
          "horizontal",
          "vertical",
          "bottom_pane",
        },
      },
    },
    keys = {
      --stylua: ignore start
      --{ "s", function() require("telescope.builtin").find_files() end, "Open Telescope" },
      --stylua: ignore end
    },
    dependencies = {
      {
        "d00h/telescope-any",
        lazy = false,
        config = function()
          local telescope_any = require("telescope-any").create_telescope_any({ pickers = telescope_any_config })
          vim.api.nvim_set_keymap("n", "s", "", {
            noremap = true,
            silent = true,
            callback = telescope_any,
          })
        end,
      },
    },
  },
}

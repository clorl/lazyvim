local LISTEN_ADDR = ""

local function start_listening_to_godot_commands()
  local addr = "/tmp/godot.pipe"

  if LISTEN_ADDR ~= nil and LISTEN_ADDR ~= "" then
    print("Neovim already listening to commands sent by Godot")
    return
  end

  local result = vim.fn.serverstart(addr)
  print("Listening to commands sent by Godot at " .. addr)
  LISTEN_ADDR = addr
end

vim.api.nvim_create_user_command("GodotStart", function(opts)
  start_listening_to_godot_commands()
end, {})

vim.api.nvim_create_user_command("GodotStop", function(opts)
  if LISTEN_ADDR == nil or LISTEN_ADDR == "" then
    print("No server to stop")
    return
  end

  vim.fn.serverstop(LISTEN_ADDR)
  print("Stopped listening to commands sent by Godot on: " .. LISTEN_ADDR)
  LISTEN_ADDR = ""
end, {})

vim.api.nvim_create_user_command("GodotStatus", function(opts)
  if LISTEN_ADDR ~= nil and LISTEN_ADDR ~= "" then
    print("Listening to commands sent by Godot at " .. LISTEN_ADDR)
  elseif LISTEN_ADDR == nil or LISTEN_ADDR == "" then
    print("No server to stop")
  end
  print("idk man")
end, {})

-- Autocommand group to avoid duplicate commands
vim.api.nvim_create_augroup("GodotProject", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.gd", "*.tscn", "*.gdns" },
  callback = function()
    local file = vim.fn.expand("%:t")
    if file:match("%.gd$") then
      vim.bo.filetype = "gdscript"
    elseif file:match("%.tscn$") then
      vim.bo.filetype = "godot_scene"
    elseif file:match("%.gdns$") then
      vim.bo.filetype = "godot_native"
    end

    start_listening_to_godot_commands()
  end,
  group = "GodotProject",
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.filereadable("project.godot") == 1 or vim.fn.filereadable("src/project.godot") == 1 then
      start_listening_to_godot_commands()
    end
  end,
  group = "GodotProject",
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.gd",
  callback = function() end,
})

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gdscript = {
          name = "godot",
          cmd = vim.lsp.rpc.connect("127.0.0.1", "6005"),
          root_dir = function(fname)
            local current_dir = vim.fn.expand("%:p:h")
            local project_root = vim.fn.findfile("project.godot", current_dir .. ";")

            if project_root == "" then
              project_root = vim.fn.findfile("project.godot", current_dir .. "/src;")
            end

            if project_root == "" then
              project_root = vim.fn.findfile("project.godot", ".;")
            end

            return project_root ~= "" and vim.fn.fnamemodify(project_root, ":p:h") or nil
          end,
        },
      },
    },
  },
}

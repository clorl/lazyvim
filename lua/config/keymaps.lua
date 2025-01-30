local m = vim.keymap.set

-- ── Easy escape terminal mode ───────────────────────────────────────
m("t", "<Esc>", "<C-\\><C-n>", { desc = "Escape Terminal Mode" })
m("n", "<Esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear search highlight" })

-- ── Don't save text with c or x ─────────────────────────────────────
m("n", "c", '"_c', { desc = "Replace" })
m("n", "x", '"_x', { desc = "Delete character" })

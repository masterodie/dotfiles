vim.keymap.set("n", "<leader><leader>x", function()
  vim.cmd([[source %]])
end, { desc = "Source current file" })

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "q:", "<nop>", { noremap = false })

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

local ok, wk = pcall(require, "which-key")

if ok then
  wk.register({
    ["<leader>f"] = { name = "+file" },
    ["<leader>p"] = { name = "+package" },
    ["<leader>c"] = { name = "+code" },
    ["<leader>x"] = { name = "+diagnostics" },
    ["<leader>d"] = { name = "+debug" },
    ["<leader>g"] = { name = "+git" },
    ["<leader>w"] = { name = "+workspace" },
    ["<leader>r"] = { name = "+refactor" },
    ["<leader>z"] = { name = "+zen" },
    ["<leader>n"] = { name = "+notes" },
  }, {})
end

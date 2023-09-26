local group = vim.api.nvim_create_augroup("database", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "FileType sql,mysql,plsql" },
  callback = function()
    require("cmp").setup.buffer({ sources = { { name = "vim-dadbod-completion" } } })
  end,
})

local mkdir_on_write_group = vim.api.nvim_create_augroup("mkdir_on_write", {clear = true})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  group = mkdir_on_write_group,
  callback = function()
    vim.fn.execute("!mkdir -p %:p:h", true)
  end
})

local M = {
  "kosayoda/nvim-lightbulb",
}

M.event = { "BufReadPre", "BufNewFile" }

M.opts = { autocmd = { enabled = true } }

return M

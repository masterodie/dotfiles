local M = {
  "utilyre/sentiment.nvim",
  version = "*",
}

M.event = { "BufReadPre", "BufNewFile" }

M.opts = {}

return M

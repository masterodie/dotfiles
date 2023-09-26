local M = {
  "neovim/nvim-lspconfig",
}

M.event = { "BufReadPre", "BufNewFile" }

M.dependencies = {
  "williamboman/mason.nvim",
  "folke/neoconf.nvim",
  "folke/neodev.nvim",
  "williamboman/mason-lspconfig.nvim",
}

return M

local M = {
  "mason-nvim-dap.nvim",
  version = "2.*",
}

M.cmd = { "DapInstall", "DapUninstall" }

M.opts = {
  handlers = {},
}

return M

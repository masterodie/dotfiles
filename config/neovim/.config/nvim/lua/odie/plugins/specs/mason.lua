local M = {
  "williamboman/mason.nvim",
  version = "1.*",
}

M.cmd = { "Mason" }

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  }, opts)
end

return M

local M = {
  "folke/trouble.nvim",
}

M.dependencies = { "nvim-tree/nvim-web-devicons" }

M.cmd = { "Trouble", "TroubleToggle" }

M.opts = {}

M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    { "<leader>xx", vim.cmd.TroubleToggle, desc = "Open diagnostics" },
  }, keys)
end

return M

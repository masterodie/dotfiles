local M = {
  "mbbill/undotree",
}

M.lazy = false

M.keys = function()
  return {
    { '<leader>u', vim.cmd.UndotreeToggle, desc="Open Undo Tree"}
  }
end

return M

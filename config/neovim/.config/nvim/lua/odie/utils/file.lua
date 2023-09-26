local M = {}

M.exists = function(path)
  local stat = vim.loop.fs_stat(vim.fn.glob(path))
  return stat ~= nil
end

return M

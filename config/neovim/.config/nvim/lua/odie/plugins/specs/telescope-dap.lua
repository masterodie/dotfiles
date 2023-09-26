local M = {
  "nvim-telescope/telescope-dap.nvim",
}

M.config = function()
  require("telescope").load_extension("dap")
end

return M

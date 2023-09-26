local M = {
    "rcarriga/nvim-notify",
}

M.dependencies = {
  "nvim-telescope/telescope.nvim",
}

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    fps = 60,
    render = "compact",
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { border = "none" })
    end,
  }, opts)
end

return M

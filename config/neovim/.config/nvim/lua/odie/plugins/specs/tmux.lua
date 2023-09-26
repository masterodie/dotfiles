local M = {
    "aserowy/tmux.nvim",
}

M.lazy = false

M.cond = not vim.g.vscode

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    resize = {
      resize_step_x = 4,
      resize_step_y = 2,
    },
  }, opts)
end

M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    {
      "<C-h>",
      function()
        require("tmux").move_left()
      end,
      desc = "Window left",
    },
    {
      "<C-j>",
      function()
        require("tmux").move_bottom()
      end,
      desc = "Window bottom",
    },
    {
      "<C-k>",
      function()
        require("tmux").move_top()
      end,
      desc = "Window top",
    },
    {
      "<C-l>",
      function()
        require("tmux").move_right()
      end,
      desc = "Window right",
    },
    {
      "<M-h>",
      function()
        require("tmux").resize_left()
      end,
      desc = "Resize window left",
    },
    {
      "<M-j>",
      function()
        require("tmux").resize_bottom()
      end,
      desc = "Resize window bottom",
    },
    {
      "<M-k>",
      function()
        require("tmux").resize_top()
      end,
      desc = "Resize window top",
    },
    {
      "<M-l>",
      function()
        require("tmux").resize_right()
      end,
      desc = "Resize window right",
    },
  }, keys)
end

return M

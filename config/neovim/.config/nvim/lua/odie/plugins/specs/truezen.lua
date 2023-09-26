local M = { "Pocco81/true-zen.nvim" }

M.opts = {}

M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    { "<leader>zn", ":TZNarrow<CR>", desc = "Zen Narrow" },
    { "<leader>zn", ":'<,'>TZNarrow<CR>", desc = "Zen narrow block" },
    { "<leader>zf", ":TZFocus<CR>", desc = "Zen Focus" },
    { "<leader>zm", ":TZMinimalist<CR>", desc = "Zen Focus" },
    { "<leader>za", ":TZAtaraxis<CR>", desc = "Zen ataraxis" },
  }, keys)
end

return M

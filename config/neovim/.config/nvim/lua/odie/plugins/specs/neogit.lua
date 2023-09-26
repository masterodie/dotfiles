local M = {
  "NeogitOrg/neogit",
}

M.lazy = false

M.dependencies = {
  "nvim-lua/plenary.nvim",         -- required
  "nvim-telescope/telescope.nvim", -- optional
  "sindrets/diffview.nvim",        -- optional
  "ibhagwan/fzf-lua",              -- optional
}

M.opts = true

return M

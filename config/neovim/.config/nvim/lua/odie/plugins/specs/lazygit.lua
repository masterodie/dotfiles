return {
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  lazy = false,

  keys = {
    { "<leader>gg", vim.cmd.LazyGit, "Open LazyGit"}
  }
}

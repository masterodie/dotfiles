local M = {
    "RRethy/vim-illuminate",
}

M.event = { "BufReadPost", "BufNewFile" }

M.cond = not vim.g.vscode

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    providers = {
      "lsp",
      "treesitter",
      "regex",
    },
    large_file_cutoff = 2000,
    large_file_overrides = {
      providers = { "lsp" },
    },
  }, opts)
end

M.config = function(_, opts)
  require('illuminate').configure(opts)
end

return M

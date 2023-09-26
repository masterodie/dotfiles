local M = {
    "lukas-reineke/indent-blankline.nvim",
}

M.event = { "BufReadPost", "BufNewFile" }

M.cond = not vim.g.vscode

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    char = "┊",
    show_trailing_blankline_indent = false,
    show_end_of_line = true,
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  }, opts)
end

return M

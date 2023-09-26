local M = {
    "echasnovski/mini.move",
}

M.event = { "BufReadPre", "BufNewFile" }

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    mappings = {
      -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
      left = "<M-H>",
      right = "<M-L>",
      down = "<M-J>",
      up = "<M-K>",

      -- Move current line in Normal mode
      line_left = "<M-H>",
      line_right = "<M-L>",
      line_down = "<M-J>",
      line_up = "<M-K>",
    },
  }, opts)
end

return M

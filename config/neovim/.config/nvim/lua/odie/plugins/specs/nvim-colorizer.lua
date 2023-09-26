local M = {
    "NvChad/nvim-colorizer.lua",
}

M.event = { "BufReadPost", "BufNewFile" }

M.cond = not vim.g.vscode

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    user_default_options = {
      RGB = true,
      RRGGBB = true,
      names = false,
      RRGGBBAA = false,
      AARRGGBB = false,
      rgb_fn = true,
      hsl_fn = true,
      css = true,
      css_fn = true,
      mode = "background",
      tailwind = true,
      sass = { enable = true, parsers = { "css" } },
      virtualtext = "■",
      always_update = false,
    },
  }, opts)
end

return M

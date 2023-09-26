local M = {
  "catppuccin/nvim",
}

M.name = "catppuccin"

M.priority = 1000

M.lazy = false -- False if default colorscheme

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
    integrations = {
      cmp = true,
      gitsigns = true,
      neotree = true,
      treesitter = true,
      notify = true,
      mason = true,
      noice = true,
      dap = {
        enabled = true,
        enable_ui = true,
      },
      lsp_trouble = true,
      illuminate = true,
      which_key = true,
      mini = true,
      alpha = true,
      telescope = {
        enabled = true,
        style = "nvchad",
      },
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      fidget = true,
      headlines = true,
    },
    custom_highlights = function(colors)
      local bg1 = colors.mantle
      local bg2 = colors.crust
      local fg0 = colors.text
      local green = colors.green
      local red = colors.red
      return {
        TelescopePreviewBorder = { fg = bg1, bg = bg1 },
        TelescopePreviewNormal = { bg = bg1 },
        TelescopePreviewTitle = { fg = fg0, bg = green },
        TelescopePromptBorder = { fg = bg2, bg = bg2 },
        TelescopePromptNormal = { fg = fg0, bg = bg2 },
        TelescopePromptPrefix = { fg = red, bg = bg2 },
        TelescopePromptTitle = { fg = fg0, bg = red },
        TelescopeResultsBorder = { fg = bg1, bg = bg1 },
        TelescopeResultsNormal = { bg = bg1 },
        TelescopeResultsTitle = { fg = bg1, bg = bg1 },
        TelescopeSelection = { bg = bg2, fg = colors.text },
        TelescopeResultsDiffAdd = { fg = fg0 },
        TelescopeResultsDiffChange = { fg = fg0 },
        TelescopeResultsDiffDelete = { fg = fg0 },
        NotifyBackground = { bg = bg2 },
      }
    end,
  }, opts)
end

M.config = function(_, opts)
  local catppucchin = require('catppuccin')
  catppucchin.setup(opts)
  vim.cmd.colorscheme("catppuccin-mocha")
end

return M

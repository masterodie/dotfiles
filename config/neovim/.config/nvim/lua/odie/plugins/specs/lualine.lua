local M = {
  "nvim-lualine/lualine.nvim",
}

M.event = "ColorScheme"

M.dependencies = {
  "nvim-tree/nvim-web-devicons",
}

M.opts = function(_, opts)
  local colors = require("catppuccin.palettes.mocha")

  return vim.tbl_deep_extend("force", {
    sections = {
      lualine_a = { "", { "mode" } },
      lualine_b = {
        { "branch" },
        { "diff" },
      },
      lualine_c = {
        "%=",
        { "filetype", icon_only = true },
        { "filename" },
      },
      lualine_x = {

        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = colors.red },
        },
      },
      lualine_y = {
        { "encoding" },
        { "fileformat" },
      },
      lualine_z = {
        { "progress" },
      },
    },
    winbar = {
      lualine_x = {
        { "diagnostics" },
        { "filename", path = 1 },
        { "filetype", icon_only = true },
      },
    },
    inactive_winbar = {
      lualine_x = {
        { "diagnostics" },
        { "filename", path = 1 },
        { "filetype", icon_only = true },
      },
    },
    extensions = { "fugitive", "lazy", "man", "neo-tree", "nvim-dap-ui", "quickfix" },
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = {
        statusline = {},
        winbar = {
          "help",
          "lazy",
          "neo-tree",
          "dapui_stacks",
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dap-repl",
          "fugitive",
        },
      },
      theme = "catppuccin",
    },
  }, opts)
end

return M

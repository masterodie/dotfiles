local M = {
  "folke/noice.nvim",
}

M.event = "VeryLazy"

M.cond = not vim.g.started_by_firenvim

M.dependencies = {
  "MunifTanjim/nui.nvim",
  "rcarriga/nvim-notify",
  "nvim-telescope/telescope.nvim",
}

M.config = function(_, opts)
  require("telescope").load_extension("noice")
  require("noice").setup(opts)
end

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    cmdline = {
      view = "cmdline",
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = true, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
  }, opts)
end

return M

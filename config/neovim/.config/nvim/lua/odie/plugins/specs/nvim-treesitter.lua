local M = {
  "nvim-treesitter/nvim-treesitter",
}

M.event = { "BufReadPre", "BufNewFile" }

M.dependencies = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  "nvim-treesitter/playground",
  "RRethy/nvim-treesitter-endwise",
  "windwp/nvim-ts-autotag",
  "nvim-neorg/neorg",
}

M.build = ":TSUpdate"

M.opts = function(_, opts)
  local orgmode = require("orgmode")

  orgmode.setup_ts_grammar()

  return vim.tbl_deep_extend("force", {
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cmake",
      "comment",
      "cpp",
      "css",
      "go",
      "gomod",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "org",
      "php",
      "php",
      "phpdoc",
      "python",
      "query",
      "regex",
      "rust",
      "scss",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yuck",
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "org" },
    },
    indent = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = {
            query = "@function.outer",
            desc = "Select outer part of a function region",
          },
          ["if"] = {
            query = "@function.inner",
            desc = "Select outer part of a function region",
          },
          ["ac"] = { query = "@class.outer", "Select outer part of a class region" },
          ["ic"] = {
            query = "@class.inner",
            desc = "Select inner part of a class region",
          },
          ["as"] = {
            query = "@scope",
            query_group = "locals",
            desc = "Select language scope",
          },
        },
      },
    },
    incremental_selection = {
      enable = true,
    },
    endwise = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
  }, opts)
end

M.main = "nvim-treesitter.configs"

return M

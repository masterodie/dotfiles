local M = {
    "nvim-telescope/telescope.nvim",
}

M.dependencies = {
  "nvim-tree/nvim-web-devicons",
  "nvim-lua/plenary.nvim",
  "nvim-orgmode/orgmode",
}

M.event = { "VeryLazy" }

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    defaults = {
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = true,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_ignore_patterns = { "node_modules", "vendor" },
      path_display = { "truncate" },
      winblend = 3,
      border = {},
      borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
      color_devicons = true,
      extensions = {
        fzf = {
          fuzzy = true,                   -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true,    -- override the file sorter
          case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        },
      },
    },
  }, opts)
end

M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    {
      "<C-p>",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers()
      end,
      desc = "Find Buffers",
    },
    {
      "<leader>fh",
      function()
        require("telescope.builtin").help_tags()
      end,
      desc = "Find Help Tags",
    },
    {
      "<leader>fo",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "Search File History",
    },
    {
      "<leader>fM",
      function()
        require("telescope.builtin").man_pages()
      end,
      desc = "Find Man Pages",
    },
  }, keys)
end

return M

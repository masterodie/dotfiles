local M = {
    "lewis6991/gitsigns.nvim",
}

M.event = { "BufReadPost", "BufNewFile" }

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    -- See `:help gitsigns.txt`
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "󰍵" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
      untracked = { text = "│" },
    },
    on_attach = function(bufnr)
      vim.keymap.set(
        "n",
        "<leader>gp",
        require("gitsigns").prev_hunk,
        { buffer = bufnr, desc = "[G]o to [P]revious Hunk" }
      )
      vim.keymap.set(
        "n",
        "<leader>gn",
        require("gitsigns").next_hunk,
        { buffer = bufnr, desc = "[G]o to [N]ext Hunk" }
      )
      vim.keymap.set(
        "n",
        "<leader>ph",
        require("gitsigns").preview_hunk,
        { buffer = bufnr, desc = "[P]review [H]unk" }
      )
    end,
  }, opts)
end

return M

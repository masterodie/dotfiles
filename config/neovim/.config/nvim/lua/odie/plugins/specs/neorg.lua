local M = {
  "nvim-neorg/neorg",
}

M.build = ":Neorg sync-parsers"

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "nvim-neorg/neorg-telescope",
}

M.lazy = false

-- M.cmd = { "Neorg" }

-- M.ft = "norg"

M.config = function()
  local neorg = require("neorg")
  local neorg_callbacks = require("neorg.core.callbacks")

  local workspace_root = vim.env.NORG_ROOT
  if workspace_root == nil then
    workspace_root = "~/Sync/norg"
  end

  neorg.setup({
    load = {
      ["core.defaults"] = {}, -- Loads default behaviour
      ["core.concealer"] = {
        config = {
          init_open_folds = "auto",
        }
      }, -- Adds pretty icons to your documents
      ["core.dirman"] = { -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = workspace_root .. "/notes",
          },
          default_workspace = "notes"
        },
      },
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        }
      },
      ["core.summary"] = {},
      ["core.manoeuvre"] = {},
      ["core.tangle"] = {},
      ["core.export"] = {
        config = {
          export_dir = "~/Sync/notes-export"
        }
      },
      ["core.export.markdown"] = {},
      ["core.esupports.metagen"] = {
        config = {
          type = "auto"
        }
      },
      -- ["core.ui.calendar"] = {},  -- Available with nvim 0.10+
      ["core.integrations.telescope"] = {},
    },
  })

  neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keys)
    keys.map_event_to_mode("norg", {
      n = {
        { "<leader>fl", "core.integrations.telescope.find_linkable" },
        { "<leader>fL", "core.integrations.telescope.insert_link" },
        { "<leader>fF", "core.integrations.telescope.insert_link" },
      }
    }, { silent = true, noremap = true })
  end, function() end)
end

M.keys = function()
  return {
    {"<leader>ni", function() vim.cmd.Neorg("index") end, desc = "Open notes"},
    {"<leader>nc", function() vim.cmd.Neorg("return") end, desc = "Close notes"},
  }
end

return M

local M = {
  "saecki/crates.nvim",
  tag = "v0.3.0",
}

M.event = { "BufRead Cargo.toml" }

M.dependencies = {
  "nvim-lua/plenary.nvim",
  "jose-elias-alvarez/null-ls.nvim",
}

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    null_ls = {
      enabled = true,
      name = "crates.nvim",
    },
  }, opts)
end

M.config = function(_, opts)
  local crates = require("crates")

  crates.setup(opts)
end

M.keys = function(_, keys)
  local ok, crates = pcall(require, "crates")
  if not ok then
      return {}
  end
  return vim.tbl_deep_extend("force", {
    { "<leader>pt", crates.toggle, desc = "Crate Toggle" },
    { "<leader>pr", crates.reload, desc = "Crate Reload" },
    { "<leader>pv", crates.show_versions_popup, desc = "Crate Show Version Popup" },
    { "<leader>pf", crates.show_features_popup, desc = "Crate show features Popup" },
    {
      "<leader>pd",
      crates.show_dependencies_popup,
      desc = "Crate Show Dependency Popup",
    },
    { "<leader>pu", crates.update_crate, desc = "Update Crate" },
    { "<leader>pu", crates.update_crates, desc = "Update Crates" },
    {
      "<leader>pa",
      crates.update_all_crates,
      desc = "Update All Crates",
    },
    { "<leader>pU", crates.upgrade_crate, desc = "Upgrade Crate" },
    { "<leader>pU", crates.upgrade_crates, desc = "Upgrade Crates" },
    {
      "<leader>pA",
      crates.upgrade_all_crates,
      desc = "Upgrade All Crates",
    },

    { "<leader>pH", crates.open_homepage, desc = "Open Crate Homepage" },
    {
      "<leader>pR",
      crates.open_repository,
      desc = "Open Crate Repository",
    },
    {
      "<leader>pD",
      crates.open_documentation,
      desc = "Open Crate Documentation",
    },
    {
      "<leader>pC",
      crates.open_crates_io,
      desc = "Open crates.io for Crate",
    },
  }, keys)
end

return M

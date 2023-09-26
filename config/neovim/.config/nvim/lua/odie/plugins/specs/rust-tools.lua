local M = {
  "simrat39/rust-tools.nvim",
}

M.ft = { "rust", "cpp" }

M.dependencies = {
  "neovim/nvim-lspconfig",
  "mfussenegger/nvim-dap",
  "nvim-telescope/telescope.nvim",
}

M.opts = function(_, opts)
  local extension_path = vim.env.HOME
    .. "/.vscode-oss/extensions/vadimcn.vscode-lldb-1.9.2-universal/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb"
  local this_os = vim.loop.os_uname().sysname

  -- The path in windows is different
  if this_os:find("Windows") then
    codelldb_path = extension_path .. "adapter\\codelldb.exe"
    liblldb_path = extension_path .. "lldb\\bin\\liblldb.dll"
  else
    -- The liblldb extension is .so for linux and .dylib for macOS
    liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")
  end

  return vim.tbl_deep_extend("force", {
    dap = {
      adapter = require("rust-tools.dap").get_codelldb_adapter(
        codelldb_path,
        liblldb_path
      ),
    },
    server = {
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      },
    },
    tools = {
      autoSetHints = true,
      executor = require("rust-tools/executors").termopen,
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        max_len_align = false,
        max_len_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
      },
      hover_actions = {
        border = "single",
        auto_focus = false,
      },
    },
  }, opts)
end

M.config = function(_, opts)
  require("rust-tools").setup(opts)
  vim.cmd.compiler("cargo")
end

M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    { "<leader>ds", vim.cmd.RustDebuggables, desc = "Start Debugging" },
    { "<leader>dl", vim.cmd.RustLastDebug, desc = "Start Debugging" },
  }, keys)
end

return M

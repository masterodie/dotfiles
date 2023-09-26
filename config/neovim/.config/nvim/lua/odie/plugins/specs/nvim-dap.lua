local M = {
  "mfussenegger/nvim-dap",
}

M.cmd = { "DapShowLog", "DapContinue", "DapToggleBreakpoint" }

M.dependencies = {
  "williamboman/mason.nvim",
  "jay-babu/mason-nvim-dap.nvim",
  "rcarriga/nvim-dap-ui",
  "theHamsta/nvim-dap-virtual-text",
  "nvim-telescope/telescope-dap.nvim",
}

M.cond = not vim.g.vscode

M.config = function(_, _)
  local dapui = require("dapui")
  local dap = require("dap")
  dapui.setup()

  require("dap.ext.vscode").load_launchjs(nil, { rt_lldb = { "rust" } })

  vim.fn.sign_define(
    "DapBreakpoint",
    { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointCondition",
    { text = "ﳁ", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapBreakpointRejected",
    { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "DapBreakpoint" }
  )
  vim.fn.sign_define(
    "DapLogPoint",
    { text = "", texthl = "DapLogPoint", linehl = "", numhl = "DapLogPoint" }
  )
  vim.fn.sign_define(
    "DapStopped",
    { text = "", texthl = "DapStopped", linehl = "", numhl = "DapStopped" }
  )

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    { "<leader>db", vim.cmd.DapToggleBreakpoint, desc = "Toggle Debug Breakpoint" },
    { "<leader>dc", vim.cmd.DapContinue, desc = "Debug Continue" },
    { "<leader>dn", vim.cmd.DapStepOver, desc = "Debug Step Over" },
    { "<leader>di", vim.cmd.DapStepIn, desc = "Debug Step In" },
    { "<leader>do", vim.cmd.DapStepOut, desc = "Debug Step Out" },
    { "<leader>dt", vim.cmd.DapTerminate, desc = "Debug Terminate" },
    { "<leader>dr", vim.cmd.DapToggleRepl, desc = "Debug Toggle REPL" },
    {
      "<leader>du",
      function()
        require("dapui").toggle({})
      end,
      desc = "Toggle Debug UI",
    },
  }, keys)
end

return M

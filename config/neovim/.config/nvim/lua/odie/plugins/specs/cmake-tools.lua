local M = {

    "Civitasv/cmake-tools.nvim",
}

M.ft = { "cpp", "c" }

M.opts = function(_, opts)
  return vim.tbl_deep_extend("force", {
    cmake_build_directory = "build",
  }, opts)
end
M.keys = function(_, keys)
  return vim.tbl_deep_extend("force", {
    { "<leader>ds", vim.cmd.CMakeDebug, desc = "Start Debugging" },
    { "<leader>cb", vim.cmd.CMakeBuild, desc = "Build Project" },
    { "<leader>cR", vim.cmd.CMakeRun,   desc = "Run Project" },
  }, keys)
end

return M

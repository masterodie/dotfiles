local M = {
  "rafi/neoconf-venom.nvim",
}

M.dependencies = {
  "nvim-lua/plenary.nvim",
}

M.config = function(_, _)
  require("venom").setup()
end

return M

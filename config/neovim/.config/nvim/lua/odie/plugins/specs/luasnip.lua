local M = {
    "L3MON4D3/LuaSnip",
version = "1.*",
}
M.build = "make install_jsregexp"

M.dependencies = { "rafamadriz/friendly-snippets" }

M.config = function(_, _)
  require("luasnip.loaders.from_vscode").lazy_load()
  require("odie.snippets")
end

return M

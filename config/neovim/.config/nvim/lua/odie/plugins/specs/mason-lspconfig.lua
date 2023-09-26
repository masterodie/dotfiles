local M = {
  "williamboman/mason-lspconfig.nvim",
  version = "1.*",
}

M.opts = function(_, opts)
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local group = vim.api.nvim_create_augroup("UserKeymaps", {})

  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

      -- Buffer local mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Defninition" })
      vim.keymap.set(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        { desc = "Goto Implementation" }
      )
      vim.keymap.set(
        "n",
        "gtd",
        vim.lsp.buf.type_definition,
        { desc = "Show Type Definition" }
      )
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Goto References" })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set(
        { "n", "v" },
        "<space>ca",
        vim.cmd.CodeActionMenu,
        { desc = "Code action" }
      )
      vim.keymap.set("n", "<space>fm", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format Code" })
    end,
  })

  return vim.tbl_deep_extend("force", {
    ensure_installed = {
      "lua_ls",
      "jsonls",
      "efm",
      "bashls",
      "clangd",
      "cmake",
      "cssls",
      "emmet_ls",
      "gopls",
      "tsserver",
      "biome",
      "pyright",
      "ruff_lsp",
      "tailwindcss",
    },
    handlers = {
      function(server_name) -- default handler (optional)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["rust_analyzer"] = function() end,
      ["efm"] = function()
        local languages = require("efmls-configs.defaults").languages()

        languages = vim.tbl_extend("force", languages, {
          -- Custom languages, or override existing ones
          typescript = {
            require("efmls-configs.formatters.biome"),
          },
          go = {
            require("efmls-configs.formatters.gofumpt"),
            require("efmls-configs.formatters.goimports"),
            require("efmls-configs.formatters.golines"),
          },
        })
        local efmls_config = {
          filetypes = vim.tbl_keys(languages),
          settings = {
            rootMarkers = { ".git/" },
            languages = languages,
          },
          init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
          },
        }
        lspconfig.efm.setup(vim.tbl_extend("force", efmls_config, {
          capabilities = capabilities,
        }))
      end,
      ["clangd"] = function()
        local config = {
          capabilities = vim.tbl_deep_extend("force", capabilities, {
            offsetEncoding = { "utf-16" },
            general = {
              positionEncodings = { "utf-16" },
            },
          }),
          offset_encoding = "utf-16",
          on_new_config = function(new_config, _)
            local status, cmake = pcall(require, "cmake-tools")
            if status then
              cmake.clangd_on_new_config(new_config)
            end
          end,
        }
        lspconfig.clangd.setup(config)
      end,
      ["gopls"] = function()
        lspconfig.gopls.setup({
          settings = {
            gopls = {
              gofumpt = true,
              completeUnimported = true,
              analyses = {
                unusedparams = true,
              },
            },
          },
        })
      end,
      ["bashls"] = function()
        lspconfig.bashls.setup({
          filetypes = {"sh", "zsh"},
          bashIde = {
            globPattern = "*@(.sh|.inc|.bash|.command|.zsh)",
          },
        })
      end,
    },
  }, opts)
end

return M

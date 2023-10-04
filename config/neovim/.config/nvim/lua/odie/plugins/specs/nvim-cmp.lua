local M = {
    "hrsh7th/nvim-cmp",
}

M.event = { "InsertEnter", "CmdlineEnter" }

M.dependencies = {
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-emoji",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",
  "saecki/crates.nvim",
  "tzachar/cmp-fuzzy-path",
  "onsails/lspkind.nvim",
  "kristijanhusak/vim-dadbod-completion",
  "nvim-neorg/neorg",
}

M.config = function(_, _)
  local cmp = require("cmp")
  local ls = require("luasnip")
  local lspkind = require("lspkind")

  local base_mapping = {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }
  local buffer_mapping = vim.tbl_deep_extend("force", base_mapping, {
    ["<C-k>"] = function()
      ls.expand()
    end,
    ["<C-l>"] = function()
      ls.jump(1)
    end,
    ["<C-j>"] = function()
      ls.jump(-1)
    end,
  })

  local config = {
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        maxwidth = 50,
        ellipsis_char = "…",
        menu = {
          nvim_lsp = "[LSP]",
          luasnip = "[Snippet]",
          buffer = "[Buffer]",
          path = "[Path]",
          nvim_lua = "[Lua]",
          emoji = "[Emoji]",
        },
      }),
    },
    completion = {
      completeopt = "menu,menuone",
    },
    window = {
      completion = {
        side_padding = 0,
        scrollbar = false,
      },
      documentation = {},
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert(buffer_mapping),
    sources = cmp.config.sources({
      { name = "luasnip" },
      { name = "nvim_lsp" },
      { name = 'neorg' },
      { name = 'orgmode' },
      { name = "crates" },
      { name = "buffer" },
      { name = "emoji" },
    }),
  }

  local cmdline_config = {
    mapping = cmp.mapping.preset.cmdline(base_mapping),
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    sources = cmp.config.sources({
    }, {
      { name = "cmdline" },
    }),
  }
  local search_config = {
    mapping = cmp.mapping.preset.cmdline(base_mapping),
    completion = {
      completeopt = "menu,menuone,noselect",
    },
    sources = {
      { name = "buffer" },
    },
  }

  cmp.setup(config)
  cmp.setup.cmdline({ "/", "?" }, search_config)
  cmp.setup.cmdline(":", cmdline_config)
end

return M

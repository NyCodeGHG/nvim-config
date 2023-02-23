local BORDER_STYLE = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = BORDER_STYLE,
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = BORDER_STYLE,
})

vim.diagnostic.config({
  float = {
    border = BORDER_STYLE,
  },
})

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      require("lspconfig.ui.windows").default_options.border = BORDER_STYLE
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(BORDER_STYLE),
        documentation = cmp.config.window.bordered(BORDER_STYLE),
      }
    end,
  },
  {
    "which-key.nvim",
    event = "VeryLazy",
    opts = {
      window = {
        border = BORDER_STYLE,
      },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      preview_config = {
        border = BORDER_STYLE,
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      border = BORDER_STYLE,
    },
  },
  {

    "williamboman/mason.nvim",
    lazy = true,
    opts = {
      ui = {
        border = BORDER_STYLE,
      },
    },
  },
}

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
    init = function()
      require("lspconfig.ui.windows").default_options.border = BORDER_STYLE
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered(BORDER_STYLE),
        documentation = cmp.config.window.bordered(BORDER_STYLE),
      }
      opts.experimental.ghost_text = {
        hl_group = "@comment",
      }
    end,
  },
  {
    "which-key.nvim",
    opts = {
      window = {
        border = BORDER_STYLE,
      },
    },
  },
  {
    "gitsigns.nvim",
    opts = {
      preview_config = {
        border = BORDER_STYLE,
      },
    },
  },
  {
    "null-ls.nvim",
    opts = {
      border = BORDER_STYLE,
    },
  },
  {
    "mason.nvim",
    opts = {
      ui = {
        border = BORDER_STYLE,
      },
    },
  },
}

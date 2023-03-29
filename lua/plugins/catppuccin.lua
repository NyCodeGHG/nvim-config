return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    colorscheme = "catppuccin",
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      term_colors = true,
      no_italic = true,
      no_bold = false,
      highlight_overrides = {
        mocha = function(C)
          return {
            LeapBackdrop = { fg = C.surface2 },
          }
        end,
      },
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        neotree = true,
        native_lsp = {
          enabled = true,
        },
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        markdown = true,
        leap = true,
        mason = true,
        mini = true,
        notify = true,
        treesitter = true,
        lsp_trouble = true,
        illuminate = true,
        which_key = true,
        dap = {
          enabled = true,
          enable_ui = true,
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
    end,
  },
  {
    "SmiteshP/nvim-navic",
    enabled = false,
  },
  {
    "freddiehaddad/feline.nvim",
    lazy = false,
    opts = function()
      local ctp_feline = require("catppuccin.groups.integrations.feline")
      return {
        components = ctp_feline.get(),
      }
    end,
  },
}

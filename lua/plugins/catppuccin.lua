return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      term_colors = true,
      no_italic = true,
      no_bold = false,
      styles = {
        comments = {},
        conditionals = {},
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
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
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "catppuccin/nvim",
        name = "catppuccin",
      },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        options = {
          icons_enabled = true,
          theme = "catppuccin",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          always_divide_middle = true,
          globalstatus = true,
        },
        extensions = {
          "neo-tree",
          "nvim-dap-ui",
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    opts = function()
      return {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      }
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "SmiteshP/nvim-navic",
    enabled = false,
  },
}

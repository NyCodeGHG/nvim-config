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
        all = function(colors)
          return {
            LeapBackdrop = { fg = colors.surface2 },
          }
        end,
      },
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
      "arkav/lualine-lsp-progress",
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
        sections = {
          lualine_x = {
            "lsp_progress",
          },
        },
      })
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    opts = function()
      return {
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      }
    end,
  },
  {
    "SmiteshP/nvim-navic",
    enabled = false,
  },
}

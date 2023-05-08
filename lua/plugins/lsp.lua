return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      ---@type lspconfig.settings
      servers = {
        rust_analyzer = {},
        -- nil_ls = {},
        rnix = {},
        taplo = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        jsonls = {},
      },
    },
  },
}

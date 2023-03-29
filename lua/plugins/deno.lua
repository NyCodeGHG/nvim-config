return {
  {
    "nvim-lspconfig",
    opts = function(_, opts)
      local lsp = require("lspconfig")
      local custom = {
        ---@type lspconfig.options
        servers = {
          tsserver = {
            root_dir = lsp.util.root_pattern("package.json", "tsconfig.json"),
            single_file_support = false,
          },
          denols = {
            root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc"),
          },
        },
      }
      return vim.tbl_deep_extend("force", opts, custom)
    end,
  },
}

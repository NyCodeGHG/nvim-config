local extension_path = vim.env.HOME .. "/.local/share/nvim/mason/packages/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so" -- MacOS: This may be .dylib

return {
  {
    "simrat39/rust-tools.nvim",
    event = "BufRead *.rs",
    lazy = true,
    opts = function()
      return {
        server = {
          standalone = false,
          on_attach = function(_, bufnr)
            local rt = require("rust-tools")
            vim.keymap.set(
              "n",
              "<Leader>rc",
              rt.open_cargo_toml.open_cargo_toml,
              { buffer = bufnr, desc = "Open Cargo.toml" }
            )
            vim.keymap.set("n", "<Leader>rr", rt.workspace_refresh.reload_workspace, {
              buffer = bufnr,
              desc = "Reload Cargo workspace",
            })

            local wk = require("which-key")

            wk.register({
              r = {
                name = "Rust",
              },
            }, { prefix = "<leader>", buffer = bufnr })
          end,
        },
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        rust_analyzer = {
          single_file_support = false,
        },
      },
    },
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    init = function()
      local cmp = require("cmp")
      require("crates").setup()
      vim.api.nvim_create_autocmd("BufRead", {
        group = vim.api.nvim_create_augroup("CmpSourceCargo", { clear = true }),
        pattern = "Cargo.toml",
        callback = function()
          cmp.setup.buffer({
            sources = cmp.config.sources({
              { name = "crates" },
              { name = "nvim_lsp" },
              { name = "luasnip" },
              { name = "buffer" },
              { name = "path" },
            }),
          })
        end,
      })
    end,
  },
}

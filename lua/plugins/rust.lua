return {
  {
    "simrat39/rust-tools.nvim",
    opts = {
      server = {
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
    },
  },
  {
    "saecki/crates.nvim",
    event = "BufRead Cargo.toml",
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

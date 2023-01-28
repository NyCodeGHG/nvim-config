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
}

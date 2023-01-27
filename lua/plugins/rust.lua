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

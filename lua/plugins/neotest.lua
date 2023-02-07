return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      "marilari88/neotest-vitest",
      "olimorris/neotest-phpunit",
    },
    event = "BufReadPost",
    opts = function()
      return {
        adapters = {
          require("neotest-vitest"),
          require("neotest-phpunit"),
        },
      }
    end,
    init = function()
      local neotest = require("neotest")
      local wk = require("which-key")
      wk.register({
        t = {
          name = "testing",
          r = { neotest.run.run, "Run Test" },
          d = {
            function()
              neotest.run.run({ strategy = "dap" })
            end,
            "Debug Test",
          },
          s = { neotest.summary.toggle, "Toggle Summary" },
          o = { neotest.output_panel.toggle, "Toggle Output" },
        },
      }, { prefix = "<leader>" })
    end,
  },
}

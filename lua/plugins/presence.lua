return {
  {
    "NyCodeGHG/presence.nvim",
    event = "VeryLazy",
    lazy = true,
    -- enabled = false,
    init = function()
      require("presence"):setup({
        buttons = false,
      })
    end,
  },
}

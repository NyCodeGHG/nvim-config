return {
  {
    "NyCodeGHG/presence.nvim",
    event = "VeryLazy",
    lazy = true,
    init = function()
      require("presence"):setup({
        buttons = false,
      })
    end,
  },
}

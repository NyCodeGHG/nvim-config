return {
  {
    "NyCodeGHG/presence.nvim",
    event = "VeryLazy",
    init = function()
      require("presence"):setup({
        buttons = false,
      })
    end,
  },
}

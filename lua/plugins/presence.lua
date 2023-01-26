return {
  {
    "NyCodeGHG/presence.nvim",
    event = "BufReadPre",
    init = function()
      require("presence"):setup({
        buttons = false,
      })
    end,
  },
}

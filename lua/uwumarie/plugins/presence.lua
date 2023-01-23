return {
  {
    'NyCodeGHG/presence.nvim',
    opts = {
      buttons = false,
    },
    config = function(opts)
      require('presence'):setup(opts.opts)
    end,
  },
}

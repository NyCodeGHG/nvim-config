local config_group = vim.api.nvim_create_augroup('SessionGroup', {})

return {
  'Shatur/neovim-session-manager',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = function()
    return {
      autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
    }
  end,
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'SessionLoadPost',
      group = config_group,
      callback = function()
        require('neotree').show()
      end,
    })
  end,
}

return {
  {
    'mhartington/formatter.nvim',
    init = function()
      require('formatter').setup({
        -- Enable or disable logging
        logging = true,
        -- Set the log level
        log_level = vim.log.levels.WARN,
        -- All formatter configurations are opt-in
        filetype = {
          lua = {
            require('formatter.filetypes.lua').stylua,
          },
          ['*'] = {
            require('formatter.filetypes.any').remove_trailing_whitespace,
          },
          sql = {
            require('formatter.filetypes.sql').pgformat,
          },
          json = {
            require('formatter.filetypes.json').jq,
          },
        },
      })
    end,
  },
}

local formatter = require('formatter')
-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
        -- Formatter configurations for filetype "lua" go here
        -- and will be executed in order
        lua = {
            -- "formatter.filetypes.lua" defines default configurations for the
            -- "lua" filetype
            require('formatter.filetypes.lua').stylua,
        },

        -- Use the special "*" filetype for defining formatter configurations on
        -- any filetype
        ['*'] = {
            -- "formatter.filetypes.any" defines default configurations for any
            -- filetype
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

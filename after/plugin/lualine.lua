local schemastore = require('schemastore')

local schema = require('lualine-schemastore').setup()

require('lualine').setup({
    sections = {
        lualine_x = {
            'encoding',
            'fileformat',
            'filetype',
            schema,
        },
    },
})


local M = {}

local Schema = require("lualine.component"):extend()

local schemastore = require('schemastore')

local options = {
    schemaText = 'Schema: %s',
    fileTypes = {
        'json',
        'json5',
        'yaml',
    },
    noSchemaText = '',
}

local get_current_schema_name = function()
    if not vim.tbl_contains(options.fileTypes, vim.bo.filetype) then
        return options.noSchemaText
    end
    local path = string.format('file://%s', vim.api.nvim_buf_get_name(0))
    vim.lsp.buf_request(0, 'json/languageStatus', path, function(err, result)
        if err then
            print(err)
            return
        end
        local schema_name = result.schemas[1]:gsub('.*/', '')
        local schema = schemastore.json.get(schema_name)
        print(vim.inspect(schema))
    end)
    local schemaTextType = type(options.schemaText)
    if schemaTextType == 'string' then
        return string.format(options.schemaText, 'tsconfig.json')
    end
end

return M

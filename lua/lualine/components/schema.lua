local Schema = require('lualine.component'):extend()
local schemastore = require('schemastore')
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

Schema.default = {
    texts = {
        schema = 'Schema: %s',
        no_schema = '',
    },
    additional_filetypes = {},
}

Schema.init = function(self, options)
    Schema.super.init(self, options)
    self.options.texts = vim.tbl_extend('force', Schema.default.texts, self.options.texts or {})
    self.options.filetypes =
        vim.tbl_extend('force', Schema.default.additional_filetypes, self.options.additional_filetypes or {})
    self.filetypes = vim.tbl_extend(
        'force',
        lspconfig.yamlls.filetypes,
        lspconfig.jsonls.filetypes,
        self.options.additional_filetypes
    )
    vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
            if not self:is_matching_filetype() then
                return
            end

            local clients = vim.lsp.get_active_clients({ bufnr = ev.buf })
            local found_server = nil
            for _, server in ipairs(clients) do
                if server.name == 'jsonls' or server.name == 'yamlls' then
                    found_server = server
                    break
                end
            end

            if not found_server then
                return
            end

            -- Notify the server so we get the initialized event
            if found_server.name == 'yamlls' then
                found_server.notify('yaml/supportSchemaSelection')
            end

            self:get_current_schema_name(0, function(schema)
                self:update_schema(schema)
            end)
        end,
    })
    vim.api.nvim_create_autocmd('BufEnter', {
        callback = function(ev)
            if not self:is_matching_filetype() then
                return
            end

            local clients = vim.lsp.get_active_clients({ bufnr = ev.buf })
            local found_server = nil
            for _, server in ipairs(clients) do
                if server.name == 'jsonls' or server.name == 'yamlls' then
                    found_server = server
                    break
                end
            end

            if not found_server then
                return
            end

            -- Notify the server so we get the initialized event
            if found_server.name == 'yamlls' then
                found_server.notify('yaml/supportSchemaSelection')
            end

            self:get_current_schema_name(0, function(schema)
                self:update_schema(schema)
            end)
        end,
    })
    vim.lsp.handlers['yaml/schema/store/initialized'] = function()
        self:get_current_schema_name(0, function(schema)
            self:update_schema(schema)
        end)
    end
end

Schema.update_schema = function(self, schema)
    if schema then
        self.schema = string.format(self.options.texts.schema, schema)
    else
        self.schema = self.options.texts.no_schema
    end
end

Schema.update_status = function(self)
    return self.schema or self.options.texts.no_schema
end

local function normalize_path(path)
    local normalized = vim.fs.normalize(path)
    if not vim.startswith(normalized, '/') then
        return string.format('/%s', normalized)
    end
    return normalized
end

Schema.get_current_schema_name = function(self, buffer, callback)
    if not vim.lsp.buf.server_ready() then
        return
    end

    local path = string.format('file://%s', normalize_path(vim.api.nvim_buf_get_name(buffer)))
    if self:is_yaml() then
        vim.lsp.buf_request(buffer, 'yaml/get/jsonSchema', nil, function(err, result)
            if err or next(result) == nil then
                return
            end

            local schema_url = result[1].uri
            local schemas = schemastore.json.schemas()
            local schema = nil

            for _, s in ipairs(schemas) do
                if schema_url == s.url then
                    schema = s
                    break
                end
            end

            callback(schema.name or schema_url:gsub('.*/', ''))
        end)
    end

    if self:is_json() then
        vim.lsp.buf_request(buffer, 'json/languageStatus', path, function(err, result)
            if err or next(result) == nil then
                return
            end

            local schema_url = result.schemas[1].url
            local schemas = schemastore.json.schemas()
            local schema = nil

            for _, s in ipairs(schemas) do
                if schema_url == s.url then
                    schema = s
                    break
                end
            end

            callback(schema.name or schema_url:gsub('.*/', ''))
        end)
    end
end

Schema.is_matching_filetype = function(self)
    return vim.tbl_contains(self.options.filetypes, vim.bo.filetype)
end

Schema.get_language_servers = function(self)
    return util.get_active_clients_list_by_ft(vim.bo.filetype)
end

Schema.is_yaml = function(self)
    for _, server in ipairs(self:get_language_servers()) do
        if server.name == 'yamlls' then
            return true
        end
    end
    return false
end

Schema.is_json = function(self)
    for _, server in ipairs(self:get_language_servers()) do
        if server.name == 'jsonls' then
            return true
        end
    end
    return false
end

return Schema

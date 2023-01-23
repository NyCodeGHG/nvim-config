-- reserve space for diagnostic icons
vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
    'tsserver',
    'sumneko_lua',
    'rust_analyzer',
})
-- don't initialize this language server
-- we will use rust-tools to setup rust_analyzer
lsp.skip_server_setup({ 'rust_analyzer' })

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
})

local lspkind = require('lspkind')

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        format = lspkind.cmp_format({
            mode = 'symbol_text',
            with_text = true,
            menu = {
                buffer = '[buf]',
                nvim_lsp = '[LSP]',
                nvim_lua = '[api]',
                path = '[path]',
                luasnip = '[snip]',
            },
        }),
    },
    experimental = {
        native_menu = false,
    },
})

local signature = {
    toggle_key = '<C-p>',
    hint_enable = false,
    bind = true,
    handler_opts = {
        border = 'rounded',
    },
}

local formatterBlacklist = {
    'lua',
    'json',
}

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set('n', 'gd', function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set('n', 'K', function()
        vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set('n', '<leader>vws', function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set('n', '<leader>vd', function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set('n', '[d', function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set('n', ']d', function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set('n', '<leader>vca', function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set('n', '<leader>vrr', function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set('n', '<leader>vrn', function()
        vim.lsp.buf.rename()
    end, opts)

    local filetype = vim.filetype.match({ buf = bufnr })
    if client.server_capabilities.documentFormattingProvider and not vim.tbl_contains(formatterBlacklist, filetype) then
        vim.keymap.set('v', '<leader>f', function()
            vim.lsp.buf.format()
        end, opts)
        vim.keymap.set('n', '<leader>f', function()
            vim.lsp.buf.format({
                async = false,
                range = nil,
            })
        end, opts)
    end

    require('lsp_signature').on_attach(signature, bufnr)
end)

local schemastore = require('schemastore')
lsp.configure('yamlls', {
    settings = {
        yaml = {
            schemas = schemastore.json.schemas(),
            validate = true,
        },
        redhat = {
            telemetry = {
                enabled = false,
            },
        },
    },
})

lsp.configure('jsonls', {
    settings = {
        json = {
            schemas = schemastore.json.schemas(),
            validate = { enable = true }
        }
    }
})

lsp.configure('tsserver', {
    settings = {
        completions = {
            completeFunctionCalls = true,
        },
    },
})

lsp.nvim_workspace()
lsp.setup()

-- initialize rust_analyzer with rust-tools
-- see :help lsp-zero.build_options()
local rust_lsp = lsp.build_options('rust_analyzer', {
    single_file_support = false,
})

require('rust-tools').setup({ server = rust_lsp })

vim.diagnostic.config({
    virtual_text = true,
})

MiniDeps.add('neovim/nvim-lspconfig') -- default lsp configs
MiniDeps.add('mason-org/mason.nvim')  -- tool manager - type checkers, linters, etc
require("mason").setup()

-- show errors only when cursor on line
vim.diagnostic.config({ virtual_lines = { current_line = true } })

-- completion
MiniDeps.add({
    source = "saghen/blink.cmp",
    depends = { "rafamadriz/friendly-snippets" },
    -- use a release tag to download pre-built binaries
    checkout = "v1.6.0", -- check releases for latest tag
})

require("blink.cmp").setup({
    keymap = { preset = 'super-tab' },
    appearance = { nerd_font_variant = 'mono' },

    completion = { documentation = { auto_show = true } },
    -- menu = { auto_show = true },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    signature = { enabled = true },

    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- which LSPs to enable (must be installed with Mason)
vim.lsp.enable({ 'lua_ls', 'pyright', 'ruff', 'rust_analyzer' })

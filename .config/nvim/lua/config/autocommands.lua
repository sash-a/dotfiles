-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        vim.lsp.buf.format({ bufnr = args.buf })
    end,
})


-- Ruff sort imports
-- https://github.com/astral-sh/ruff-lsp/issues/95
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function(args)
        local clients = vim.lsp.get_active_clients({ bufnr = args.buf })

        for _, client in ipairs(clients) do
            if client.name == "ruff" then
                vim.lsp.buf.code_action({
                    context = { only = { "source.organizeImports" } },
                    apply = true,
                    bufnr = args.buf,
                })
                vim.wait(100)

                break
            end
        end
    end,
})

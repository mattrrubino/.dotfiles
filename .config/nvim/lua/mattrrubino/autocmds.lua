local a = vim.api

-- LSP
a.nvim_create_autocmd("BufWritePre", {
    callback = function()
        if #vim.lsp.get_active_clients() > 0 then
            vim.lsp.buf.format({ async = false })
        end
    end,
})

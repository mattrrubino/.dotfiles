local k = vim.keymap

-- Telescope
k.set("n", "<Leader>f", ":Telescope find_files<CR>")

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.hoverProvider then
      k.set('n', '<C-k>', vim.lsp.buf.hover, { buffer = args.buf })
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    end
  end,
})

-- Copilot
k.set("i", '<S-Space>', 'copilot#Accept("")', { expr = true, replace_keycodes = false })
vim.g.copilot_no_tab_map = true

-- DAP
k.set("n", "<Leader>b", ":DapToggleBreakpoint<CR>")
k.set("n", "<Leader>r", function()
  require("dapui").open()
  vim.cmd("DapContinue")
end)
k.set("n", "<Leader>e", function()
  require("dapui").close()
  vim.cmd("DapTerminate")
end)
k.set("n", "<F8>", ":DapStepInto<CR>")
k.set("n", "<F9>", ":DapStepOver<CR>")
k.set("n", "<F10>", ":DapStepOut<CR>")

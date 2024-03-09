return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "mfussenegger/nvim-dap",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function()
            require("mason").setup()

            require("mason-lspconfig").setup({ ensure_installed = require("plugins.lsp.servers") })

            require("mason-nvim-dap").setup({
                ensure_installed = require("plugins.dap.servers"),
                auto_install = true,
                handlers = {},
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require("mason-lspconfig").setup_handlers({
                function(server)
                    require("lspconfig")[server].setup({ capabilities = capabilities })
                end
            })
        end,
    },
}

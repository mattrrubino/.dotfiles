return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufEnter",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/playground",
            "windwp/nvim-ts-autotag",
        },
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = { enable = true },
                autotag = { enable = true },
                auto_install = true,
                ensure_installed = require("plugins.syntax.parsers"),
            })
        end,
    }
}

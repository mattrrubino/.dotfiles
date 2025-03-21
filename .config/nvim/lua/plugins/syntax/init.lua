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
        autotag = {
          enable = true,
          filetypes = { "html", "jsx", "tsx", "markdown" }
        },
        ensure_installed = require("plugins.syntax.parsers"),
        auto_install = true,
      })
    end,
  }
}

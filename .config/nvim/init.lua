-- Map leader to space
vim.g.mapleader = " "

-- Import vim configurations
require("mattrrubino.options")
require("mattrrubino.autocmds")
require("mattrrubino.keymaps")

-- Add lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Set up plugins
require("lazy").setup("plugins", {
    install = { colorscheme = { "habamax" } },
    ui = { border = "rounded" },
})

-- Set colorscheme with transparent background
vim.cmd("colorscheme habamax")
vim.api.nvim_set_hl(0, "Normal", { guibg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "NormalFloat", { guibg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "FloatBorder", { guibg = NONE, ctermbg = NONE })
vim.api.nvim_set_hl(0, "Pmenu", { guibg = NONE, ctermbg = NONE })

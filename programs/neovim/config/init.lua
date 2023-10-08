require("rcx")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {"nvim-lua/plenary.nvim"},
    {"nvim-treesitter/nvim-treesitter"},
    {"nvim-telescope/telescope.nvim"},

    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

    {"theprimeagen/harpoon"},
    {"mbbill/undotree"},

    {"VonHeikemen/lsp-zero.nvim"},
    {"neovim/nvim-lspconfig"},
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
        },
    },
    {"lukas-reineke/indent-blankline.nvim"},
    {"lukas-reineke/virt-column.nvim"},
})



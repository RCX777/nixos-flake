return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre' -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  	  ensure_installed = {
  		"vim", "lua", "vimdoc",
        "html", "css", "javascript",
        "c", "cpp", "go", "rust",
        "haskell"
  	  },
  	},
  },

  {
    "hrsh7th/nvim-cmp",
    opts = {
      mapping = {
        ["<Tab>"]  = require("cmp").mapping.confirm({ select = true}),
        ["<CR>"]   = require("cmp").mapping.abort(),
        ["<Down>"] = require("cmp").mapping.select_next_item(),
        ["<Up>"]   = require("cmp").mapping.select_prev_item(),
      }
    }
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      filters = {
        enable = false
      }
    }
  },

  {
    "mbbill/undotree",
    enable = true,
    lazy = false
  },

  {
    "ntpeters/vim-better-whitespace",
    enable = true,
    lazy = false
  },

  {
    "christoomey/vim-tmux-navigator",
    enable = true,
    lazy = false
  },
}


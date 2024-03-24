require "nvchad.mappings"

local map = vim.keymap.set


map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- move selected lines up/down
vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-Up>",   ":m '<-2<CR>gv=gv")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


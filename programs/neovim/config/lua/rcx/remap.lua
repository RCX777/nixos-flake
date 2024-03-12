
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

vim.keymap.set("v", "<M-Down>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<M-Up>",   ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>g", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("i", '"', '""<left>', { noremap = true })
vim.keymap.set("i", '(', '()<left>', { noremap = true })
vim.keymap.set("i", '[', '[]<left>', { noremap = true })
vim.keymap.set("i", '{<CR>', '{<CR>}<Esc>ko', { noremap = true })




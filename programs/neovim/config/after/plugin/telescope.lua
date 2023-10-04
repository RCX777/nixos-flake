local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {}) 
vim.keymap.set('n', '<C-p>',     builtin.git_files,  {})
vim.keymap.set('n', '<leader>g', builtin.live_grep,  {}) 

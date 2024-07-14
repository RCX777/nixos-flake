require "nvchad.options"

-- add yours here!

local  o = vim.o
local  g = vim.g
local wo = vim.wo

-- o.cursorlineopt ='both' -- to enable cursorline!
wo.number = true
wo.relativenumber = true

o.tabstop = 4      -- A TAB character looks like 4 spaces
o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
o.softtabstop = 4  -- Number of spaces inserted instead of a TAB character
o.shiftwidth = 4   -- Number of spaces inserted when indenting

o.updatetime = 50

o.colorcolumn = "80,100,120"

o.swapfile = false
o.backup   = false
o.undodir  = os.getenv("XDG_STATE_HOME") .. "./vim/undodir"
o.undofile = true

g.better_whitespace_ctermcolor = "red"


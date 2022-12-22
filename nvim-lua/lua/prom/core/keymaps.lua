-- Map leader to SPACE
vim.g.mapleader = " "

local keymap = vim.keymap

-- General keymaps

-- Prevent x writing to paste register
keymap.set("n", "x", '"_x')

-- plugin keymaps
--
--

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>h") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Telescope
local telescope_builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', telescope_builtin.find_files, {})
keymap.set('n', '<leader>fg', telescope_builtin.git_files, {})
keymap.set('n', '<leader>fb', telescope_builtin.buffers, {})
keymap.set('n', '<leader>fs', telescope_builtin.live_grep, {})
keymap.set('n', '<leader>fr', telescope_builtin.grep_string, {})

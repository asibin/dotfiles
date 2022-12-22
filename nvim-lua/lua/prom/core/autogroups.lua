-- Once we are done finding things and we start to edit remove highlights
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
	pattern = "*",
	command = ":set nohlsearch",
})

-- Remove relative line numbers when Foucs is lost or we are in insert mode
vim.api.nvim_create_autocmd({ "FocusLost", "InsertEnter" }, {
	pattern = "*",
	command = ":set number norelativenumber",
})

-- Add relative line numbers when Foucs is gained or we are in non insert mode
vim.api.nvim_create_autocmd({ "FocusGained", "InsertLeave" }, {
	pattern = "*",
	command = ":set number relativenumber",
})

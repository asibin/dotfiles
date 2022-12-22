local status, statusline = pcall(require, "lualine")
if not status then
	return
end

statusline.setup({
	options = {
		theme = "onedark",
	},
	sections = {
		lualine_c = {
			{
				"filename",
				file_status = true,
				path = 1,
				symbols = {
					modified = "[+]", -- Text to show when the file is modified.
					readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "[No Name]", -- Text to show for unnamed buffers.
					newfile = "[New]", -- Text to show for new created file before first writting
				},
			},
		},
	},
	tabline = {
		lualine_a = { "buffers" },
		lualine_b = { "branch" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = { "tabs" },
	},
	extensions = {
		"nvim-tree",
		"fugitive",
	},
})

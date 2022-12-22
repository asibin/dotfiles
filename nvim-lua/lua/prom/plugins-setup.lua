-- Auto install packer if not present

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")

	-- Usefull lua functions
	use("nvim-lua/plenary.nvim")

	-- Colorscheme
	use("rakr/vim-one")

	-- Navigate seemlesly between vim and tmux splits
	use("christoomey/vim-tmux-navigator")

	-- Maximize and restore current window
	use("szw/vim-maximizer")

	-- Vim surround
	use("tpope/vim-surround")

	-- nvim-tree file explorer
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
	})

	-- Lots of usefull mappings - will figure out if needed
	use("tpope/vim-unimpaired")

	-- Add easy language aware commenting
	use("preservim/nerdcommenter")

	-- lualine - statusbar
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	-- Treesitter for syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})

	-- Telescope for fuzzy file/buffers/gitfiles/commands search
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- autocompetion
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")

	-- snippets
	use("L3MON4D3/LuaSnip") -- snippet engine
	use("saadparwaiz1/cmp_luasnip") -- for autocompletion
	use("rafamadriz/friendly-snippets") -- useful snippets

	-- LSP config
	use({
		"williamboman/mason.nvim", -- language servers / linters / formatters installer
		"williamboman/mason-lspconfig.nvim", -- connection between mason and nvim-lspconfig
		"neovim/nvim-lspconfig", -- LSP server integration
	})

	use("hrsh7th/cmp-nvim-lsp") -- LSP output in completion

	use({ "glepnir/lspsaga.nvim", branch = "main" }) -- better LSP UIs
	use("onsails/lspkind.nvim") -- dev icons for autocompletion

	use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
	use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

	-- auto closing
	use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
	use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

	-- Git support
	use("tpope/vim-fugitive")
	use("lewis6991/gitsigns.nvim") -- file modification signs in sign column

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require("packer").sync()
	end
end)

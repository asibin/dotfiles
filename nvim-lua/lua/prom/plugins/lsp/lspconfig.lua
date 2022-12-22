local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	print("lspconfig not loaded")
	return
end

local keymap = vim.keymap

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
--keymap.set('n', '<leader>df', vim.diagnostic.open_float, opts)
keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
--keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	keymap.set("n", "gf", ":Lspsaga lsp_finder<CR>", bufopts) -- show definition and references
	keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts) -- go to declaration
	keymap.set("n", "gd", ":Lspsaga peek_definition<CR>", bufopts) -- see definition and make edits in window
	keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts) -- go to implementation
	keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	keymap.set("n", "<leader>ca", ":Lspsaga code_action<CR>", bufopts) -- invoke code actions
	keymap.set("n", "<leader>rn", ":Lspsaga rename<CR>", bufopts) -- smart rename
	keymap.set("n", "<leader>d", ":Lspsaga show_line_diagnostics<CR>", bufopts) -- show diagnostics for line
	keymap.set("n", "<leader>d", ":Lspsaga show_cursor_diagnostics<CR>", bufopts) -- show diagnostics for line

	keymap.set("n", "K", ":Lspsaga hover_doc<CR>", bufopts) -- show documentation for cursor position
	--keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

	keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)

	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true }) -- toggle outline
end

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "ﴞ ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}

lspconfig["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- configure html server
lspconfig["html"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- configure css server
lspconfig["cssls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- configure tailwindcss server
lspconfig["tailwindcss"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
	flags = lsp_flags,
	on_attach = on_attach,
	settings = { -- custom settings for lua
		Lua = {
			-- make the language server recognize "vim" global
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				-- make language server aware of runtime files
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig["tsserver"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["ansiblels"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["angularls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["bashls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["dockerls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["eslint"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["gopls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["jsonls"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig["pyright"].setup({
	on_attach = on_attach,
	flags = lsp_flags,
})

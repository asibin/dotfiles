-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	print("failed loading mason" .. mason_status)
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	print("failed loading mason-lspconfig" .. mason_lspconfig_status)
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		"sumneko_lua",
		"ansiblels",
		"angularls",
		"bashls",
		"dockerls",
		"eslint",
		"gopls",
		"jsonls",
		"pyright", -- other alternatives jedi_language_server, sourcery, pylsp
	},
	-- auto-install configured servers (with lspconfig)
	automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"pylint", -- python linter
		"hadolint", -- dockerfile linter
		"jq", -- json linter
		"shellcheck", -- shell linter
		"yamllint", -- yaml linter
		"yamlfmt", -- yaml formatter
		"autopep8", -- python formatter
		"json_tool", -- json formatter
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"j-hui/fidget.nvim",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
	},

	config = function()
		-- Setup completion capabilities
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		-- Setup fidget for LSP progress
		require("fidget").setup({})

		-- Setup Mason and Mason-LSPconfig
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "lua_ls", "ts_ls", "phpactor" },
			automatic_installation = true,
			handlers = {
				-- Default handler for unconfigured servers
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				-- Custom handler for lua_ls
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
				-- Custom handler for ts_ls
				["ts_ls"] = function()
					require("lspconfig").ts_ls.setup({
						capabilities = capabilities,
					})
				end,
				-- Custom handler for phpactor
				["phpactor"] = function()
					require("lspconfig").phpactor.setup({
						capabilities = capabilities,
						cmd = { "phpactor", "language-server" }, -- 👈 Important!
						filetypes = { "php" },
						root_dir = require("lspconfig.util").root_pattern("composer.json", ".git", "index.php"),
						init_options = {
							["language_server.diagnostics_on_update"] = true,
							["language_server.diagnostics_on_save"] = true,
						},
						on_attach = function(client, bufnr)
							print("Phpactor LSP attached to buffer " .. bufnr)
						end,
					})
				end,
			},
		})

		-- Setup nvim-cmp
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- Using LuaSnip
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
		})

		-- Diagnostics configuration
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})

		-- Custom hover function with diagnostics (from your previous config)
		local function show_hover_with_diagnostics()
			local line = vim.api.nvim_win_get_cursor(0)[1] - 1
			local diagnostics = vim.diagnostic.get(0, { lnum = line })
			local diag_message = ""
			if #diagnostics > 0 then
				diag_message = "Diagnostics:\n"
				for i, diag in ipairs(diagnostics) do
					diag_message = diag_message .. string.format("%d. %s\n", i, diag.message)
				end
			end
			vim.lsp.buf.hover()
			if diag_message ~= "" then
				vim.api.nvim_echo({ { diag_message, "WarningMsg" } }, false, {})
			end
		end

		-- Keybindings
		vim.keymap.set(
			"n",
			"GH",
			show_hover_with_diagnostics,
			{ noremap = true, silent = true, desc = "Hover with diagnostics" }
		)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to definition" })
		vim.keymap.set(
			{ "n", "v" },
			"<leader>ca",
			vim.lsp.buf.code_action,
			{ noremap = true, silent = true, desc = "Code action" }
		)
	end,
}

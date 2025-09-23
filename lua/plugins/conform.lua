return {
	"stevearc/conform.nvim",
	opts = {
		notify_on_error = false,
		default_format_opts = {
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettierd" },
			json = { "prettier" },
			css = { "prettierd" },
			scss = { "prettierd" },
			javascriptreact = { "prettierd" },
			typescript = { "prettierd" },
			html = { "prettierd" },
			typescriptreact = { "prettierd" },
			php = { "pretty-php" },
			go = { "goimports", "gofumpt" },
			xml = { "xmlformat" },
			sql = { "sqlfmt" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},
	-- config = function()
	-- local conform = require("conform")

	-- vim.keymap.set({ "n", "v" }, "<leader>gf", function()
	-- 	conform.format({
	-- 		async = true,
	-- 		lsp_fallback = true,
	-- 	})
	-- end, { desc = "Format file or range (in visual mode)" })
	-- end,
}

-- return {
-- 	"stevearc/conform.nvim",
-- 	config = function()
-- 		local conform = require("conform")
-- 		conform.setup({
-- 			notify_on_error = false,
-- 			default_format_opts = {
-- 				lsp_format = "fallback",
-- 			},
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				javascript = { "prettierd" },
-- 				json = { "prettier" },
-- 				css = { "prettierd" },
-- 				scss = { "prettierd" },
-- 				javascriptreact = { "prettierd" },
-- 				typescript = { "prettierd" },
-- 				html = { "prettierd" },
-- 				typescriptreact = { "prettierd" },
-- 				php = { "pretty-php" },
-- 				go = { "goimports", "gofumpt" },
-- 				xml = { "xmlformat" },
-- 				sql = { "sqlfmt" },
-- 			},
-- 		})
--
-- 		vim.keymap.set({ "n", "v" }, "<leader>gf", function()
-- 			conform.format({
-- 				async = true,
-- 				lsp_fallback = true,
-- 			})
-- 		end, { desc = "Format file or range (in visual mode)" })
-- 	end,
-- }

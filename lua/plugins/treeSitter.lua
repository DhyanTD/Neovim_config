return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},

	-- for adding auto backticks
	{
		"axelvc/template-string.nvim",
		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" }, -- load only for these filetypes
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("template-string").setup({
				filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
				jsx_brackets = true,
				remove_template_string = true, -- remove backticks when not needed
				restore_quotes = {
					normal = [[']],
					jsx = [["]],
				},
			})
		end,
	},
}

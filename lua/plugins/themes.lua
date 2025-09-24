return {
	-- {
	--   "samharju/synthweave.nvim",
	--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
	--   priority = 1000,
	--   config = function()
	--        vim.cmd.colorscheme("synthweave")
	--   end
	-- }
	--   {
	--   "cpea2506/one_monokai.nvim",
	-- }
	{
		"lunarvim/synthwave84.nvim",
		config = function()
			require("synthwave84").setup({
				glow = {
					error_msg = true,
					type2 = true,
					func = true,
					keyword = true,
					operator = false,
					buffer_current_target = true,
					buffer_visible_target = true,
					buffer_inactive_target = true,
				},
				transparent = true,
			})
		end,
	},
	--  {
	--    "catppuccin/nvim",
	--    name = "catppuccin",
	--    priority = 1000,
	--    config = function()
	--      vim.cmd.colorscheme "catppuccin"
	--    end
	--  }
	--

	--  {
	--    "olimorris/onedarkpro.nvim",
	--    priority = 1000,
	--    config = function()
	--      vim.cmd("colorscheme onedark_vivid")
	--    end
	--  }
	--
}

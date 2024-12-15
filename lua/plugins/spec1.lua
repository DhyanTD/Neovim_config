return {
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "lua" },
        highlight = {
          enable = true,
        },
      }
    end,
  },
    {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
     dependencies = { 'nvim-lua/plenary.nvim' }
    },
}

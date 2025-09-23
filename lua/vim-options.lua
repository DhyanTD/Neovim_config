vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- vim.cmd.colorscheme "one_monokai"
vim.cmd([[colorscheme synthwave84]])

vim.g.mapleader = " "

vim.opt.swapfile = false
vim.opt.smartcase = true

vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	command = "if mode() != 'c' | checktime | endif",
	pattern = { "*" },
})
vim.keymap.set("n", "y", '"+y')
vim.keymap.set("n", "yy", '"+yy')
vim.keymap.set("n", "Y", '"+Y')
vim.keymap.set("x", "y", '"+y')
vim.keymap.set("x", "Y", '"+Y')

vim.keymap.set("n", "x", '"+x')
vim.keymap.set("n", "d", '"+d')
vim.keymap.set("n", "dd", '"+dd')

vim.keymap.set("x", "x", '"+x')
vim.keymap.set("x", "d", '"+d')

vim.keymap.set("n", "p", '"+p')
vim.keymap.set("n", "P", '"+P')
vim.keymap.set("x", "p", '"+p')
vim.keymap.set("x", "P", '"+P')

-- for error navigation
vim.keymap.set("n", "er", vim.diagnostic.goto_next)
vim.keymap.set("n", "re", vim.diagnostic.goto_prev)

--for ufo folding
vim.o.foldcolumn = "1"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set("n", "zR", require("ufo").openAllFolds)
vim.keymap.set("n", "zM", require("ufo").closeAllFolds)

local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

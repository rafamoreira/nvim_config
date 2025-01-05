vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.lazy")

vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.cursorline = true         -- Highlight current line
vim.opt.inccommand = 'split'      -- Show live preview of substitution
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", extends = ">", precedes = "<", nbsp = "␣" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.undofile = true

local wk = require("which-key")
wk.add({
	{ "<leader>",          group = "Leader" },
	{ "<leader><leader>",  group = "Source" },
	{ "<Esc>",             "<cmd>nohlsearch<CR>",     desc = "Clear search highlights",        mode = "n" },
	{ "<leader>q",         vim.diagnostic.setloclist, desc = "Open diagnostic [Q]uickfix list" },
	{ "<leader><leader>x", "<cmd>source %<CR>",       desc = "Source current file",            mode = "n" },
	{ "<leader><leader>l", ":.lua<CR>",               desc = "Execute current line",           mode = "n" },
	{ "<leader><leader>s", ":lua<CR>",                desc = "Execute selection",              mode = "v" },
})


-- Highlight when yanking text
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

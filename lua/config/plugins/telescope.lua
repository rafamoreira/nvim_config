return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		},
		config = function()
			require('telescope').setup {
				pickers = {
					find_files = {
						theme = "ivy"
					}
				},
				extensions = {
					fzf = {},
				},
			}
			require('telescope').load_extension('fzf')

			vim.keymap.set("n", "<space>ff", require('telescope.builtin').find_files)
			vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
			vim.keymap.set("n", "<space>en", function()
				local opts = require('telescope.themes').get_dropdown({
					cwd = vim.fn.stdpath("config")
				})

				require('telescope.builtin').find_files(opts)
			end)
			vim.keymap.set("n", "<space>ep", function()
				require('telescope.builtin').find_files {
					cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
				}
			end)
			require "config.telescope.multigrep".setup()
		end,
	},
}
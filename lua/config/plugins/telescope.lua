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

			local wk = require("which-key")
			wk.add({
				-- search group
				{ "<leader>s",  group = "search" },
				{ "<leader>sf", require('telescope.builtin').find_files, desc = "Seach Files", mode = "n" },
				{ "<leader>sh", require('telescope.builtin').help_tags,  desc = "Search Help", mode = "n" },
				{
					"<leader>sg",
					function()
						require('telescope.builtin').find_files {
							cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
						}
					end,
					desc = "Search Neovim runtime files",
					mode = "n"
				},
				-- edit group
				{ "<leader>e", group = "edit" },
				{
					"<leader>en",
					function()
						local opts = require('telescope.themes').get_dropdown({
							cwd = vim.fn.stdpath("config")
						})
						require('telescope.builtin').find_files(opts)
					end,
					desc = "Edit Neovim config",
					mode = "n"
				},

			})
			require "config.telescope.multigrep".setup()
		end,
	},
}

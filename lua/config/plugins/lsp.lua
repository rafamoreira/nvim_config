return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			'saghen/blink.cmp',
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			local capabilities = require('blink.cmp').get_lsp_capabilities()

			require("lspconfig").lua_ls.setup { capabilities = capabilities }
			require("lspconfig").basedpyright.setup { capabilities = capabilities }
			require("lspconfig").gopls.setup({ capabilities = capabilities })
			require("lspconfig").ts_ls.setup({ capabilities = capabilities })

			local wk = require("which-key")
			wk.add({
				-- lsp group
				{ "g",          group = "Goto" },
				{ "gd",         require('telescope.builtin').lsp_definitions,           desc = "Goto Definition",           mode = "n" },
				{ "gr",         require('telescope.builtin').lsp_references,            desc = "Goto References",           mode = "n" },
				{ "gI",         require('telescope.builtin').lsp_implementations,       desc = "Goto Implementations",      mode = "n" },
				{ "<leader>l",  group = "lsp" },
				{ "<leader>lh", require('telescope.builtin').lsp_document_symbols,      desc = "LSP Document Symbols",      mode = "n" },
				{ "<leader>ls", require('telescope.builtin').lsp_workspace_symbols,     desc = "LSP Workspace Symbols",     mode = "n" },
				{ "<leader>lf", require('telescope.builtin').lsp_document_diagnostics,  desc = "LSP Document Diagnostics",  mode = "n" },
				{ "<leader>lw", require('telescope.builtin').lsp_workspace_diagnostics, desc = "LSP Workspace Diagnostics", mode = "n" },
				-- file operations group
				{ "<leader>f",  group = "file" },
				{
					"<leader>ff",
					function()
						vim.lsp.buf.format() -- format the current buffer
					end,
					desc = "Format the current buffer",
					mode = "n"
				},
			})
			-- format on save
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then return end

					-- get the filetype for the current buffer
					local ft = vim.api.nvim_buf_get_option(args.buf, 'filetype')

					local format_filetypes = {
						['lua'] = true,
						['go'] = true,
					}

					if client:supports_method('textDocument/formatting') and format_filetypes[ft] then
						-- Format the current buffer on save
						vim.api.nvim_create_autocmd('BufWritePre', {
							buffer = args.buf,
							callback = function()
								vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
							end,
						})
					end
				end,
			})
		end,
	}
}

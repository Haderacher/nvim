return {
	"artemave/workspace-diagnostics.nvim",
	config = function()
		require("workspace-diagnostics").setup({})
		vim.api.nvim_set_keymap("n", "<space>x", "", {
			noremap = true,
			callback = function()
				for _, client in ipairs(vim.lsp.get_clients()) do
					require("workspace-diagnostics").populate_workspace_diagnostics(client, 0)
				end
			end,
		})
	end,
}

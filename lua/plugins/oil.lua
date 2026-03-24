return {
	"stevearc/oil.nvim",
	enabled = false,
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		float = {
			border = "rounded",
		},
		confirmation = {
			border = "rounded",
		},
	},
	-- Optional dependencies
	dependencies = { { "nvim-mini/mini.icons", opts = {} } },
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
	config = function()
		require("oil").setup({
			win_options = {
				signcolumn = "yes:2",
			},
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
		})
		-- vim.keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
}

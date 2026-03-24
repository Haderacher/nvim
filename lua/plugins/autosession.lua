return {
	"rmagatti/auto-session",
	lazy = false,
	enabled = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Downloads", "/" },
		allowed_dirs = { "~/personal/" },
		bypass_save_filetypes = { "alpha", "dashboard", "snacks_dashboard" },
		-- log_level = 'debug',
		post_restore_cmds = {
			function()
				-- Restore nvim-tree after a session is restored
				local nvim_tree_api = require("nvim-tree.api")
				nvim_tree_api.tree.open()
				nvim_tree_api.tree.change_root(vim.fn.getcwd())
				nvim_tree_api.tree.reload()
			end,
		},
	},
	keys = {
		-- Will use Telescope if installed or a vim.ui.select picker otherwise
		{ "<leader>fs", "<cmd>AutoSession search<CR>", desc = "Session search" },
		{ "<leader>fS", "<cmd>AutoSession save<CR>", desc = "Save session" },
	},
}

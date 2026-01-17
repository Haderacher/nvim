return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		lazy = false,
		config = function()
			local configs = require("nvim-treesitter")

			configs.setup({})
			configs.install({
				"lua",
				"python",
				"javascript",
				"html",
				"css",
				"json",
				"bash",
				"yaml",
				"markdown",
				"java",
				"c",
				"cpp",
				"rust",
				"asm",
			})
		end,
	},
}

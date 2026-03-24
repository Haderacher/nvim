return {
	"oribarilan/lensline.nvim",
	enabled = false,
	branch = "release/2.x", -- or: branch = 'release/2.x' for latest non-breaking updates
	event = "LspAttach",
	config = function()
		require("lensline").setup()
	end,
}

return {
	"rachartier/tiny-code-action.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
	},
	event = "LspAttach",
	opts = {},
	config = function()
		require("tiny-code-action").setup({
			vim.keymap.set({ "n", "x" }, "<leader>ca", function()
				require("tiny-code-action").code_action()
			end, { noremap = true, silent = true }),
		})
	end,
}

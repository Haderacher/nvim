return {
	"rcarriga/nvim-notify",

	config = function()
		require("notify").setup({
			background_colour = "#000000",
			merge_duplicates = true,
			render = "wrapped-compact",
			stages = "fade",
			top_down = false,
		})
	end,
}

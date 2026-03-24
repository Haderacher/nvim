return {
	"chrisgrieser/nvim-lsp-endhints",
	event = "LspAttach",
	opts = {
		label = {
			truncateAtChars = 50,
			padding = 1,
			marginLeft = 0,
			sameKindSeparator = ", ",
		},
	}, -- required, even if empty
}

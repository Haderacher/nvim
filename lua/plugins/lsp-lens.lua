return {
	"VidocqH/lsp-lens.nvim",
	config = function()
		local SymbolKind = vim.lsp.protocol.SymbolKind
		require("lsp-lens").setup({
			enable = true,
			include_declaration = false, -- Reference include declaration
			sections = {
				definition = function(count)
					return "Def: " .. count
				end,
				references = function(count)
					return "Ref: " .. count
				end,
				implements = function(count)
					return "Impl: " .. count
				end,
				git_authors = function(latest_author, count)
					return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
				end,
			},
			ignore_filetype = {
				"prisma",
			},
			-- Target Symbol Kinds to show lens information
			target_symbol_kinds = {
				SymbolKind.Function,
				SymbolKind.Method,
				SymbolKind.Interface,
				SymbolKind.Class,
				SymbolKind.Struct,
				SymbolKind.Enum,
			},
			-- Symbol Kinds that may have target symbol kinds as children
			wrapper_symbol_kinds = {
				SymbolKind.Class,
				SymbolKind.Struct,
				SymbolKind.Enum,
				SymbolKind.Interface,
				SymbolKind.Object,
			},
		})
	end,
}

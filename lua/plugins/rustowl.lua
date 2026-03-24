return {
	"cordx56/rustowl",
	enabled = false,
	version = "*",
	build = "cargo install rustowl",
	lazy = false,
	opts = {
		auto_enable = false,
		idle_time = 300,
		highlight_style = "underline",
		colors = {
			lifetime = "#50fa7b", -- Dracula green
			imm_borrow = "#8be9fd", -- Dracula cyan
			mut_borrow = "#ff79c6", -- Dracula pink
			move = "#f1fa8c", -- Dracula yellow
			call = "#ffb86c", -- Dracula orange
			outlive = "#ff5555", -- Dracula red
		},
		client = {
			on_attach = function(_, buffer)
				vim.keymap.set("n", "<leader>ro", function()
					require("rustowl").toggle(buffer)
				end, { buffer = buffer, desc = "Toggle RustOwl" })

				vim.keymap.set("n", "<leader>re", function()
					require("rustowl").enable(buffer)
				end, { buffer = buffer, desc = "Enable RustOwl" })

				vim.keymap.set("n", "<leader>rd", function()
					require("rustowl").disable(buffer)
				end, { buffer = buffer, desc = "Disable RustOwl" })
			end,
		},
	},
}

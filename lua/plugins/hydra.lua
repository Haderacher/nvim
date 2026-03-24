return {
	"anuvyklack/hydra.nvim",
	config = function()
		local Hydra = require("hydra")
		Hydra({
			name = "Side scroll",
			mode = "n",
			body = "z",
			heads = {
				{ "h", "5zh" },
				{ "l", "5zl", { desc = "←/→" } },
				{ "H", "zH" },
				{ "L", "zL", { desc = "half screen ←/→" } },
			},
		})
		Hydra({
			name = "Jump Mode",
			hint = [[
    ^ ^      Move 3 Lines
    ^ ^    ---------------
    ^ ^    _j_: Down 3  _k_: Up 3
    ^ ^    _q_: Exit
   ]],
			mode = "n",
			body = "<leader>m", -- 触发按键：Leader + m
			heads = {
				{ "j", "3j" },
				{ "k", "3k" },
				{ "q", nil, { exit = true } },
				{ "<Esc>", nil, { exit = true } },
			},
		})
	end,
}

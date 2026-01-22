return {
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb", -- 支持 GitHub :GBrowse
		},
		config = function()
			-- 在你的 init.lua 或 plugins/git.lua 中
			-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "打开 Git 状态窗口" })
			-- vim.keymap.set("n", "<leader>gP", ":Git push<CR>", { desc = "Git Push" })
			--vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", { desc = "Git Pull" })
			--vim.keymap.set("n", "<leader>gd", ":Gdiffsplit<CR>", { desc = "Git Diff 分屏" })
			--vim.keymap.set("n", "<leader>gB", ":Git blame<CR>", { desc = "Git Blame 全量侧边栏" })

			-- 快速解决冲突：使用 do (obtain) 或 dp (put)
			--vim.keymap.set("n", "<leader>gh", ":diffget //2<CR>", { desc = "冲突解决：取左侧(Target)" })
			--vim.keymap.set("n", "<leader>gl", ":diffget //3<CR>", { desc = "冲突解决：取右侧(Merge)" })
		end,
	},
}

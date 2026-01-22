return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				width = 30,
				side = "left", -- 树在左边
			},
			renderer = {
				group_empty = true, -- 空文件夹合并显示
				highlight_opened_files = "all", -- 高亮已打开的文件
			},
			filters = {
				dotfiles = false, -- 是否隐藏点文件（如 .gitignore）
			},
			-- 交互行为
			actions = {
				open_file = {
					quit_on_open = false, -- 打开文件后不关闭树
				},
			},
		})
	end,
}

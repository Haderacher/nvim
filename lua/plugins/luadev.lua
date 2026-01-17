return {
	"folke/lazydev.nvim",
	ft = "lua", -- 仅在 lua 文件中加载
	opts = {
		library = {
			-- 也可以添加插件的类型定义，例如:
			-- { path = "luvit-meta/library", words = { "vim%.uv" } },
		},
	},
}

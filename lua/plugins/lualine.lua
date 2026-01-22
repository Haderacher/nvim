return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("lualine").setup({
			options = {
				-- 这里设置 Powerline 特有的三角形分割符
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = { "NvimTree", "packer" }, -- 在文件树窗口禁用状态栏
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "%{FugitiveStatusline()}", "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } }, -- path = 1 显示相对路径
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}

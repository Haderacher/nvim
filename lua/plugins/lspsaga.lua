return {
	"nvimdev/lspsaga.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter", -- 增强语法高亮
		"nvim-tree/nvim-web-devicons", -- 图标
	},
	config = function()
		require("lspsaga").setup({
			diagnostics = {
				-- 核心配置：在诊断浮窗中显示代码操作
				show_code_action = true,
				-- 快捷键：在浮窗打开时，直接按数字键跳转到对应的修复动作
				jump_num_shortcut = true,
			},
			-- 预览窗口的配置
			definition = {
				edit = "<CR>", -- 在主窗口打开
				vsplit = "<C-c>v", -- 垂直分屏打开
				split = "<C-c>i", -- 水平分屏打开
				quit = "q", -- 退出预览
			},
			ui = {
				border = "rounded", -- 圆角边框
			},
			lightbulb = {
				enable = false, -- 彻底关掉灯泡
				sign = true, -- 如果设为 true，它会显示在左侧符号栏而不是光标旁
				virtual_text = false, -- 禁用光标旁的虚拟文本灯泡
			},
		})
	end,
}

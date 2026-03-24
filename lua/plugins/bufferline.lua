return {
	"akinsho/bufferline.nvim",
	enabled = false,
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = { -- 注意：必须嵌套在 options 里面
				-- 修改数字显示逻辑
				numbers = function(opts)
					-- opts.id 是 Buffer ID (身份证)
					-- opts.ordinal 是视觉序号 (排队号)
					return string.format("%s", opts.lower(opts.ordinal))
				end,
				style_preset = require("bufferline").style_preset.minimal,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						highlight = "Directory",
						separator = true, -- use a "true" to enable the default, or set your own character
					},
				},
			},
			highlights = {
				fill = {
					bg = "none", -- 强制背景透明
				},
				background = {
					bg = "none",
				},
			},
		})

		-- 循环生成快捷键 (这一部分你的逻辑是正确的)
		for i = 1, 9 do
			vim.keymap.set("n", ("<A-%d>"):format(i), function()
				require("bufferline").go_to(i, true)
			end, { desc = ("跳转到第 %d 个标签"):format(i) })
		end

		local function move_to_ordinal(target_ordinal)
			local state = require("bufferline.state")
			local components = state.components

			-- 获取当前 Buffer 的索引位置
			local current_index = -1
			local current_buf = vim.api.nvim_get_current_buf()

			for i, component in ipairs(components) do
				if component.id == current_buf then
					current_index = i
					break
				end
			end

			if current_index == -1 then
				return
			end

			-- 计算需要移动的步数
			local steps = target_ordinal - current_index
			if steps == 0 then
				return
			end

			-- 根据步数正负执行移动命令
			if steps > 0 then
				for _ = 1, steps do
					vim.cmd("BufferLineMoveNext")
				end
			else
				for _ = 1, math.abs(steps) do
					vim.cmd("BufferLineMovePrev")
				end
			end
		end

		-- 映射 Alt + Shift + 1-9
		for i = 1, 9 do
			vim.keymap.set("n", ("<A-S-%d>"):format(i), function()
				move_to_ordinal(i)
			end, { desc = ("将 Buffer 移动到第 %d 位"):format(i) })
		end
	end,
}

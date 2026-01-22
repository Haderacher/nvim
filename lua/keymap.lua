local keymap = vim.keymap -- 为了简洁起见定义一个本地变量

-- 参数说明：
-- keymap.set(模式, 快捷键, 映射动作, 参数表)

---------- 基础操作 ----------
-- 视觉模式下缩进后保持选中状态
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

---------- 窗口管理 ----------
-- 垂直分屏
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "垂直分屏" })
-- 水平分屏
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "水平分屏" })

keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP Rename" })

-- 跳转到上一个诊断
vim.keymap.set("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Go to previous diagnostic" })

-- 跳转到下一个诊断
vim.keymap.set("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Go to next diagnostic" })

-- 悬浮窗显示当前行的详细错误
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "显示错误详情" })

-- 将所有错误放入列表 (Quickfix List)
keymap.set("n", "<leader>q", vim.diagnostic.setqflist, { desc = "打开错误列表" })

-- Lspsaga 预览定义
keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })

-- 快速查看行内诊断错误
keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- 在 Visual 模式下，按大写 J 整体向下移动选中块
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选中的代码块" })

-- 在 Visual 模式下，按大写 K 整体向上移动选中块
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选中的代码块" })

keymap.set("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

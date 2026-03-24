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

-- Lspsaga 预览定义
keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })

-- 快速查看行内诊断错误
keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- 在 Visual 模式下，按大写 J 整体向下移动选中块
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选中的代码块" })

-- 在 Visual 模式下，按大写 K 整体向上移动选中块
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选中的代码块" })

-- 视觉模式下按 <leader>y 复制到系统剪贴板
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "复制到系统剪贴板" })

-- 普通模式下按 <leader>p 粘贴系统剪贴板内容
vim.keymap.set("n", "<leader>p", '"+p', { desc = "粘贴系统剪贴板" })

vim.keymap.set("n", "<Leader>l", "<Cmd>noh<CR>")

vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>")

keymap.set("n", "<leader>n", "<cmd>Noice telescope<cr>")

vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "上一个 Buffer" })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "下一个 Buffer" })

keymap.set("n", "<leader>w", "<cmd>update<cr>", { silent = true, desc = "智能保存" })
keymap.set("n", "<leader>q", "<cmd>wqa<cr>", { desc = "智能退出" })

local function add_end_char(char)
	local line = vim.api.nvim_get_current_line()
	-- 如果行末已经有该符号，就不重复添加
	if line:sub(-1) ~= char then
		vim.api.nvim_set_current_line(line .. char)
	end
end

-- 映射示例
vim.keymap.set("i", ";;", function()
	add_end_char(";")
end, { desc = "行末加分号" })

vim.keymap.set("i", "jk", "<Esc>", { desc = "回到 Normal 模式" })

vim.keymap.set("n", "<leader>um", function()
	require("smear_cursor").toggle()
end, { desc = "Toggle smear_cursor" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], { noremap = true, expr = true, silent = true })
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], { noremap = true, expr = true, silent = true })

vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>pv", function()
	require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle nvim-tree without focus" })
vim.keymap.set("n", "<leader>pf", function()
	require("nvim-tree.api").tree.find_file()
end, { desc = "Toggle nvim-tree without focus" })

vim.keymap.set("n", "<A-1>", "<Cmd>1ToggleTerm<CR>", { desc = "Terminal 1" })
vim.keymap.set("n", "<A-2>", "<Cmd>2ToggleTerm<CR>", { desc = "Terminal 2" })
vim.keymap.set("n", "<A-3>", "<Cmd>3ToggleTerm<CR>", { desc = "Terminal 3" })

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

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "向下翻页并居中" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "向上翻页并居中" })
keymap.set("n", "n", "nzzzv", { desc = "跳转下一个搜索结果并居中" })
keymap.set("n", "N", "Nzzzv", { desc = "跳转上一个搜索结果并居中" })
keymap.set("n", "{", "{zz")
keymap.set("n", "}", "}zz")
keymap.set("n", "J", "mzJ`z")

---------- 插件集成 (以 Telescope 为例) ----------
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>pf', builtin.find_files, { desc = "查找文件" })
keymap.set('n', '<leader>pg', builtin.live_grep, { desc = "全局搜索" })


-- 跳转到上一个/下一个错误
keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "上一个错误" })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "下一个错误" })

-- 悬浮窗显示当前行的详细错误
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "显示错误详情" })

-- 将所有错误放入列表 (Quickfix List)
keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = "打开错误列表" })

keymap.set('n', 'gd', builtin.lsp_definitions, { desc = "Telescope 跳转定义" })

-- 查看实现 (Go to Implementation) - Spring Boot 开发必备
keymap.set('n', 'gi', builtin.lsp_implementations, { desc = "Telescope 查看实现" })

-- Lspsaga 预览定义
keymap.set("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })

-- Lspsaga 查找引用 (比 Telescope 更简洁的列表)
keymap.set("n", "gr", "<cmd>Lspsaga finder<CR>", { desc = "LSP Finder" })

-- 快速查看行内诊断错误
keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- 开关文件浏览器
keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "切换文件树" })
-- 聚焦到文件浏览器
keymap.set("n", "<leader>pv", "<cmd>NvimTreeFocus<CR>", { desc = "聚焦文件树" })

-- 在 Visual 模式下，按大写 J 整体向下移动选中块
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "向下移动选中的代码块" })

-- 在 Visual 模式下，按大写 K 整体向上移动选中块
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "向上移动选中的代码块" })


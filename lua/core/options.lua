local opt = vim.opt
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 行号
opt.relativenumber = true -- 相对行号（极力推荐，方便跳转）
opt.number = true         -- 显示当前行号

-- 缩进
opt.tabstop = 4           -- 1个 Tab 等于 4 个空格
opt.shiftwidth = 4        -- 自动缩进时占 4 个空格
opt.expandtab = true      -- 将 Tab 转换为空格
opt.autoindent = true     -- 自动缩进

-- 搜索
opt.ignorecase = true     -- 搜索时忽略大小写
opt.smartcase = true      -- 如果搜索包含大写字母，则不忽略大小写

-- 外观
opt.termguicolors = true  -- 开启真彩色支持（Kitty 必须开启）
opt.cursorline = true     -- 高亮当前行
opt.signcolumn = "yes"    -- 始终显示左侧符号栏（防止插件图标闪烁）

-- scrolloff
opt.scrolloff = 999


opt.splitright = true     -- 垂直分屏在右侧
opt.splitbelow = true     -- 水平分屏在下方

vim.diagnostic.config({ virtual_text = true,           -- 在行尾显示错误文字 signs = true,                  -- 在左侧行号栏显示图标 (Error/Warn) update_in_insert = false,      -- 插入模式时不更新（避免打字时乱跳）
  underline = true,              -- 给错误代码加下划线/波浪线
  severity_sort = true,          -- 按照严重程度排序
  float = {
    focused = false,
    style = "minimal",
    border = "rounded",          -- 悬浮窗边框
    source = "always",           -- 显示错误来源 (例如: rust-analyzer)
    header = "",
    prefix = "",
  },
})

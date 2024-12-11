-- 显示行号
vim.opt.number = true
vim.opt.relativenumber = true
-- 设置缩进相关选项
vim.opt.expandtab = true   -- 将 tab 转换为空格
vim.opt.shiftwidth = 4     -- 缩进时空格数（<< 和 >> 操作）
vim.opt.tabstop = 4        -- Tab 宽度
vim.opt.softtabstop = 4    -- 回退缩进时的宽度
vim.opt.autoindent = true  -- 继承前一行的缩进
vim.opt.smartindent = true -- 根据代码结构自动缩进
vim.opt.smarttab = true    -- 插入 Tab 时智能处理缩进

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.g.autoformat = true

vim.g.lazyvim_picker = "auto"

-- if the completion engine supports the AI source,
-- use that instead of inline suggestions
vim.g.ai_cmp = true

vim.g.root_lsp_ignore = { "copilot" }

-- opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

vim.opt.scrolloff = 4    -- Lines of context
vim.opt.wrap = false
vim.opt.linebreak = true -- Wrap lines at convenient points
vim.opt.list = true
vim.opt.laststatus = 3

vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

vim.opt.foldlevel = 99

vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 200
if vim.fn.has("nvim-0.10") == 1 then
    vim.opt.wrap = false
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldtext = ""
else
    vim.opt.foldmethod = "indent"
    vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

vim.g.markdown_recommended_style = 0

require("config.lazy")
-- 设置缩进相关选项
vim.opt.expandtab = true       -- 将 tab 转换为空格
vim.opt.shiftwidth = 4         -- 缩进时空格数（<< 和 >> 操作）
vim.opt.tabstop = 4            -- Tab 宽度
vim.opt.softtabstop = 4        -- 回退缩进时的宽度
vim.opt.autoindent = true      -- 继承前一行的缩进
vim.opt.smartindent = true     -- 根据代码结构自动缩进
vim.opt.smarttab = true        -- 插入 Tab 时智能处理缩进

-- 可选：为特定文件类型设置不同的缩进
vim.api.nvim_create_autocmd("FileType", {
  pattern = {"html", "css"},
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
  end,
})

-- 显示行号
-- 混合模式：当前行绝对行号，其他行相对行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 自动切换相对行号，仅在普通模式下启用
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.opt.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  callback = function()
    vim.opt.relativenumber = true
  end,
})

vim.cmd('colorscheme catppuccin')



-- nvim-lspconfig 配置
local lspconfig = require('lspconfig')

-- 启动 clangd 语言服务器
lspconfig.clangd.setup({
  cmd = { "clangd" },  -- clangd 命令
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  on_attach = function(client, bufnr)
    -- LSP 键位映射
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    print("Clangd LSP 已启动")
  end,
})



require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "cpp", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
--  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

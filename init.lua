require("config.lazy")
require("config.remaps")
require("config.autocmds")
require("config.options")

vim.diagnostic.config({
    update_in_insert = true, -- 在 Insert 模式更新诊断
    virtual_text = true,  -- 显示虚拟文本（诊断信息）
    signs = true,         -- 显示诊断符号
    underline = true,     -- 下划线高亮诊断行
    severity_sort = true, -- 根据诊断级别排序
    float = {
        border = "rounded", -- 浮窗边框样式
    },
})

-- 关闭自动换行

vim.cmd("colorscheme catppuccin")

--It's important that you set up the plugins in the following order:

--    mason.nvim
--    mason-lspconfig.nvim
--    Setup servers via lspconfig

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        check_outdated_packages_on_open = true,
        border = "none",
    },
})

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "gopls", "tailwindcss" },
    automatic_installation = true, -- 自动安装未安装的 LSP 服务器
})

local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- 定义快捷键
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)        -- 跳转到定义
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)       -- 跳转到声明
    vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)        -- 查找引用
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)    -- 跳转到实现
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)              -- 显示悬浮文档
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)    -- 重命名符号
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts) -- 代码操作
    vim.keymap.set("n", "<leader>f", function()
        vim.lsp.buf.format({ async = true })                          -- 格式化代码
    end, bufopts)
    vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, bufopts) -- 打开诊断浮窗
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)      -- 跳转到上一个诊断
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)      -- 跳转到下一个诊断
end

-- 自动为所有 LSP 配置 on_attach
require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(), -- 自动补全功能
        })
    end,
})

-- 启动 clangd 语言服务器
lspconfig.clangd.setup({
    cmd = { "clangd", "--offset-encoding=utf-16" }, -- clangd 命令
    filetypes = { "c", "cpp", "objc", "objcpp", "h" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
})

require("lspconfig").lua_ls.setup({
    settings = {
        Lua = {
            runtime = {
                -- 使用 LuaJIT 运行时（Neovim 内部使用的是 LuaJIT）
                version = "LuaJIT",
            },
            diagnostics = {
                -- 让 Lua LSP 识别 Neovim 的 `vim` 全局变量
                globals = { "vim" },
            },
            workspace = {
                -- 让 LSP 关联 Neovim 的运行时路径
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.stdpath("config") .. "/lua",
                },
                -- 避免提示第三方插件的警告
                checkThirdParty = false,
            },
            telemetry = {
                enable = false, -- 禁用遥测数据收集
            },
        },
    },
})

require("lspconfig").ansiblels.setup({
    filetypes = { "yaml", "yml" },
})

require("lspconfig").markdown_oxide.setup({
    filetypes = { "markdown" },
})

-- treesitter
require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = {
        "cpp",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "html",
        "css",
        "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`) sync_install = false, Automatically install missing parsers when entering buffer Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
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
        --  disable = { "c", "rust" },
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
})

-- luasnip
require("luasnip.loaders.from_vscode").lazy_load()
-- cmp
-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        --    { name = 'vsnip' }, -- For vsnip users.
        { name = "luasnip" }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = "buffer" },
    }),
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
})
require("cmp_git").setup() ]]
--

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})

-- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
--require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--    capabilities = capabilities
-- }

local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        -- 格式化工具
        null_ls.builtins.formatting.stylua, -- Lua 格式化
        --     null_ls.builtins.formatting.goimports, -- 自动整理导入包和格式化 Go 代码
        --     null_ls.builtins.formatting.gofumpt,  -- 格式化 Go 代码（改进版 gofmt）
        -- 诊断工具
        null_ls.builtins.diagnostics.markdownlint, -- Markdown 语法诊断
        --     null_ls.builtins.diagnostics.golangci_lint, -- Go 代码静态分析
        -- 补全工具
        null_ls.builtins.completion.spell, -- 拼写检查
    },
    on_attach = function(client, bufnr)
        -- 设置快捷键，<leader>f 格式化代码
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "<leader>f", function()
            vim.lsp.buf.format({ async = false })
        end, bufopts)
    end,
})

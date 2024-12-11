return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        branch = "v0.6", --recommended as each new version will have breaking changes
        opts = {
            --Config goes here
        },
    },
    { "rafamadriz/friendly-snippets" },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
    },
    {
        "hrsh7th/nvim-cmp",    -- 主补全引擎
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP 补全源
            "hrsh7th/cmp-buffer", -- 缓冲区补全源
            "hrsh7th/cmp-path", -- 文件路径补全源
            "hrsh7th/cmp-cmdline", -- 命令行补全
            "saadparwaiz1/cmp_luasnip", -- LuaSnip 集成
        },
    },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    {
        -- mason.nvim：工具管理器
        {
            "williamboman/mason.nvim",
            build = ":MasonUpdate",
            config = function()
                require("mason").setup()
            end,
        },
        -- null-ls.nvim：接入外部格式化/诊断工具
        {
            "nvimtools/none-ls.nvim", -- null-ls 的新名称
            dependencies = {
                "williamboman/mason.nvim",
                "jay-babu/mason-null-ls.nvim", -- 连接 mason 和 null-ls
            },
            config = function()
                -- 配置 mason-null-ls
                require("mason-null-ls").setup({
                    ensure_installed = {
                        "goimports", -- Go 格式化工具
                        "gofumpt", -- 改进版 gofmt
                        "golangci-lint", -- Go 静态分析工具
                        "prettier", -- 前端代码格式化
                        "stylua", -- Lua 代码格式化
                        "markdownlint",
                    },
                    automatic_installation = true, -- 自动安装未安装的工具
                })

                -- 配置 null-ls
                local null_ls = require("null-ls")
                null_ls.setup({
                    sources = {
                        -- 格式化工具
                        null_ls.builtins.formatting.goimports,
                        null_ls.builtins.formatting.gofumpt,
                        null_ls.builtins.formatting.stylua,
                        null_ls.builtins.formatting.prettier,
                        -- 诊断工具
                        null_ls.builtins.diagnostics.golangci_lint,
                    },
                })

                -- 自动格式化保存时执行
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = { "*.go", "*.lua", "*.js", "*.ts", "*.json", ".markdown" },
                    callback = function()
                        vim.lsp.buf.format({ async = false })
                    end,
                })
            end,
        },
    },
}

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
    ensure_installed = { "dockerls", "pylsp", "hyprls", "lua_ls", "clangd", "gopls", "tailwindcss", "volar" },
    automatic_installation = true, -- 自动安装未安装的 LSP 服务器
})

local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
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

lspconfig.dockerls.setup({
    filetypes = { "Dockerfile", "dockerfile" },
})

require("lspconfig").pylsp.setup({
    settings = {
        python = {

            analysis = {
                --                typeCheckingMode = "strict", -- 更严格的类型检查
                diagnosticMode = "workspace", -- 检查整个工作区
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
})

lspconfig.priettier.setup({
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "css",
        "scss",
        "json",
        "jsonc",
        "graphql",
        "markdown",
    },
})

lspconfig.hyprls.setup({
    filetypes = { ".conf" },
})

lspconfig.lua_ls.setup({
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
        })
    end,
    settings = {
        Lua = {},
    },
})
lspconfig.markdown_oxide.setup({
    filetypes = { "markdown" },
})

-- 配置 clangd
lspconfig.clangd.setup({
    cmd = { "clangd", "--offset-encoding=utf-16" }, -- clangd 命令
    filetypes = { "c", "cpp", "objc", "objcpp", "h" },
    root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),

    on_attach = function(client, bufnr)
        -- 启用保存时自动格式化
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                -- 执行 clangd 格式化
                vim.lsp.buf.format({ async = false })
            end,
        })

        -- 自动导入功能（仅适用于 clangd 提供的 source.organizeImports）
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
                local params = vim.lsp.util.make_range_params()
                params.context = { only = { "source.organizeImports" } }

                -- 同步请求 clangd 执行 organizeImports
                local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
                for client_id, res in pairs(result or {}) do
                    for _, r in pairs(res.result or {}) do
                        if r.edit then
                            local enc = (vim.lsp.get_client_by_id(client_id) or {}).offset_encoding or "utf-16"
                            vim.lsp.util.apply_workspace_edit(r.edit, enc)
                        end
                    end
                end
            end,
        })
    end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(), -- 补全能力支持（可选）
})

-- 自动为所有 LSP 配置 on_attach
require("mason-lspconfig").setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({
            on_attach = on_attach,
            capabilities = require("cmp_nvim_lsp").default_capabilities(), -- 自动补全功能
        })
    end,
})

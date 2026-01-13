return {
    -- 补全引擎核心
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",   -- 让 cmp 能够从 LSP 获取数据
            "hrsh7th/cmp-buffer",     -- 从当前缓冲区获取单词
            "hrsh7th/cmp-path",       -- 补全路径
            "L3MON4D3/LuaSnip",       -- 代码片段引擎
            "saadparwaiz1/cmp_luasnip", -- 桥接 LuaSnip 和 nvim-cmp
            "onsails/lspkind.nvim",   -- 为补全列表添加图标 (像 VS Code 一样)
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local lspkind = require("lspkind")
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            cmp.setup({
                -- 配置代码片段引擎
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- 补全窗口的外观设置
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                -- 快捷键设置
                mapping = cmp.mapping.preset.insert({
                    ["<C-k>"] = cmp.mapping.select_prev_item(), -- 上移
                    ["<C-j>"] = cmp.mapping.select_next_item(), -- 下移
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),     -- 手动触发补全
                    ["<C-e>"] = cmp.mapping.abort(),            -- 关闭补全窗口
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- 回车确认
                    -- Tab 键支持：循环切换补全项或跳转代码片段占位符
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'text', -- show only symbol annotations
                        maxwidth = {
                            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            -- can also be a function to dynamically calculate max width such as
                            -- menu = function() return math.floor(0.45 * vim.o.columns) end,
                            menu = 50, -- leading text (labelDetails)
                            abbr = 50, -- actual suggestion item
                        },
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        show_labelDetails = true, -- show labelDetails in menu. Disabled by default

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function (entry, vim_item)
                            -- ...
                            return vim_item
                        end
                    })
                },
                -- 补全源优先级设置
                sources = cmp.config.sources({
                    { name = "nvim_lsp" }, -- 优先级 1: LSP (最重要)
                    { name = "luasnip" },  -- 优先级 2: 代码片段
                    { name = "buffer" },   -- 优先级 3: 文本内容
                    { name = "path" },     -- 优先级 4: 文件路径
                }),
            })
        end,
    },
}

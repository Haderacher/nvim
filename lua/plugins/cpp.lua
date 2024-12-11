return {
    {
        -- LSP 配置：安装 clangd 作为 C++ 的语言服务器
        "neovim/nvim-lspconfig",
    },

    {
        -- 代码格式化快捷键配置
        "folke/which-key.nvim",
        opts = {
            defaults = {
                ["<leader>f"] = {
                    function()
                        vim.lsp.buf.format()
                    end,
                    "Format Code",
                },
            },
        },
    },
}

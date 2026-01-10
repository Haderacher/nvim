return {
    'nvimdev/lspsaga.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- 增强语法高亮
        'nvim-tree/nvim-web-devicons',     -- 图标
    },
    config = function()
        require('lspsaga').setup({
            -- 预览窗口的配置
            definition = {
                edit = "<CR>",      -- 在主窗口打开
                vsplit = "<C-c>v",  -- 垂直分屏打开
                split = "<C-c>i",   -- 水平分屏打开
                quit = "q",         -- 退出预览
            },
            ui = {
                border = 'rounded', -- 圆角边框
            }
        })
    end,
}

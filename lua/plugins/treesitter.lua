return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- 插件安装或更新后，自动运行 :TSUpdate 更新解析器
    config = function()
      local configs = require("nvim-treesitter")

      configs.setup({
        -- 确保安装这些语言的解析器
        ensure_installed = { 
            "lua", "vim", "vimdoc", "query", "javascript", 
            "html", "css", "rust", "java", "markdown", "markdown_inline",
            "python", "go", "json", "yaml" 
        },
        
        -- 启用自动同步安装 (如果你打开一个没装解析器的文件，它会尝试自动装)
        sync_install = false,
        auto_install = true,

        -- 核心功能：高亮
        highlight = {
          enable = true, -- 开启高亮
          additional_vim_regex_highlighting = false, -- 禁用旧的正则高亮，提升速度
        },

        -- 核心功能：增量缩进
        indent = { enable = true },

        -- 核心功能：增量选择（ThePrimeagen 极力推荐）
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<CR>",     -- 回车开始选中
            node_incremental = "<CR>",   -- 再次回车扩大选中范围
            node_decremental = "<bs>",   -- 退格键缩小选中范围
            scope_incremental = "<TAB>", -- 选中整个作用域
          },
        },
      })
    end,
  },
}

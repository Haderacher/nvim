return {
  {
    -- LSP 配置：安装 clangd 作为 C++ 的语言服务器
    "neovim/nvim-lspconfig",
  },

  {
    -- 自动格式化插件：null-ls，集成 clang-format
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function(_, opts)
      local null_ls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.clang_format.with({
          filetypes = { "c", "cpp", "objc", "objcpp" },
          extra_args = { "--style=llvm" }, -- 使用 LLVM 风格格式化
        }),
      })
    end,
  },

  {
    -- 代码格式化快捷键配置
    "folke/which-key.nvim",
    opts = {
      defaults = {
        ["<leader>f"] = { function() vim.lsp.buf.format() end, "Format Code" },
      },
    },
  },
}


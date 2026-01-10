return {
  -- 1. 实时预览插件 (在浏览器中查看)
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- 2. 编辑器内美化 (渲染标题、代码块、复选框等)
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { "markdown" },
    opts = {
      heading = {
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' }, -- 漂亮的标题图标
      },
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      checkbox = {
        enabled = true,
      },
    },
  },
}

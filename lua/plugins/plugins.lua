return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'm4xshen/autoclose.nvim'
    },
    {
        'altermo/ultimate-autopair.nvim',
        event={'InsertEnter','CmdlineEnter'},
        branch='v0.6', --recommended as each new version will have breaking changes
        opts={
            --Config goes here
        },

    },
    { "rafamadriz/friendly-snippets" },
    {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
}, 
{
  "hrsh7th/nvim-cmp",         -- 主补全引擎
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",   -- LSP 补全源
    "hrsh7th/cmp-buffer",     -- 缓冲区补全源
    "hrsh7th/cmp-path",       -- 文件路径补全源
    "hrsh7th/cmp-cmdline",    -- 命令行补全
    "saadparwaiz1/cmp_luasnip", -- LuaSnip 集成
  },
},
{
    "williamboman/mason.nvim"
}

}

require("config.lazy")
require("config.lsp")
require("config.remaps")
require("config.autocmds")
require("config.options")
require("config.lualine")
require("nvim-web-devicons")
require("nvim-tree")
require("ibl").setup()
require("gitsigns").setup()
require("Comment").setup()
require("java").setup()
require("lspconfig").jdtls.setup({})
require("colorizer").setup()
require("nvim-ts-autotag").setup({
    opts = {
        -- Defaults
        enable_close = true,     -- Auto close tags
        enable_rename = true,    -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Auto close on trailing </
    },
    -- Also override individual filetype configs, these take priority.
    -- Empty by default, useful if one of the "opts" global settings
    -- doesn't work well in a specific filetype
    per_filetype = {
        ["html"] = {
            enable_close = false,
        },
    },
})
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.smoothscroll = true

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

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

vim.diagnostic.open_float({
    border = "rounded",
    max_width = 80, -- 设置浮动窗口最大宽度
})
-- 关闭自动换行

vim.cmd("colorscheme catppuccin")

-- treesitter
require("nvim-treesitter.configs").setup({
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = {
        "json",
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
        "typescript",
        "vue",
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
        null_ls.builtins.formatting.prettier, -- 通用代码格式化
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

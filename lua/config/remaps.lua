local builtin = require("telescope.builtin")

--vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pv", ":NvimTreeOpen<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>px", ":NvimTreeClose<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>pg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
-- 复制选中文本到系统剪贴板
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })

-- 复制整行文本到系统剪贴板
vim.keymap.set("n", "<leader>Y", '"+yy', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nh", ":nohls<CR>", { noremap = true, silent = true })

-- 设置 <leader>cf 切换到 Neovim 配置目录
-- 设置 <leader>cf 切换到 Neovim 配置目录
vim.keymap.set("n", "<leader>cf", function()
    local config_path = vim.fn.stdpath("config")               -- 获取 Neovim 配置目录的路径
    vim.cmd("cd " .. config_path)                              -- 切换到该目录
    print("Switched to Neovim config directory: " .. config_path) -- 提示信息
end, { noremap = true, silent = true, desc = "Switch to Neovim config directory" })

-- luasnip
local ls = require("luasnip")

vim.keymap.set({ "i" }, "<C-K>", function()
    ls.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
    ls.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
    ls.jump(-1)
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

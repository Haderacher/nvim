-- go auto format and lint
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }

        -- 请求 LSP 进行代码动作（如导入优化）
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        for client_id, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(client_id) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end

        -- 格式化文件
        vim.lsp.buf.format({ async = false })
    end,
})
-- 为特定文件类型设置不同的缩进
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css" },
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end,
})

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*",
    command = "nohls",
})

-- 自动切换相对行号，仅在普通模式下启用
-- vim.api.nvim_create_autocmd("InsertEnter", {
--    callback = function()
--        vim.opt.relativenumber = false
--    end,
--})

--vim.api.nvim_create_autocmd("InsertLeave", {
--    callback = function()
--        vim.opt.relativenumber = true
--    end,
--})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_create_autocmd("User", {

	pattern = "OilActionsPost",

	callback = function(event)
		if event.data.actions[1].type == "move" then
			Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
		end
	end,
})

-- 在你的 LSP 配置的 on_attach 函数中添加
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client.supports_method("textDocument/inlayHint") then
			-- 默认开启（也可以绑定快捷键切换）
			vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
		end
	end,
})

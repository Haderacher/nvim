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

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuOpen",
	callback = function()
		vim.b.copilot_suggestion_hidden = true
	end,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "BlinkCmpMenuClose",
	callback = function()
		vim.b.copilot_suggestion_hidden = false
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "rust", "c", "cpp", "lua", "python" },
	callback = function()
		vim.treesitter.start()
	end,
})

local kitty_padding_group = vim.api.nvim_create_augroup("KittyPadding", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
	group = kitty_padding_group,
	pattern = "*",
	callback = function()
		os.execute("kitty @ set-spacing padding-left=0 padding-top=0 padding-right=0")
	end,
})

vim.api.nvim_create_autocmd("VimLeave", {
	group = kitty_padding_group,
	pattern = "*",
	callback = function()
		os.execute("kitty @ set-spacing default")
	end,
})

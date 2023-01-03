vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		local filetypes = require("")
		print(vim.bo.filetype)
	end,
})


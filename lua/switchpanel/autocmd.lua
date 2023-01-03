local ops = require("switchpanel").ops

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		for _, filetype in pairs(ops.builtin.filtype) do
			if vim.bo.filetype == filetype then
				for _, keymap in pairs(ops.mappings) do
					vim.keymap.set("n", keymap[1], keymap[2], { silent = true })
				end
			end
		end
	end,
})

local ops = require("switchpanel").ops

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		for _, builtin in pairs(ops.builtin) do
			local filetype = builtin.filetype
			if vim.bo.filetype == filetype then
				for _, keymap in pairs(ops.mappings) do
					local cmd = keymap[2]
					if type(keymap[2]) == "string" then
						cmd = "<cmd>" .. keymap[2] .. "<cr>"
					end
					vim.keymap.set("n", keymap[1], cmd, { silent = true })
				end
			end
		end
	end,
})

local M = {}

function M.keymap(buf)
	local ops = { silent = true, buffer = buf }

	vim.g.mapleader = " "

	-- Default
	vim.keymap.set("n", "<leader>e", "k", ops)
	vim.keymap.set("n", "1", "k", ops)
end

return M

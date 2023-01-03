local M = {}

local s = require("switchpanel")
local ops = require("switchpanel").ops

function M.render(bufnr)
	local line = {}
	for _, b in pairs(ops.builtin) do
		table.insert(line, b.icon)
	end
end

function M.open()
	vim.cmd("vsp")
	local winopts = {
		relativenumber = false,
		number = false,
		list = false,
		winfixwidth = true,
		winfixheight = true,
		foldenable = false,
		spell = false,
		signcolumn = "yes",
		foldmethod = "manual",
		foldcolumn = "0",
		cursorcolumn = false,
		colorcolumn = "0",
	}
	for k, v in pairs(M.View.winopts) do
		vim.api.nvim_win_set_option(0, k, v)
	end
	local bufopts = {
		{ name = "swapfile", val = false },
		{ name = "buftype", val = "nofile" },
		{ name = "modifiable", val = false },
		{ name = "filetype", val = "SidebarNvim" },
		{ name = "bufhidden", val = "hide" },
	}
	for _, opt in ipairs(bufopts) do
		vim.bo[M.View.bufnr][opt.name] = opt.val
	end

end

function M.close() end

return M

local M = {}

local s = require("switchpanel")

function M.render()
	local ops = require("switchpanel").ops
	local lines = {}
	for _, b in pairs(ops.builtin) do
		table.insert(lines, " ")
		table.insert(lines, " " .. b.icon)
	end
	for _ = 1, 100 do
		table.insert(lines, " ")
	end
	vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, true, lines)
end

function M.autocmd()
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "<buffer=" .. M.bufnr .. ">",
		callback = function()
			vim.cmd("wincmd h")
		end,
	})
end

function M.setbuf()
	M.bufnr = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_set_name(M.bufnr, "SwitchPanelList")
	M.render()

	local bufopts = {
		{ name = "swapfile", val = false },
		{ name = "buftype", val = "nofile" },
		{ name = "modifiable", val = false },
		{ name = "filetype", val = "SwitchPanelList" },
		{ name = "bufhidden", val = "hide" },
	}
	for _, opt in ipairs(bufopts) do
		vim.bo[M.bufnr][opt.name] = opt.val
	end
end

function M.setwin()
	vim.cmd("vsp")
	local winopts = {
		relativenumber = false,
		number = false,
		list = false,
		winfixwidth = true,
		winfixheight = true,
		foldenable = false,
		spell = false,
		signcolumn = "no",
		foldmethod = "manual",
		foldcolumn = "0",
		cursorcolumn = false,
		colorcolumn = "0",
	}
	for k, v in pairs(winopts) do
		vim.api.nvim_win_set_option(0, k, v)
	end
end

function M.set_win_hi()
	local ops = require("switchpanel").ops
	local hi = vim.api.nvim_buf_add_highlight
	vim.api.nvim_win_set_option(
		0,
		"winhighlight",
		"Normal:PanelListNormal,EndOfBuffer:PanelList,VertSplit:PanelList,SignColumn:PanelList,CursorLine:PanelList"
	)
	vim.api.nvim_set_hl(0, "PanelList", {
		fg = ops.panel_list.background,
		bg = ops.panel_list.background,
	})
	vim.api.nvim_set_hl(0, "PanelListNormal", {
		fg = "none",
		bg = ops.panel_list.background,
	})
end

function M.open()
	if M.isOpen() == true then
		return
	end
	if not M.bufnr then
		M.setbuf()
	end
	M.setwin()
	vim.cmd("buffer " .. M.bufnr)
	vim.cmd("wincmd H")
	M.winnr = vim.api.nvim_get_current_win()
	vim.api.nvim_win_set_width(0, 2)

	M.set_win_hi()

	vim.cmd("wincmd p")
	M.autocmd()
end

function M.close()
	if not M.winnr then
		return 
	end
	vim.api.nvim_win_close(M.winnr, false)
end

function M.getWinByFileType(filetype)
	for _, win in pairs(vim.api.nvim_list_wins()) do
		local bufnr = vim.api.nvim_win_get_buf(win)
		local win_filetype = vim.bo[bufnr].filetype
		if filetype == win_filetype then
			return win
		end
	end
	return nil
end

function M.isOpen()
	return M.getWinByFileType("SwitchPanelList")
end
return M

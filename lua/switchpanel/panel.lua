local M = {}
local panel_list = require("switchpanel.panel_list")

M.active = nil
M.tabnr = 1
M.resume = nil

function M.switch(number)
	local ops = require("switchpanel").ops
	local builtin = ops.builtin[number]
	assert(builtin, "Count of panel is less than " .. number)

	if M.active then
		M.close(M.active)
	end
	M.open(builtin)
	M.tabnr = number
end

function M.tabnext()
	local ops = require("switchpanel").ops
	if not M.active then
		return
	end

	if M.tabnr == #ops.builtin then
		if not ops.builtin then
			return
		end
		M.tabnr = 1
	else
		M.tabnr = M.tabnr + 1
	end

	M.close(M.active)
	M.open(ops.builtin[M.tabnr])
end

function M.tabprevious()
	local ops = require("switchpanel").ops
	if not M.active then
		return
	end

	if M.tabnr == 0 then
		if not ops.tab_repeat then
			return
		end
		M.tabnr = #ops.builtin
	else
		M.tabnr = M.tabnr - 1
	end

	M.close(M.active)
	M.open(ops.builtin[M.tabnr])
end

function M.toggle()
	local ops = require("switchpanel").ops
	if not M.active then
		-- open
		M.open(ops.builtin[M.tabnr])
	else
		-- close
		M.close(M.active)
	end
end

function M.close(builtin)
	panel_list.close()
	M.active = nil
	M.resume = builtin
	vim.cmd(builtin.close)
end

function M.open(builtin)
	M.active = builtin
	M.resume = nil
	vim.cmd(builtin.open)
	panel_list.open()
	panel_list.setCursor()
end

return M

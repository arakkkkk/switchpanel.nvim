local M = {}
local ops = require("switchpanel").ops

M.active = {
	left = nil, -- builtin
	right = nil, -- builtin
}
M.tabnr = {
	left = 1,
	right = 1,
}
M.resume = {
	left = nil, -- builtin
	right = nil, -- builtin
}


function M.switch(side, number)
	assert(side == "left" or side == "left")
	local builtin = ops.panel[side][number]
	--  TODO: change to error and return
	assert(builtin, "Count of " .. side .. "panel is less than " .. number)

	if M.active then
	  M.close(M.active[side], side)
	end
	M.open(builtin, side)
	M.tabnr = number
end

function M.tabnext(side)
	if not M.active[side] then
		return
	end

	local next_tabnr = M.tabnr + 1
	if M.tabnr[side] == #ops.panel[side] then
		if not ops.tab_repeat then
			return
		end
		next_tabnr = 1
	end

	M.close(M.active[side], side)
	M.open(M.ops[side][next_tabnr], side)
end

function M.tabprevious(side)
	if not M.active[side] then
		return
	end

	local previous_tabnr = M.tabnr - 1
	if M.tabnr[side] == #ops.panel[side] then
		if not ops.tab_repeat then
			return
		end
		previous_tabnr = #ops.panel[side]
	end

	M.close(M.active[side], side)
	M.open(M.ops[side][previous_tabnr], side)
end

function M.toggle(side)
  if not M.active[side] then
  	-- open
	  M.open(M.resume[side], side)
  else
  	-- close
	  M.close(M.active[side], side)
  end
end

function M.close(builtin, side)
	M.active[side] = nil
	M.resume[side] = builtin
	vim.cmd(builtin.close)
end

function M.open(builtin, side)
	M.active[side] = builtin
	M.resume[side] = nil
	vim.cmd(builtin.open)
end

return M

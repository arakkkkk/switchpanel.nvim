local M = {}
local panel = require("switchpanel.panel")

function M.get_ops(options)
	local ops = {
		panel_list = {
			show = true,
			background = "Blue",
			color = "none",
		},

		width = 30,

		tab_repeat = true,
		
		mappings = {
			{"1", "SwitchPanelSwitch 1" },
			{"2", "SwitchPanelSwitch 2" },
			{"3", "SwitchPanelSwitch 3" },
			{"4", "SwitchPanelSwitch 4" },
			{"5", "SwitchPanelSwitch 5" },
			{"J", "SwitchPanelNext" },
			{"K", "SwitchPanelPrevious" },
		},

		builtin = {
			"nvim-tree.lua",
			"sidebar.nvim",
			"undotree",
		}
	}
	ops = require("switchpanel.utils").tableMerge(ops, options)
	return ops
end

return M

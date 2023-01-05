vim.api.nvim_create_user_command("SwitchPanelSwitch", function(arg)
	require("switchpanel.panel").switch(tonumber(arg.args))
end, { nargs = "?" })

vim.api.nvim_create_user_command("SwitchPanelNext", function(arg)
	require("switchpanel.panel").tabnext()
end, {})

vim.api.nvim_create_user_command("SwitchPanelPrevious", function(arg)
	require("switchpanel.panel").tabprevious()
end, {})

vim.api.nvim_create_user_command("SwitchPanelToggle", function(arg)
	require("switchpanel.panel").toggle()
end, {})

vim.api.nvim_create_user_command("SwitchPanelListOpen", function(arg)
	require("switchpanel.panel_list").open()
end, {})
vim.api.nvim_create_user_command("SwitchPanelListClose", function(arg)
	require("switchpanel.panel_list").close()
end, {})

vim.api.nvim_create_user_command("SwitchPanel", function(arg)
	require("switchpanel.panel_list").open()
end, {})

local switchpanel = {}


function switchpanel.setup(options)
	options = options or {}
	switchpanel.ops = require("switchpanel.ops").get_ops(options)
end

return switchpanel

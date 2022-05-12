return function(coreGui)
	local module = script.Parent
	local packages = module.Parent
	local Maid = require(packages:WaitForChild("maid"))
	local ColdFusion = require(packages:WaitForChild("coldfusion"))
	local Isotope = require(packages:WaitForChild("isotope"))
	local maid = Maid.new()

	task.spawn(function()
		local Panel = require(module.Panel)
		local panel = Panel.new({
			Selections = ColdFusion.Value({workspace:WaitForChild("Dummy")}),
			Parent = coreGui,
		})
	end)
	return function()
		maid:Destroy()
	end
end
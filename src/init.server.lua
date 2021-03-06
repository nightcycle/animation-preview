local packages = script.Parent
local Maid = require(packages:WaitForChild("maid"))
local ColdFusion = require(packages:WaitForChild("coldfusion"))
local Isotope = require(packages:WaitForChild("isotope"))

local Panel = require(script:WaitForChild("Panel"))


local Plugin = {}
Plugin.__index = Plugin
setmetatable(Plugin, Isotope)

function Plugin:Destroy()
	self.Toolbar:Destroy()
	self.Button:Destroy()
	Isotope.Destroy(self)
end

function Plugin.new()
	local self = Isotope.new()
	setmetatable(self, Plugin)

	self.Toolbar = plugin:CreateToolbar("Nightcycle")
	self.Button = self.Toolbar:CreateButton(
		"Animation Previewer",
		"Demos animations you have access to",
		"rbxassetid://1308122350"
	)
	-- Make button clickable even if 3D viewport is hidden
	self.Button.ClickableWhenViewportHidden = false


	self.Activated = self._Fuse.Value(false)
	self._Fuse.Computed(self.Activated, function(activated)
		if activated then
			game:GetService("RunService"):Run()
		else
			game:GetService("RunService"):Stop()
		end
	end)
	self._Maid:GiveTask(self.Button.Click:Connect(function()
		self.Activated:Set(not self.Activated:Get())
		-- if self.Activated:Get() then
		self.Button:SetActive(self.Activated:Get())
		-- else

		-- end
	end))
	self.Panel = self._Fuse.Computed(self.Activated, function(activated)
		self._Maid._panelGui = nil
		self._Maid._panel = nil
		if activated then
					-- Create new 'DockWidgetPluginGuiInfo' object
			local widgetInfo = DockWidgetPluginGuiInfo.new(
				Enum.InitialDockState.Float,  -- Widget will be initialized in floating panel
				true,   -- Widget will be initially enabled
				false,  -- Don't override the previous enabled state
				200,    -- Default width of the floating window
				300,    -- Default height of the floating window
				150,    -- Minimum width of the floating window (optional)
				150     -- Minimum height of the floating window (optional)
			)

	
			-- Create new widget GUI
			self._Maid._panelGui = plugin:CreateDockWidgetPluginGui("Animation Preview", widgetInfo)
			self._Maid._panelGui.Title = "Animation Preview"
			self._Maid._panel = Panel.new({
				Parent = self._Maid._panelGui,
			})
			return self._Maid._panel
		end
	end)

	return self
end

Plugin.new()

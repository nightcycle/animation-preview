local RunService = game:GetService("RunService")
local KSP = game:GetService("KeyframeSequenceProvider")
local packages = script.Parent.Parent
local Maid = require(packages:WaitForChild("maid"))
local ColdFusion = require(packages:WaitForChild("coldfusion"))
local Isotope = require(packages:WaitForChild("isotope"))
local Synthetic = require(packages:WaitForChild("synthetic"))
local studioSettings = settings().Studio

local Panel = {}
Panel.__index = Panel
setmetatable(Panel, Isotope)

function Panel:Destroy()
	-- print("Destroying", self)
	Isotope.Destroy(self)
end

function button(self, txt, func, visible)
	return self._Fuse.new "TextButton" {
		LayoutOrder = 3,
		TextSize = 14,
		AutoButtonColor = true,
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.MainButton, Enum.StudioStyleGuideModifier.Selected)
		end),
		TextColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.DialogMainButtonText, Enum.StudioStyleGuideModifier.Selected)
		end),
		Text = txt,
		Active = self._Fuse.Computed(visible, function(loop)
			return not loop
		end),
		BackgroundTransparency = self._Fuse.Computed(visible, function(loop)
			if loop then
				return 1
			else
				return 0
			end
		end):Tween(),
		TextTransparency = self._Fuse.Computed(visible, function(loop)
			if loop then
				return 1
			else
				return 0
			end
		end):Tween(),
		[self._Fuse.Event "Activated"] = func,
		[ColdFusion.Children] = {
			self._Fuse.new "UIPadding"{
				PaddingBottom = UDim.new(0,2),
				PaddingTop = UDim.new(0,2),
				PaddingLeft = UDim.new(0,5),
				PaddingRight = UDim.new(0,5),
			},
			self._Fuse.new "UICorner" {
				CornerRadius = UDim.new(0,3),
			}
		}
	}
end

function idInputBox(self, animIdState, prompt, layoutOrder)


	local animationIdInputBox
	animationIdInputBox = self._Fuse.new "TextBox" {

		LayoutOrder = layoutOrder,
		Size = UDim2.fromOffset(0, 30),
		TextSize = 14,
		AutomaticSize = Enum.AutomaticSize.X,
		PlaceholderText = "AnimationId",
		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBackground, Enum.StudioStyleGuideModifier.Default)
		end),
		PlaceholderColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.DimmedText, Enum.StudioStyleGuideModifier.Default)
		end),
		TextColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
		end),
		TextXAlignment = Enum.TextXAlignment.Left,
		[self._Fuse.Event "FocusLost"] = function()
			animIdState:Set(animationIdInputBox.Text)
		end,
		[self._Fuse.Children] = {
			self._Fuse.new "UIPadding"{
				PaddingBottom = UDim.new(0,5),
				PaddingTop = UDim.new(0,5),
				PaddingLeft = UDim.new(0,5),
				PaddingRight = UDim.new(0,5),
			},
			self._Fuse.new "UICorner"{
				CornerRadius = UDim.new(0, 5),
			},
			self._Fuse.new "UIStroke"{
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = self._Fuse.Computed(self.Theme, function(theme)
					return theme:GetColor(Enum.StudioStyleGuideColor.InputFieldBorder, Enum.StudioStyleGuideModifier.Default)
				end),
			},
			self._Fuse.new "UISizeConstraint" {
				MinSize = Vector2.new(170,0),
			}
			-- self._Fuse.new "UIAspectRatioConstraint" {
			-- 	AspectRatio = 6,
			-- 	AspectType = Enum.AspectType.ScaleWithParentSize,
			-- 	DominantAxis = Enum.DominantAxis.Height,
			-- }
		}
	}
	return self._Fuse.new "Frame" {
		Name = "IdInputBox",
		LayoutOrder = 3,
		AutomaticSize = Enum.AutomaticSize.XY,
		BackgroundTransparency = 1,
		Visible = self._Fuse.Computed(self.Rig, function(rig)
			if rig == nil then
				return false
			else
				return true
			end
		end),
		[ColdFusion.Children] = {
			self._Fuse.new "UIListLayout" {
				Padding = UDim.new(0, 10),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			Synthetic.TextLabel.new {
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				TextSize = 14,
				Text = prompt,
			},
			animationIdInputBox,
			-- Synthetic.Switch.new {
			-- 	LayoutOrder = 2,
			-- 	Scale = 1,
			-- }
		}
	}
end

function title(self, txt, leftIcon, rightIcon)
	return Synthetic.TextLabel.new{
		LayoutOrder = 0,
		TextSize = 24,
		BackgroundTransparency = 1,
		LeftIcon = leftIcon,
		RightIcon = rightIcon,
		Text = txt,
		TextColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
		end),
	}
end

function divider(self, layoutOrder)
	return self._Fuse.new "Frame" {
		Name = "Divider",
		LayoutOrder = layoutOrder,
		Size = UDim2.new(1, 0, 0, 1),
		BackgroundTransparency = 0.5,
		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.DiffLineNum, Enum.StudioStyleGuideModifier.Default)
		end),
	}
end

-- function importCard(self, layoutOrder)
-- 	return self._Fuse.new "Frame" {
-- 		BorderSizePixel = 0,
-- 		BackgroundTransparency = 0,
-- 		LayoutOrder = layoutOrder,
-- 		Visible = self._Fuse.Computed(self.Rig, function(rig)
-- 			return rig ~= nil
-- 		end),
-- 		Size = UDim2.fromScale(1,0),
-- 		AutomaticSize = Enum.AutomaticSize.Y,
-- 		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
-- 			return theme:GetColor(Enum.StudioStyleGuideColor.CategoryItem, Enum.StudioStyleGuideModifier.Default)
-- 		end),
-- 		[ColdFusion.Children] = {
-- 			self._Fuse.new "UIListLayout" {
-- 				Padding = UDim.new(0, 5),
-- 				HorizontalAlignment = Enum.HorizontalAlignment.Left,
-- 				VerticalAlignment = Enum.VerticalAlignment.Top,
-- 				SortOrder = Enum.SortOrder.LayoutOrder,
-- 			},
-- 			self._Fuse.new "UIPadding"{
-- 				PaddingBottom = UDim.new(0,10),
-- 				PaddingTop = UDim.new(0,10),
-- 				PaddingLeft = UDim.new(0,10),
-- 				PaddingRight = UDim.new(0,10),
-- 			},
-- 			title(self, "**Clone Animation**", "file_download"),
-- 			divider(self, 1),
-- 			idInputBox(self, self.ImportAnimationId, "Clone", 2),
-- 			-- button(self, "Click", function()
-- 			-- end, self._Fuse.Computed(self.ImportAnimationId, function(animId)
-- 			-- 	return not (animId ~= nil and animId ~= "")
-- 			-- end)),
-- 		},
-- 	}
-- end

function animList(self, layoutOrder)
	local buttonsFrame = self._Fuse.new "Frame" {
		Name = "AnimationList",
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		LayoutOrder = layoutOrder,
		Size = UDim2.fromScale(1,0),
		Visible = self._Fuse.Computed(self.Rig, function(rig)
			return rig ~= nil
		end),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.MainBackground, Enum.StudioStyleGuideModifier.Default)
		end),
		[ColdFusion.Children] = {
			self._Fuse.new "UIListLayout" {
				Padding = UDim.new(0, 5),
				SortOrder = Enum.SortOrder.LayoutOrder,
				FillDirection = Enum.FillDirection.Vertical,
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Center,
			},
			Synthetic.TextLabel.new {
				BackgroundTransparency = 1,
				LayoutOrder = 1,
				TextSize = 24,
				LeftIcon = "search",
				Text = "**In Game**"
			},
			
			divider(self, 2),
		}
	}
	local function connectAnimation(inst)
		local maid = Maid.new()
		self._Maid:GiveTask(maid)
		local FullName = self._Fuse.Value(inst:GetFullName())
		local FinalText = self._Fuse.Computed(FullName, function(fullName)
			return "<b>"..string.gsub(fullName, "%.", "/").."</b>"
		end)
		local button = self._Fuse.new "TextButton" {
			Parent = buttonsFrame,
			LayoutOrder = 3,
			TextSize = 14,
			AutoButtonColor = true,
			RichText = true,
			AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = self._Fuse.Computed(self.Theme, self.DemoAnimationId, function(theme, animId)
				if animId == inst.AnimationId then
					return theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Selected)
				else
					return theme:GetColor(Enum.StudioStyleGuideColor.Button, Enum.StudioStyleGuideModifier.Default)
				end
			end),
			TextColor3 = self._Fuse.Computed(self.Theme, self.DemoAnimationId, function(theme, animId)
				if animId == inst.AnimationId then
					return theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Selected)
				else
					return theme:GetColor(Enum.StudioStyleGuideColor.ButtonText, Enum.StudioStyleGuideModifier.Default)
				end
			end),
			Text = FinalText,
			[self._Fuse.Event "Activated"] = function()
				if self.DemoAnimationId:Get() == tostring(inst.AnimationId) then
					self.DemoAnimationId:Set("")
				else
					self.DemoAnimationId:Set(inst.AnimationId)
				end
			end,
			[ColdFusion.Children] = {
				self._Fuse.new "UIPadding"{
					PaddingBottom = UDim.new(0,3),
					PaddingTop = UDim.new(0,3),
					PaddingLeft = UDim.new(0,5),
					PaddingRight = UDim.new(0,5),
				},
				self._Fuse.new "UICorner" {
					CornerRadius = UDim.new(0,3),
				}
			}
		}
		maid:GiveTask(button)

		maid:GiveTask(inst.Destroying:Connect(function()
			maid:Destroy()
		end))

		maid:GiveTask(inst.AncestryChanged:Connect(function()
			FullName:Set(inst:GetFullName())
		end))
	end
	for i, inst in ipairs(game:GetDescendants()) do
		if inst:IsA("Animation") then
			connectAnimation(inst)
		end
	end
	game.DescendantAdded:Connect(function(inst)
		pcall(function()
			if inst:IsA("Animation") then
				connectAnimation(inst)
			end
		end)
	end)
	return buttonsFrame
end

function playerCard(self, layoutOrder)
	local card

	card = self._Fuse.new "Frame" {
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		LayoutOrder = layoutOrder,
		Size = UDim2.fromScale(1,0),
		Visible = self._Fuse.Computed(self.Rig, function(rig)
			return rig ~= nil
		end),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.MainBackground, Enum.StudioStyleGuideModifier.Default)
		end),
		[ColdFusion.Children] = {
			self._Fuse.new "UIListLayout" {
				Padding = UDim.new(0, 5),
				HorizontalAlignment = Enum.HorizontalAlignment.Left,
				VerticalAlignment = Enum.VerticalAlignment.Top,
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			self._Fuse.new "UIPadding"{
				PaddingBottom = UDim.new(0,10),
				PaddingTop = UDim.new(0,10),
				PaddingLeft = UDim.new(0,10),
				PaddingRight = UDim.new(0,10),
			},
			title(self, "**Animation Previewer**", "accessibility"),
			divider(self, 1),
			idInputBox(self, self.DemoAnimationId, "Demo", 3),
			self._Fuse.new "Frame" {
				Name = "LoopAnimation",
				LayoutOrder = 4,
				AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundTransparency = 1,
				Visible = self._Fuse.Computed(self.Rig, self.DemoAnimationId, function(rig, id)
					if rig == nil or id == "" or id == nil then
						return false
					else
						return true
					end
				end),
				[ColdFusion.Children] = {
					self._Fuse.new "UIListLayout" {
						Padding = UDim.new(0, 5),
						SortOrder = Enum.SortOrder.LayoutOrder,
						FillDirection = Enum.FillDirection.Horizontal,
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
						VerticalAlignment = Enum.VerticalAlignment.Center,
					},
					Synthetic.TextLabel.new {
						BackgroundTransparency = 1,
						LayoutOrder = 1,
						TextSize = 14,
						Text = "Loop Animation",
					},
					Synthetic.Switch.new {
						Scale = 1,
						LayoutOrder = 2,
						TextColor3 = Color3.new(1,1,1),
						BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
							return theme:GetColor(Enum.StudioStyleGuideColor.MainText, Enum.StudioStyleGuideModifier.Default)
						end),
						Color3 = self._Fuse.Computed(self.Theme, function(theme)
							return theme:GetColor(Enum.StudioStyleGuideColor.MainButton, Enum.StudioStyleGuideModifier.Selected)
						end),
						BubbleColor3 = Color3.fromHSV(0,0,0.7),
						Value = self.Looped,
					},
					button(self, "Replay", function()
						self.Replays:Set(self.Replays:Get()+1)
					end, self.Looped)
					-- Synthetic.Switch.new {
					-- 	LayoutOrder = 2,
					-- 	Scale = 1,
					-- }
				}
			},
		},
	}
	local textInput = card:WaitForChild("IdInputBox"):WaitForChild("TextBox")
	self.DemoAnimationId:Connect(function(cur)
		textInput.Text = cur or ""
	end)
	return card
end

function Panel.new(config)
	local self = Isotope.new()
	setmetatable(self, Panel)

	local Parent = self:Import(config.Parent, nil)
	self.Selections = config.Selections or self._Fuse.Value(game.Selection:Get())
	self._Maid:GiveTask(game.Selection.SelectionChanged:Connect(function()
		-- print("Selecting", game.Selection:Get())
		self.Selections:Set(game.Selection:Get())
	end))
	-- print("Import Selections", config.Selections)
	self.Rig = self._Fuse.Computed(self.Selections, function(selections)
		-- print("Active Selections", selections)
		for i, inst in ipairs(selections) do
			if inst.ClassName == "Model" and inst:FindFirstChild("Humanoid") then
				return inst
			end
		end
	end)
	self.Theme = self._Fuse.Value(studioSettings.Theme)
	self._Maid:GiveTask(studioSettings.ThemeChanged:Connect(function()
		self.Theme:Set(studioSettings.Theme)
	end))
	self.DemoAnimationId = self._Fuse.Value(nil)
	self.ImportAnimationId = self._Fuse.Value(nil)
	self.Looped = self._Fuse.Value(true)
	self.Replays = self._Fuse.Value(0)
	self.ExportId = self._Fuse.Computed(self.ImportAnimationId, self.Rig, function(animId, rig)
		local exportMaid = Maid.new()
		self._Maid._exportMaid = exportMaid
		if not animId or animId == "" then return end
		if not rig then return end

		local sequence = KSP:GetKeyframeSequenceAsync(animId)
		-- task.wait(1)
		if not sequence then return end

		local keyframes = sequence:GetKeyframes()
		if #keyframes == 0 then warn("No keyframes found - you might not have permission") return end
		-- print(sequence:GetFullName())
		-- sequence.Parent = workspace
		local AnimationBlock = rig:FindFirstChild("AnimSaves")
		if AnimationBlock == nil then
			AnimationBlock = Instance.new('Model')
			AnimationBlock.Name = "AnimSaves"
			AnimationBlock.Parent = rig
		end
		self._Maid._exportMaid:GiveTask(AnimationBlock)

		local Animation = AnimationBlock:FindFirstChild("ExportAnim")
		if Animation == nil then
			Animation = Instance.new('Animation')
			Animation.Name = "ExportAnim"
			Animation.Parent = AnimationBlock
		end
		sequence = Instance.new("KeyframeSequence", Animation)

		-- print("KF", keyframes)
		for i, kf in ipairs(keyframes) do
			kf.Parent = sequence
		end
		local animID = KSP:RegisterKeyframeSequence(sequence)

		Animation.AnimationId = animID

		-- pcall(function()
			-- sequence.Parent = Animation
		-- end)
		self._Maid._exportMaid:GiveTask(Animation)

		-- self._Maid._exportMaid:GiveTask(sequence)

		local selectionSet = {}
		table.insert(selectionSet, sequence)

		game.Selection:Set(selectionSet)
		task.wait()
		pcall(function()
			-- print("Plugin save")
			plugin:SaveSelectedToRoblox()
		end)
	end)

	self._Fuse.Computed(self.Rig, self.DemoAnimationId, self.Looped, self.Replays, function(rig, id, looped, replays)
		local compMaid = Maid.new()
		self._Fuse._animMaid = compMaid

		if not rig then return end
	
		local humanoid = rig:FindFirstChild("Humanoid")
		if not humanoid then return end

		local animator = humanoid:FindFirstChild("Animator")
		if not animator then animator = Instance.new("Animator", humanoid) end

		compMaid:GiveTask(function()
			for i, track in ipairs(animator:GetPlayingAnimationTracks()) do
				track:Stop()
			end
		end)
		for i, track in ipairs(animator:GetPlayingAnimationTracks()) do
			track:Stop()
		end

		if not id or id == "" then return end

		if looped == nil then looped = false end

		local animation = Instance.new("Animation")
		if string.find(id, "rbxassetid") then
			animation.AnimationId = id
		else
			animation.AnimationId = "rbxassetid://"..id
		end
		compMaid:GiveTask(animation)
		local track = animator:LoadAnimation(animation)
		track.Looped = looped
		track:Play()
		compMaid:GiveTask(function()
			track:Stop()
		end)

		-- print("Playing", animation.AnimationId)
	end)

	self._Fuse.new "Frame" {
		Parent = Parent,
		BorderSizePixel = 0,
		BackgroundTransparency = 0,
		Size = UDim2.fromScale(1,1),
		BackgroundColor3 = self._Fuse.Computed(self.Theme, function(theme)
			return theme:GetColor(Enum.StudioStyleGuideColor.ViewPortBackground, Enum.StudioStyleGuideModifier.Default)
		end),
		[ColdFusion.Children] = {
			self._Fuse.new "UIListLayout" {
				Padding = UDim.new(0, 5),
				HorizontalAlignment = self._Fuse.Computed(self.Rig, function(rig)
					if rig == nil then
						return Enum.HorizontalAlignment.Center
					else
						return Enum.HorizontalAlignment.Left
					end
				end),
				VerticalAlignment = self._Fuse.Computed(self.Rig, function(rig)
					if rig == nil then
						return Enum.VerticalAlignment.Center
					else
						return Enum.VerticalAlignment.Top
					end
				end),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},
			self._Fuse.new "UIPadding"{
				PaddingBottom = UDim.new(0,5),
				PaddingTop = UDim.new(0,5),
				PaddingLeft = UDim.new(0,5),
				PaddingRight = UDim.new(0,5),
			},
			Synthetic.TextLabel.new{
				LayoutOrder = 00,
				TextSize = 20,
				BackgroundTransparency = 1,
				Text = self._Fuse.Computed(self.Rig, function(rig)
					if rig == nil then
						return "*Select a rig*"
					else
						return "**"..rig.Name.." selected**"
					end
				end),
				TextColor3 = self._Fuse.Computed(self.Rig, function(rig)
					if rig == nil then
						return Color3.fromHSV(0,1,1)
					else
						return Color3.fromHSV(0.4,1,1)
					end
				end):Tween(),
			},
			playerCard(self, 4),
			animList(self, 5),
			-- importCard(self, 3)
		},
	}

	return self
end

return Panel

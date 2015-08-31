wait(1)
local Player = script.Parent.Parent.Parent
local Gui = script.Parent.ToolFrame

Player.Values.PlayIntro.Changed:connect(function(newVal)
		script.Parent.Parent.Sounds.Intro:Play()
end)

local toolsOpen = false
Gui.Expand.MouseButton1Down:connect(function()
	if toolsOpen then
		Gui.Expand:TweenPosition(
			UDim2.new(0, 0, 0.5, -105),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.5, true
		)
		Gui.Expand.Help.Text = "Click to Expand"
		toolsOpen = false
	else
		Gui.Expand:TweenPosition(
			UDim2.new(0, 100, 0.5, -105),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.5, true
		)
		Gui.Expand.Help.Text = "Click to Collapse"
		toolsOpen = true	
	end
end)

Player.Values.ToolEquipped.Changed:connect(function(newVal)
	local function hide()
		script.Parent.Builder:TweenPosition(
			UDim2.new(1, 20, 1, -320),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
		script.Parent.Color:TweenPosition(
			UDim2.new(1, 20, 1, -270),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
		script.Parent.Configure:TweenPosition(
			UDim2.new(1, 20, 1, -220),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
		script.Parent.Deleter:TweenPosition(
			UDim2.new(1, 20, 1, -65),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
		script.Parent.Rotate:TweenPosition(
			UDim2.new(1, 20, 1, -105),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
		wait(0.1)
	end
	if newVal == "Builder" then
		hide()
		script.Parent.Builder:TweenPosition(
			UDim2.new(1, -220, 1, -320),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
	elseif newVal == "Color" then
		hide()
		script.Parent.Color:TweenPosition(
			UDim2.new(1, -220, 1, -270),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
	elseif newVal == "Configure" then
		hide()
		script.Parent.Configure:TweenPosition(
			UDim2.new(1, -220, 1, -220),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
	elseif newVal == "Rotate" then
		hide()
		script.Parent.Rotate:TweenPosition(
			UDim2.new(1, -220, 1, -105),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
	elseif newVal == "Remove" then
		hide()
		script.Parent.Deleter:TweenPosition(
			UDim2.new(1, -220, 1, -65),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Elastic,
			1, true
		)
	else
		hide()
	end
end)

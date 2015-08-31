wait(1)
local values = script.Parent.Parent.Parent.Parent.Values

local colorWatch = false
local frameColor
local colorValue

script.Parent.HoverColor.Color.BackgroundColor3 = values.HoverColor.Value.Color
script.Parent.SelectionColor.Color.BackgroundColor3 = values.SelectionColor.Value.Color
script.Parent.BlueprintColor.Color.BackgroundColor3 = values.BlueprintColor.Value.Color

script.Parent.HoverColor.MouseButton1Down:connect(function()
	colorWatch = true
	frameColor = script.Parent.HoverColor.Color
	colorValue = values.HoverColor
	script.Parent.Visible = false
	script.Parent.Parent.ColorPicker.Visible = true
	script.Parent.CanShow.Value = false
end)

script.Parent.SelectionColor.MouseButton1Down:connect(function()
	colorWatch = true
	frameColor = script.Parent.SelectionColor.Color
	colorValue = values.SelectionColor
	script.Parent.Visible = false
	script.Parent.Parent.ColorPicker.Visible = true
	script.Parent.CanShow.Value = false
end)

script.Parent.BlueprintColor.MouseButton1Down:connect(function()
	colorWatch = true
	frameColor = script.Parent.BlueprintColor.Color
	colorValue = values.BlueprintColor
	script.Parent.Visible = false
	script.Parent.Parent.ColorPicker.Visible = true
	script.Parent.CanShow.Value = false
end)

script.Parent.Parent.ColorPicker.ColorPicked.Changed:connect(function(newVal)
	if colorWatch then
		colorWatch = false
		frameColor.BackgroundColor3 = newVal.Color
		colorValue.Value = newVal
		script.Parent.Visible = true
		script.Parent.Parent.ColorPicker.Visible = false
		script.Parent.CanShow.Value = true
	end
end)

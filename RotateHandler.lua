wait(1)
local selection = script.Parent.Parent.Parent.Parent.Values.Selection

selection.Changed:connect(function(newVal)
	if newVal and newVal.BoundStructure.Value then
		script.Parent.RotateLeft.Visible = true
		script.Parent.RotateRight.Visible = true
		script.Parent.Selection.Visible = false
	else
		script.Parent.RotateLeft.Visible = false
		script.Parent.RotateRight.Visible = false
		script.Parent.Selection.Visible = true
	end
end)

local debounce = true
script.Parent.RotateRight.MouseButton1Down:connect(function()
	if debounce then
		debounce = false
		if selection.Value and selection.Value.BoundStructure.Value then
			local building = selection.Value.BoundStructure.Value
			if building.Rotation.Value < 3 then
				building.Rotation.Value = building.Rotation.Value + 1
			else
				building.Rotation.Value = 0
			end
			building:SetPrimaryPartCFrame(building:GetPrimaryPartCFrame() * CFrame.Angles(0, math.pi/2, 0))
		end
		debounce = true
	end
end)
script.Parent.RotateLeft.MouseButton1Down:connect(function()
	if debounce then
		debounce = false
		if selection.Value and selection.Value.BoundStructure.Value then
			local building = selection.Value.BoundStructure.Value
			if building.Rotation.Value > 0 then
				building.Rotation.Value = building.Rotation.Value - 1
			else
				building.Rotation.Value = 3
			end
			building:SetPrimaryPartCFrame(building:GetPrimaryPartCFrame() * CFrame.Angles(0, -math.pi/2, 0))
		end
		debounce = true
	end
end)

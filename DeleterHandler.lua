wait(1)
local selection = script.Parent.Parent.Parent.Parent.Values.Selection

selection.Changed:connect(function(newVal)
	if newVal and newVal.BoundStructure.Value then
		script.Parent.Selection.Visible = false
		script.Parent.Delete.Visible = true
	else
		script.Parent.Selection.Visible = true
		script.Parent.Delete.Visible = false
	end
end)

local debounce = true
script.Parent.Delete.MouseButton1Down:connect(function()
	if debounce then
		debounce = false
		if selection.Value and selection.Value.HasBuilding.Value then
			wait()
			selection.Value.BoundStructure.Value:Destroy()
			selection.Value.Parent.Parent.BuildingCount.Value = selection.Value.Parent.Parent.BuildingCount.Value - 1
			selection.Value.BoundStructure.Value = nil
			selection.Value.HasBuilding.Value = false
			wait()
			script.Parent.Delete.Text = "Removed"
			wait(1)
			script.Parent.Delete.Text = "Remove"
		elseif selection.Value and not selection.Value.HasBuilding.Value then
			script.Parent.Delete.Text = "No Structure"
			wait(1)
			script.Parent.Delete.Text = "Remove"
		else
			script.Parent.Delete.Text = "Nothing Selected"
			wait(1)
			script.Parent.Delete.Text = "Remove"
		end
		debounce = true
	end
end)

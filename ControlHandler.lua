local control = script.Parent
local controlLink = control.Adornee
local controlModel = controlLink.Parent
local player = control.Parent.Parent

control.ClaimButton.MouseButton1Down:connect(function()
	if controlModel.Owner.Value == "No One" and not controlModel.IsGenerating.Value then
		if player.Values.LinkedPlot.Value == nil then
			
			player.Values.LinkedPlot.Value = controlModel
			controlModel.IsGenerating.Value = true
			
			controlModel.Owner.Value = player.Name
			controlModel.GuiStatus.Value = "GENERATING"
			control.ClaimButton.Select.Visible = false
			controlModel.GenerateGrid:InvokeServer()
			
			for x = 1, 50 do
				controlLink.CFrame = controlLink.CFrame + Vector3.new(0, -0.05, 0)
				wait(0.05)
			end
			controlModel.GuiStatus.Value = "RESETTING"
			controlModel.IsGenerating.Value = false
		end
	end
end)

controlModel.GuiStatus.Changed:connect(function(newValue)
	control.ClaimButton.Text = newValue
end)

control.ClaimButton.MouseEnter:connect(function()
	if controlModel.Owner.Value == "No One" and not controlModel.IsGenerating.Value then
		control.ClaimButton.Select.Visible = true
	else
		control.ClaimButton.Select.Visible = false
	end
	
end)
control.ClaimButton.MouseLeave:connect(function()
	if controlModel.Owner.Value == "No One" and not controlModel.IsGenerating.Value then
		control.ClaimButton.Select.Visible = false
	end
end)

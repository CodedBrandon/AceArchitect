wait(1)
local selection = script.Parent.Parent.Parent.Parent.Values.Selection
local sizeIterator = 60

selection.Changed:connect(function(newVal)
	if newVal and newVal.BoundStructure.Value then
		local configs = newVal.BoundStructure.Value:FindFirstChild("Configure")
		if configs then
			local configValues = configs:GetChildren()
			if #configValues > 0 then
				script.Parent.Selection.Visible = false
				script.Parent.List.Visible = true
				for _, value in pairs(configValues) do
					if value:IsA("IntValue") then
						local configBind = script.Parent.List.Config:Clone()
						configBind.Parent = script.Parent.List
						configBind.ConfigName.Text = value.Name
						configBind.Name = "IntConfig"
						configBind.ConfigEdit.Text = value.Value
						configBind.ConfigEdit.FocusLost:connect(function(entered)
							if entered then
								pcall(function()
									if tonumber(configBind.ConfigEdit.Text) then
										value.Value = tonumber(configBind.ConfigEdit.Text)-1
									end
								end)
							end
						end)
						configBind.Visible = true
						script.Parent.List.CanvasSize = UDim2.new(1, 0, 0, sizeIterator)
						sizeIterator = sizeIterator + 60
					end
				end
			else
				script.Parent.Selection.Visible = true
				script.Parent.List.Visible = false
				for _, config in pairs(script.Parent.List:GetChildren()) do
					if config.Visible then
						config:Destroy()
					end
				end
				script.Parent.List.CanvasSize = UDim2.new(1, 0, 0, 0)
				sizeIterator = 60
			end
		end
	else
		script.Parent.Selection.Visible = true
		script.Parent.List.Visible = false
		for _, config in pairs(script.Parent.List:GetChildren()) do
			if config.Visible then
				config:Destroy()
			end
		end
		script.Parent.List.CanvasSize = UDim2.new(1, 0, 0, 0)
		sizeIterator = 60
	end
end)

wait(1)
local selection = script.Parent.Parent.Parent.Parent.Values.Selection
local colorWatch = false
local colorProperty
local colorDisplay

selection.Changed:connect(function(newVal)
	if newVal and newVal.BoundStructure.Value then
		script.Parent.List.Visible = true
		for _, property in pairs(script.Parent.List:GetChildren()) do
			property:Destroy()
		end
		for iterator, property in pairs(newVal.BoundStructure.Value.Properties:GetChildren()) do
			local color = Instance.new("TextButton")
			color.Parent = script.Parent.List
			color.AutoButtonColor = false
			color.BackgroundColor3 = Color3.new(75/255, 75/255, 75/255)
			color.BorderSizePixel = 0
			color.Name = property.Name
			color.Position = UDim2.new(0, 0, 0, (iterator-1)*50)
			color.Size = UDim2.new(1, -12, 0, 50)
			color.Font = Enum.Font.SourceSans
			color.FontSize = Enum.FontSize.Size24
			color.Text = " "..property.Name:gsub("Color", "")
			color.TextColor3 = Color3.new(0, 0, 0)
			color.TextXAlignment = Enum.TextXAlignment.Left
			script.Parent.List.CanvasSize = UDim2.new(0, 0, 0, (iterator)*50)
			
			local display = Instance.new("Frame")
			display.Parent = color
			display.BackgroundColor3 = property.Value.Color
			display.BorderColor3 = Color3.new(50/255, 50/255, 50/255)
			display.BorderSizePixel = 3
			display.Name = "ColorDisplay"
			display.Position = UDim2.new(1, - 40, 0.5, -15)
			display.Size = UDim2.new(0, 30, 0, 30)
			
			color.MouseButton1Down:connect(function()
				colorWatch = true
				colorProperty = property
				colorDisplay = display
				script.Parent.Parent.ColorPicker.Visible = true
			end)
		end
		script.Parent.Selection.Visible = false
	else
		script.Parent.Selection.Visible = true
		script.Parent.List.Visible = false
	end
end)

script.Parent.Parent.ColorPicker.ColorPicked.Changed:connect(function(newVal)
	if colorWatch and colorProperty and colorDisplay then
		colorWatch = false
		colorProperty.Value = newVal
		colorDisplay.BackgroundColor3 = newVal.Color
		script.Parent.Parent.ColorPicker.Visible = false
		colorProperty = nil
		colorDisplay = nil
	end
end)

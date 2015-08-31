wait(1)
local player = script.Parent.Parent.Parent.Parent
local playerFocus = ""
local posIterator = 40
local listOpen = true

script.Parent.Parent.Parent.UpdatePlayerList.OnClientEvent:connect(function()
	for _, listItem in pairs(script.Parent:GetChildren()) do
		if listItem:IsA("TextButton") and listItem.Name == "Player" then
			listItem:Destroy()
		end
	end
	posIterator = 40
	for _, playerMarked in pairs(game.Players:GetChildren()) do
		local pos = posIterator
		local playerButton = Instance.new("TextButton")
		playerButton.Parent = script.Parent
		playerButton.BackgroundTransparency = 1
		playerButton.Name = "Player"
		playerButton.Position = UDim2.new(0, 0, 0, pos)
		playerButton.Size = UDim2.new(1, 0, 0, 30)
		playerButton.Font = Enum.Font.Arial
		playerButton.FontSize = Enum.FontSize.Size18
		playerButton.Text = playerMarked.Name
		playerButton.TextColor3 = Color3.new(0, 0, 0)
		playerButton.TextStrokeColor3 = Color3.new(100/255, 100/255, 100/255)
		playerButton.TextStrokeTransparency = 0.5
		playerButton.MouseButton1Down:connect(function()
			if player.Values.LinkedPlot.Value and playerMarked.Name ~= player.Name then
				script.Parent.Menu.Position = UDim2.new(0, -155, 0, pos)
				script.Parent.Menu.Visible = true
				playerFocus = playerMarked.Name
				for _, builder in pairs(player.Values.LinkedPlot.Value.Builders:GetChildren()) do
					if builder.Value == playerMarked.Name then
						script.Parent.Menu.BuildingPerms.Text = "Remove Building Permissions"
					else
						script.Parent.Menu.BuildingPerms.Text = "Give Building Permissions"
					end
				end
			end
		end)
		posIterator = posIterator + 30
		if listOpen then
			script.Parent.Size = UDim2.new(0, 200, 0, posIterator)
		else
			playerButton.Visible = false
		end
	end
end)

script.Parent.Title.MouseButton1Click:connect(function()
	if listOpen then
		script.Parent.Size = UDim2.new(0, 200, 0, 40)
		listOpen = false
		for _, button in pairs(script.Parent:GetChildren()) do
			if button:IsA("TextButton") and button.Name == "Player" then
				button.Visible = false
			end
		end
	else
		script.Parent.Size = UDim2.new(0, 200, 0, posIterator)
		listOpen = true
		for _, button in pairs(script.Parent:GetChildren()) do
			if button:IsA("TextButton") and button.Name == "Player" then
				button.Visible = true
			end
		end
	end
end)

player:GetMouse().Button1Down:connect(function()
	if script.Parent.Menu.Visible then
		script.Parent.Menu.Visible = false
	end
end)

script.Parent.Menu.BuildingPerms.MouseButton1Down:connect(function()
	if script.Parent.Menu.BuildingPerms.Text == "Give Building Permissions" then
		local playerInstance = Instance.new("StringValue")
		playerInstance.Name = "Player"
		playerInstance.Value = playerFocus
 		playerInstance.Parent = player.Values.LinkedPlot.Value.Builders
		script.Parent.Menu.BuildingPerms.Text = "Remove Building Permissions"
	elseif script.Parent.Menu.BuildingPerms.Text == "Remove Building Permissions" then
		for _, builder in pairs(player.Values.LinkedPlot.Value.Builders:GetChildren()) do
			if builder.Value == playerFocus then
				builder:Destroy()
				break
			end
		end
		script.Parent.Menu.BuildingPerms.Text = "Give Building Permissions"
	end
end)

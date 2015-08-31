local DataStore = game:GetService("DataStoreService"):GetDataStore("test")
local Version = "Version 1.03"

game.Players.PlayerAdded:connect(function(player)
	local Values = script.Values:Clone()
	Values.Parent = player
	
	local Functions = script.Functions:Clone()
	Functions.Parent = player
	
	local toolScript = script.ToolScript:Clone()
	toolScript.Parent = player:WaitForChild("Backpack")
	toolScript.Disabled = false
	
	for _, player in pairs(game.Players:GetChildren()) do
		player.PlayerGui.UpdatePlayerList:FireClient(player)
	end
	
	while not player.DataReady do wait(1) end
	wait(2)
	
	if DataStore ~= nil then
		local playerData = DataStore:GetAsync("data_"..player.Name)
		if playerData then
			Functions.LoadSaves:Invoke(playerData.Saves)
			Values.HoverColor.Value = BrickColor.new(
				playerData.HoverColor.r,
				playerData.HoverColor.g,
				playerData.HoverColor.b
			)
			Values.SelectionColor.Value = BrickColor.new(
				playerData.SelectionColor.r,
				playerData.SelectionColor.g,
				playerData.SelectionColor.b
			)
			Values.BlueprintColor.Value = BrickColor.new(
				playerData.BlueprintColor.r,
				playerData.BlueprintColor.g,
				playerData.BlueprintColor.b
			)
		end
	end
	do -- Entrance GUI
		local Container = player.PlayerGui.EntranceScreen.Main.Container
		local function fadeText(start, stop, interval)
			for x = start, stop, interval do
				Container.TextDisplay.TextTransparency = x
				wait(0.01)
			end
		end
		
		fadeText(0, 1, 0.05)
		Container.TextDisplay.Text = ""
		Values.PlayIntro.Value = true
		Container.TextDisplay.Position = UDim2.new(0, 0, 0.73, 0)
		Container.TextDisplay.TextTransparency = 1
		wait(0.5)
		
		Container.Logo.Visible = true
		
		Container.Logo:TweenPosition(
			UDim2.new(0.5, -150, 0, 0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			3, false
		)
		
		for x = 1, 0, -0.05 do
			Container.Logo.ImageTransparency = x
			wait(0.02)
		end
		
		Container.Seperator:TweenSizeAndPosition(
			UDim2.new(0.9, 0, 0, 2),
			UDim2.new(0.05, 0, 0.68, 0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quart,
			4, false
		)
		wait(2.5)
		
		Container.TextDisplay.Text = "Ace Architect"
		fadeText(1, 0, -0.05)
		wait(0.5)
		fadeText(0, 1, 0.05)
		Container.TextDisplay.Text = Version
		fadeText(1, 0, -0.05)
		wait(0.5)
		fadeText(0, 1, 0.05)
		
		Container.Seperator:TweenSizeAndPosition(
			UDim2.new(0, 0, 0, 2),
			UDim2.new(0.5, 0, 0.68, 0),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Linear,
		1, false)
		
		wait(1)
		
		Container.Logo:TweenPosition(
			UDim2.new(0.5, -150, 0.5, -150),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			8, false
		)
		
		for x = 0, 1, 0.01 do
			Container.Logo.ImageTransparency = x
			wait(0.01)
		end
		
		Container.Visible = false
		
		for x = 0, 1, 0.02 do
			Container.Parent.BackgroundTransparency = x
			wait(0.01)
		end
	end
end)

game.Players.PlayerRemoving:connect(function(player)
	local playerData = {Saves = player.PlayerGui.GetSaves:InvokeClient(player) or {}}
	playerData.HoverColor = {
		r = player.Values.HoverColor.Value.Color.r,
		g = player.Values.HoverColor.Value.Color.g,
		b = player.Values.HoverColor.Value.Color.b
	}
	playerData.SelectionColor = {
		r = player.Values.SelectionColor.Value.Color.r,
		g = player.Values.SelectionColor.Value.Color.g,
		b = player.Values.SelectionColor.Value.Color.b
	}
	playerData.BlueprintColor = {
		r = player.Values.BlueprintColor.Value.Color.r,
		g = player.Values.BlueprintColor.Value.Color.g,
		b = player.Values.BlueprintColor.Value.Color.b
	}
	
	DataStore:SetAsync("data_"..player.Name, playerData)
	
	if player.Values.LinkedPlot.Value ~= nil then
		local ownedPlot = player.Values.LinkedPlot.Value
		ownedPlot.IsGenerating.Value = true
		ownedPlot.Owner.Value = "No One"
		ownedPlot.BuildingCount.Value = 0
		ownedPlot.GuiPlace.CFrame = ownedPlot.GuiPlace.CFrame + Vector3.new(0, 2.5, 0)
		ownedPlot.GuiStatus.Value = "RESETTING"
		ownedPlot.ServerReset:Invoke()
		ownedPlot.GuiStatus.Value = "CLAIM"
		ownedPlot.IsGenerating.Value = false
	end
	
	for _, player in pairs(game.Players:GetChildren()) do
		player.PlayerGui.UpdatePlayerList:FireClient(player)
	end
end)

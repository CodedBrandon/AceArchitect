wait()
local player = script.Parent.Parent.Parent.Parent
local values = player.Values
local gui = script.Parent
local posIterator = 0
local indexIterator = 1
local structures = require(script.Parent.Parent.Structures)
local insert = game.InsertService
local saveBox = Instance.new("SelectionBox")
saveBox.Color = values.BlueprintColor.Value
saveBox.Parent = game.Workspace.CurrentCamera
values.BlueprintColor.Changed:connect(function(newVal)
	saveBox.Color = newVal
end)

saves = {}

local debounce = true
function setNewBlueprint(newBlueprint, city, name)
	newBlueprint.Name = name
	newBlueprint.Visible = true
	newBlueprint.Parent = gui.List
	newBlueprint.Position = UDim2.new(0, 0, 0, posIterator)
	newBlueprint.SaveIndex.Value = indexIterator
	gui.List.CanvasSize = UDim2.new(0, 0, 0, posIterator)
	
	-- Save
	newBlueprint.SaveButton.MouseButton1Down:connect(function()
		if newBlueprint.SaveButton.Text == "Are you sure?" and debounce then
			newBlueprint.SaveButton.Text = "Saving"
			debounce = false
			gui.SaveCity.Text = "Saving Blueprint"
			gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 0)						
			local newSave = {name = saves[newBlueprint.SaveIndex.Value].name}
			for x = 1, 24 do
				newSave[x] = {}
				for y = 1, 24 do
					local citySpace = city.GetAt:InvokeServer(x, y)
							if citySpace then
								saveBox.Adornee = citySpace
								if citySpace.HasBuilding.Value and citySpace.BoundStructure.Value then
									newSave[x][y] = {
										name = citySpace.BoundStructure.Value.BuildingType.Value,
										rotation = citySpace.BoundStructure.Value.Rotation.Value,
										colors = {},
										configs = {}
									}
									print(newSave[x][y].name)
									for _, color in pairs(citySpace.BoundStructure.Value.Properties:GetChildren()) do
										newSave[x][y].colors[color.Name] = color.Value
									end
									if citySpace.BoundStructure.Value.Configure then
										for _, config in pairs(citySpace.BoundStructure.Value.Configure:GetChildren()) do
											newSave[x][y].configs[config.Name] = config.Value
										end
									end
								else
									newSave[x][y] = {name = "Empty", rotation = 0, colors = {}, configs = {}}
								end
							else
								saveBox.Adornee = nil
							end
				end
			end
			saveBox.Adornee = nil
			saves[newBlueprint.SaveIndex.Value] = newSave
			gui.SaveCity.Text = "Successful Blueprint Save"
			wait(1)
			gui.SaveCity.Text = "Create New Blueprint"
			gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 255/255)
			newBlueprint.SaveButton.Text = "Save"
			debounce = true
		elseif newBlueprint.SaveButton.Text == "Save" and debounce then
			newBlueprint.SaveButton.Text = "Are you sure?"
		end
	end)
	newBlueprint.SaveButton.MouseLeave:connect(function()
				if newBlueprint.SaveButton.Text ~= "Saving" then
					newBlueprint.SaveButton.Text = "Save"
				end
	end)
			
			-- Load
			newBlueprint.LoadButton.MouseButton1Down:connect(function()
				if newBlueprint.LoadButton.Text == "Are you sure?" and debounce then
					newBlueprint.LoadButton.Text = "Loading"
					debounce = false
					gui.SaveCity.Text = "Clearing City"
					gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 0)
					for x = 1, 24 do
						for y = 1, 24 do
							local citySpace = city.GetAt:InvokeServer(x, y)
							if citySpace then
								saveBox.Adornee = citySpace
								if citySpace.HasBuilding.Value and citySpace.BoundStructure.Value then
									citySpace.HasBuilding.Value = false
									citySpace.BoundStructure.Value:Destroy()
									citySpace.Parent.Parent.BuildingCount.Value = citySpace.Parent.Parent.BuildingCount.Value - 1
								end
							else
								saveBox.Adornee = nil
							end
						end
					end
					saveBox.Adornee = nil
					gui.SaveCity.Text = "Loading Blueprint"
					wait(1)
					for x = 1, 24 do
						for y = 1, 24 do
							local citySpace = city.GetAt:InvokeServer(x, y)
							if citySpace and not citySpace.HasBuilding.Value then
								saveBox.Adornee = citySpace
								local newStructure = saves[newBlueprint.SaveIndex.Value][x][y]
								--pcall(function()
									if newStructure.name == "Empty" then
										
									else
										local asset = insert:LoadAsset(structures[tostring(newStructure.name)])
										local building = asset.Building
										building.Parent = citySpace.Parent.Parent.Buildings
										building.Binding.Value = citySpace
										do
											local movePos = citySpace.Position + Vector3.new(0, building.PrimaryPart.Size.Y/2+0.2, 0)
											building:SetPrimaryPartCFrame(CFrame.new() + movePos)
											local rotation = (math.pi/2) * newStructure.rotation
											building:SetPrimaryPartCFrame(building:GetPrimaryPartCFrame() * CFrame.Angles(0, rotation, 0))
											building.Rotation.Value = newStructure.rotation
											citySpace.HasBuilding.Value = true
										end
										for _, color in pairs(building.Properties:GetChildren()) do
											for name, savedColor in pairs(newStructure.colors) do
												if color.Name == name then
													color.Value = savedColor
													break
												end
											end
										end
										if building:FindFirstChild("Configure") then
											for _, config in pairs(building.Configure:GetChildren()) do
												for name, savedConfig in pairs(newStructure.configs) do
													if config.Name == name then
														config.Value = savedConfig
														break
													end
												end
											end
										end
										citySpace.BoundStructure.Value = building
										citySpace.Parent.Parent.BuildingCount.Value = citySpace.Parent.Parent.BuildingCount.Value + 1
									end
								--end)
							end
						end
					end
					saveBox.Adornee = nil
					gui.SaveCity.Text = "Successful Blueprint Load"
					wait(1)
					gui.SaveCity.Text = "Create New Blueprint"
					gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 255/255)
					newBlueprint.LoadButton.Text = "Load"
					debounce = true
				elseif newBlueprint.LoadButton.Text == "Load" and debounce then
					newBlueprint.LoadButton.Text = "Are you sure?"
				end
			end)
			newBlueprint.LoadButton.MouseLeave:connect(function()
				if newBlueprint.LoadButton.Text ~= "Loading" then
					newBlueprint.LoadButton.Text = "Load"
				end
			end)
			
			newBlueprint.NameEdit.FocusLost:connect(function(entered)
				if entered and #newBlueprint.NameEdit.Text < 15 then
					saves[newBlueprint.SaveIndex.Value].name = newBlueprint.NameEdit.Text
				else
					newBlueprint.NameEdit.Text = saves[newBlueprint.SaveIndex.Value].name
				end
			end)
end

gui.SaveCity.MouseButton1Down:connect(function()
	if debounce then
		debounce = false
		
		if values.LinkedPlot.Value then
			local city = values.LinkedPlot.Value
			local save = {}
			
			gui.SaveCity.Text = "Creating Blueprint"
			gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 0)
			
			for x = 1, 24 do
				save[x] = {}
				for y = 1, 24 do
					local citySpace = city.GetAt:InvokeServer(x, y)
					if citySpace then
						saveBox.Adornee = citySpace
						if citySpace.HasBuilding.Value and citySpace.BoundStructure.Value then
							save[x][y] = {
								name = citySpace.BoundStructure.Value.BuildingType.Value,
								rotation = citySpace.BoundStructure.Value.Rotation.Value,
								colors = {},
								configs = {}
							}
							
							for _, color in pairs(citySpace.BoundStructure.Value.Properties:GetChildren()) do
								save[x][y].colors[color.Name] = color.Value
							end
							if citySpace.BoundStructure.Value.Configure then
								for _, config in pairs(citySpace.BoundStructure.Value.Configure:GetChildren()) do
									save[x][y].configs[config.Name] = config.Value
								end
							end
						else
							save[x][y] = {name = "Empty", rotation = 0, colors = {}, configs = {}}
						end
					else
						saveBox.Adornee = nil
					end
				end
			end
			
			save.name = "New Blueprint"
			saveBox.Adornee = nil
			local newBlueprint = gui.List.Blueprint:Clone()
			setNewBlueprint(newBlueprint, city, save.name)
			posIterator = posIterator + 80
			table.insert(saves, indexIterator, save)
					
			
			indexIterator = indexIterator + 1
			gui.SaveCity.Text = "Created Blueprint"
			wait(1)
			gui.SaveCity.Text = "Create New Blueprint"
			gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 255/255)
		else
			gui.SaveCity.Text = "No City"
			gui.SaveCity.BackgroundColor3 = Color3.new(150/255, 0, 0)
			wait(2)
			gui.SaveCity.Text = "Create New Blueprint"
			gui.SaveCity.BackgroundColor3 = Color3.new(0, 85/255, 255/255)
		end
		
		debounce = true
	end
end)

script.Parent.Parent.Parent.GetSaves.OnClientInvoke = function()
	return saves
end

player.Functions.LoadSaves.OnInvoke = function(savesTable)
	for _, save in pairs(savesTable) do
		local newBlueprint = gui.List.Blueprint:Clone()
		setNewBlueprint(newBlueprint, player.Values.LinkedPlot.Value, save.name)
		indexIterator = indexIterator + 1
	end
end

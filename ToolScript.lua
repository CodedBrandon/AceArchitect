local player = script.Parent.Parent
local mouse = player:GetMouse()
local values = player.Values

local hover = Instance.new("SelectionBox")
hover.Color = values.HoverColor.Value
hover.Parent = game.Workspace.CurrentCamera
values.HoverColor.Changed:connect(function(newVal)
	hover.Color = newVal
end)

local selection = Instance.new("SelectionBox")
selection.Color = values.SelectionColor.Value
selection.Parent = game.Workspace.CurrentCamera
values.SelectionColor.Changed:connect(function(newVal)
	selection.Color = newVal
end)

function MouseMove()
	if mouse.Target then
		local target = mouse.Target
		if target and target.Name == "AreaCheck" and target ~= selection.Adornee then
			if target.Parent.Parent.Owner.Value == player.Name then
				hover.Adornee = target
			else
				for _, builder in pairs(target.Parent.Parent.Builders:GetChildren()) do
					if builder.Value == player.Name then
						hover.Adornee = target
						break
					end
					hover.Adornee = nil
				end
			end
		elseif target and target.Name == "AnchorPoint" and target ~= selection.Adornee then
			local bind = target.Parent.Binding.Value
			if bind.Parent.Parent.Owner.Value then
				if bind.Parent.Parent.Owner.Value == player.Name then
					hover.Adornee = target.Parent.Binding.Value
				else
					for _, builder in pairs(bind.Parent.Parent.Builders:GetChildren()) do
						if builder.Value == player.Name then
							hover.Adornee = target.Parent.Binding.Value
							break
						end
					end
				end
			else
				hover.Adornee = nil
			end
		else
			hover.Adornee = nil
		end
	else
		hover.Adornee = nil
	end
end

function MouseClick()
	if hover.Adornee then
		selection.Adornee = hover.Adornee
		values.Selection.Value = selection.Adornee
	else
		selection.Adornee = nil
		values.Selection.Value = nil
	end
end

function KeyDown(key)
	
end

mouse.Move:connect(MouseMove)
mouse.Button1Down:connect(MouseClick)
mouse.KeyDown:connect(KeyDown)

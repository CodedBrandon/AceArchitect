local control = script.Parent
local controlModel = control.Adornee.Parent

function updateInfo()
	control.Info.Text = "Owner: "..controlModel.Owner.Value.."\nStructure Count: "..controlModel.BuildingCount.Value
end

controlModel.Owner.Changed:connect(function(newVal)
	updateInfo()
end)

controlModel.BuildingCount.Changed:connect(function(newVal)
	updateInfo()
end)

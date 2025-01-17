local PhysicsService = game:GetService("PhysicsService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local towers = ReplicatedStorage:WaitForChild("Towers")

local camera = workspace.CurrentCamera
local gui = script.Parent
local towerToSpawn = nil

local function MouseRaycast(blacklist)
	local mousePosition = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)
	local raycastParams = RaycastParams.new()
	
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.FilterDescendantsInstances = blacklist
	
	local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000, raycastParams)
	
	return raycastResult
end

local function AddTempTower(name)
	local towerExists = towers:FindFirstChild(name)
	if towerExists then
		towerToSpawn = towerExists:Clone()
		towerToSpawn.Parent = workspace.Towers
		
		for i, object in ipairs(towerToSpawn:GetDescendants()) do
			if object:IsA("BasePart") then
				object.CollisionGroup = "Tower"
				object.Material = Enum.Material.ForceField
			end
		end
	end
end

gui.Tower1Button.Activated:Connect(function()
	AddTempTower("Tower1")
end)

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		
	end
end)

RunService.RenderStepped:Connect(function()
	if towerToSpawn then
		local result = MouseRaycast({towerToSpawn})
		if result and result.Instance then
			local x = result.Position.X
			local y = result.Position.Y + towerToSpawn["Left Leg"].Size.Y + (towerToSpawn.PrimaryPart.Size.Y / 2)
			local z = result.Position.Z
			
			local cframe = CFrame.new(x,y,z)
			towerToSpawn:SetPrimaryPartCFrame(cframe)
		end
	end
end)
local PhysicsService = game:GetService("PhysicsService")
local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local events = ReplicatedStorage:WaitForChild("Events")
local spawnTower = events:WaitForChild("SpawnTower")
local tower = {}

function FindNearestTarget(newTower)
	local maxDistance = 30 --edit for tower range
	local nearestTarget = nil

	for i, target in ipairs(workspace.Mobs:GetChildren()) do
		local distance = (target.HumanoidRootPart.Position - newTower.HumanoidRootPart.Position).Magnitude
		print(target.Name, distance)

		if distance <= maxDistance then
			print(target.Name, "target found at", distance, "studs away")
			nearestTarget = target
			maxDistance = distance
		end
	end

	return nearestTarget
end

function tower.Attack(newTower)
	local target = FindNearestTarget(newTower)
	if target then
		target.Humanoid:TakeDamage(25)
	end

	task.wait(1)
	tower.Attack(newTower) --creates an inf recursive
end

function tower.Spawn(player, name, cframe)
	local towerExists = ReplicatedStorage.Towers:FindFirstChild(name)
	
	if towerExists then
		local newTower = towerExists:Clone()
		newTower.HumanoidRootPart.CFrame = cframe
		newTower.Parent = workspace.Towers
		newTower.HumanoidRootPart:SetNetworkOwner(nil)
		
		for i, object in ipairs(newTower:GetDescendants()) do
			if object:IsA("BasePart") then
				object.CollisionGroup = "Tower"
			end
		end
		
		coroutine.wrap(tower.Attack)(newTower)
	else
		warn("Tower Does Not Exist -->", name)
	end
end

spawnTower.OnServerEvent:Connect(tower.Spawn)

return tower

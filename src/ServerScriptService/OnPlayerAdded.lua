-- physics script
local Players = game:GetService("Players")
local PhysicsService = game:GetService("PhysicsService")

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		for _, part in pairs(character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CollisionGroup = "Player"
			end
		end
	end)
end)
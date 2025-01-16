local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera

local item = nil

local function MouseRaycast()
	local mousePosition = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)
	local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000)
	
	return raycastResult
end

UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		if item:IsA("BasePart") then
			item.Color = Color3.new(1,0,0) -- this is to visualize what is being clicked, will remove later
		end
	end
end)

RunService.RenderStepped:Connect(function()
	local result = MouseRaycast()
	if result and result.Instance then
		item = result.Instance
	end
end)
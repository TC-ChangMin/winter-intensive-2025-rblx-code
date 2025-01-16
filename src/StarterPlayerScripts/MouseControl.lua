local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera


local function MouseRaycast()
	local mousePosition = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)
	local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000)
	
	return raycastResult
end

RunService.RenderStepped:Connect(function()
	local result = MouseRaycast()
	if result and result.Instance then
		print(result.Instance.Name)
	end
end)
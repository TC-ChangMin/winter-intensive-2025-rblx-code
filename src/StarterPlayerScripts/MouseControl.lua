local UserInputService = game:GetService("UserInputService")
local camera = workspace.CurrentCamera


local function MouseRaycast()
	local mousePosition = UserInputService:GetMouseLocation()
	local mouseRay = camera:ViewportPointToRay(mousePosition.X, mousePosition.Y)

	local raycastResult = workspace:Raycast(mouseRay.Origin, mouseRay.Direction * 1000)

end

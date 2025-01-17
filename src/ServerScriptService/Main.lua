local mob = require(script.Mob)
local tower = require(script.Tower)
local map = workspace.Grassland

for wave=1, 5 do
	print("Wave Starting:", wave)
	mob.Spawn("NPC1", 15, map)
	--mob.Spawn("Green", 5, map)
	
	repeat
		task.wait(0.25)
	until #workspace.Mobs:GetChildren() == 0
	
	if wave > 5 then
		mob.Spawn("Braus", 20, map)
		
	end
end
	print("Wave Ended")

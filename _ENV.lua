getgenv()["EntityOnScreen"] = function(Camera, Entity)
	local Vector, Onscreen = Camera:worldToViewportPoint(Entity:GetPivot().Position)
	return Onscreen
end

getgenv()["DumpTextSize"] = function(Inst)
	if Inst.Size < 8 then
		Inst.Size = 8
	end
	if Inst.Size > 8 then
		Inst.Size = 8
	end
end

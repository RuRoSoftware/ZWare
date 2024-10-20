getgenv()["IsBot"] = function(Entity)
	if Entity.Parent ~= workspace then
		return false
	end
end

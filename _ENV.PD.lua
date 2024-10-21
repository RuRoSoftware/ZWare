getgenv()["IsBot"] = function(Entity)
	if Entity.Parent ~= workspace then
		return true
	end
end

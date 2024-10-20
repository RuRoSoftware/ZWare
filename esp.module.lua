local esp = {}; 
esp.__index = esp

function esp.new(Types, Model)
	local self = setmetatable({}, esp)

	self.name = Drawing.new("Text")
	self.distance = Drawing.new("Text")
	self.model = Model

	if Types ~= "Text" then
		self.box = Drawing.new("Square")
		self.outline = Drawing.new("Square")

		if Types == "Humanoid" then
			self.health_back = Drawing.new("Square")
			self.health = Drawing.new("Square")
			self.health_count = Drawing.new("Text")

			self.health_back.Color = Color3.new(0.113725, 0.113725, 0.113725)
			self.health.Color = Color3.new(0, 1, 0.0313725)
			self.health_count.Color = Color3.new(0, 1, 0.0313725)

			self.health_back.Filled = true
			self.health.Filled = true
		end

		self.box.Color = Color3.new(0, 0, 0)
		self.box.Filled = true

		self.outline.Color = Color3.new(1, 1, 1)
		self.outline.Transparency = 0.65
	end

	self.name.Center = true
	self.name.Outline = true
	self.name.Font = 3

	self.distance.Center = true
	self.distance.Outline = true
	self.distance.Font = 3

	self.name.Color = Color3.new(1, 1, 1)
	self.distance.Color = Color3.new(1, 1, 1)
	return self
end
function esp:Remove()
        self.name:Remove()
        self.distance:Remove()

	if self.box ~= nil then
		self.box:Remove()
        	self.outline:Remove()
	end
        if self.health ~= nil then
            self.health_back:Remove()
            self.health:Remove()
            self.health_count:Remove()
	end
end

return esp

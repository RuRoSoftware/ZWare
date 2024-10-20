local lib = {}
local Mouse = game.Players.LocalPlayer:GetMouse()
local TweenService = game:GetService('TweenService')
local InputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local UIS = game:GetService("UserInputService")
local RenderStepped = RunService.RenderStepped

local function addCorner(frame, size: UDim)
	local UICorner = Instance.new('UICorner',frame)
	UICorner.CornerRadius = size
end

local function addStroker(frame, color: Color3, thickness: number)
	local UIStroke = Instance.new('UIStroke',frame)
	UIStroke.ApplyStrokeMode = "Border"
	UIStroke.Color = color
	UIStroke.Thickness = thickness
end

local function addPadding(frame, Bottom:UDim, Left:UDim, Right:UDim, Top:UDim)
	local UIPadding = Instance.new('UIPadding',frame)
	UIPadding.PaddingBottom = Bottom
	UIPadding.PaddingLeft = Left
	UIPadding.PaddingRight = Right
	UIPadding.PaddingTop = Top
end

local function addListLayout(frame, size:UDim, Alignment:Enum.HorizontalAlignment, FillDirection:Enum.FillDirection)
	local UIListLayout = Instance.new('UIListLayout', frame)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = size
	UIListLayout.FillDirection = FillDirection
	UIListLayout.HorizontalAlignment = Alignment
end

function lib.new(setup: {Name:string, MenuBind: Enum.KeyCode})
	local OpenedTab = nil
	local flags = {}
	local draggbles = {}
	
	local ScreenUI = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
	ScreenUI.ResetOnSpawn = false
	
	local Background = Instance.new('Frame',ScreenUI)
	Background.AnchorPoint = Vector2.new(0.5, 0.5)
	Background.BackgroundColor3 = Color3.new(0.0666667, 0.0666667, 0.0666667)
	Background.BorderSizePixel = 0
	Background.Position = UDim2.new(0.5, 0, 0.5, 0)
	Background.Size = UDim2.new(0, 576, 0, 390)
	Background.Name = 'Background'
	

	local function MakeDraggable(Instance, Cutoff, toggle)
		Instance.Active = true
		draggbles[Instance] = Instance.InputBegan:Connect(function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 then
				local ObjPos = Vector2.new(
					Mouse.X - Instance.AbsolutePosition.X,
					Mouse.Y - Instance.AbsolutePosition.Y
				)

				if ObjPos.Y > (Cutoff or 40) then
					return
				end

				while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
					Instance.Position = UDim2.new(
						0,
						Mouse.X - ObjPos.X + (Instance.Size.X.Offset * Instance.AnchorPoint.X),
						0,
						Mouse.Y - ObjPos.Y + (Instance.Size.Y.Offset * Instance.AnchorPoint.Y)
					)

					RenderStepped:Wait()
				end
			end
		end)
	end
	
	--///
	local Watermark = Instance.new('Frame', ScreenUI)
	Watermark.AutomaticSize = Enum.AutomaticSize.X
	Watermark.BackgroundTransparency = 1
	Watermark.BackgroundColor3 = Color3.new(0.0666667, 0.0666667, 0.0666667)
	Watermark.Position = UDim2.new(0.0172413792, 0, 0.0503685698, 0)
	Watermark.Size = UDim2.new(0, 70, 0, 21)
	Watermark.Name = 'Watermark'
	
	addCorner(Watermark, UDim.new(0, 3))
	
	local WatermarkUIStroke = Instance.new('UIStroke',Watermark)
	WatermarkUIStroke.ApplyStrokeMode = "Border"
	WatermarkUIStroke.Color = Color3.new(0.164706, 0.164706, 0.164706)
	WatermarkUIStroke.Thickness = 0

	local WatermarkTitle = Instance.new('TextLabel',Watermark)
	WatermarkTitle.AutomaticSize = Enum.AutomaticSize.X
	WatermarkTitle.BackgroundTransparency = 1
	WatermarkTitle.TextTransparency = 1
	WatermarkTitle.Size = UDim2.new(0.933333397, 0, 1, 0)
	WatermarkTitle.RichText = true
	WatermarkTitle.FontFace = Font.fromId(12187607287, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	WatermarkTitle.TextSize = 16
	WatermarkTitle.Text = '45'
	WatermarkTitle.TextColor3 = Color3.new(1, 1, 1)
	WatermarkTitle.TextXAlignment = Enum.TextXAlignment.Left

	local UIPadding = Instance.new('UIPadding',WatermarkTitle)
	UIPadding.Name = 'UIPadding'
	UIPadding.PaddingLeft = UDim.new(0, 6)
	--///
	local Notifys = Instance.new('Frame',ScreenUI)
	Notifys.AutomaticSize = Enum.AutomaticSize.X
	Notifys.BackgroundTransparency = 1
	Notifys.Position = UDim2.new(0.355044693, 0, 0.757985234, 0)
	Notifys.Size = UDim2.new(0, 454, 0, 159)
	Notifys.ClipsDescendants = true
	Notifys.Name = 'Notifys'
	
	local NotifysTextLabel = Instance.new('TextLabel', Notifys)
	NotifysTextLabel.BackgroundTransparency = 1
	NotifysTextLabel.Size = UDim2.new(0, 454, 0, 20)
	NotifysTextLabel.FontFace = Font.fromId(12187607287, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	NotifysTextLabel.Text = 'Announcments'
	NotifysTextLabel.TextTransparency = 0
	NotifysTextLabel.TextColor3 = Color3.new(1, 1, 1)
	NotifysTextLabel.TextSize = 23
	
	local NotifysUIStroke = Instance.new('UIStroke', Notifys)
	NotifysUIStroke.ApplyStrokeMode = "Border"
	NotifysUIStroke.Color = Color3.new(0.164706, 0.164706, 0.164706)
	NotifysUIStroke.Thickness = 2.4
	
	
	--//
	
	local Binds = Instance.new("Frame", ScreenUI)
	Binds.Name = "Binds"
	Binds.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	Binds.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Binds.BorderSizePixel = 0
	Binds.Position = UDim2.new(0, 10, 0, 235)
	Binds.Size = UDim2.new(0, 133, 0, 16)
	
	addStroker(Binds, Color3.fromRGB(42, 42, 42), 2.4)
	addCorner(Binds, UDim.new(0, 3))

	local TextLabel = Instance.new("TextLabel", Binds)
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.FontFace = Font.fromId(12187607287, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TextLabel.Text = "Bind menu"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 20.000
	
	local List = Instance.new("Frame", Binds)
	List.Name = "List"
	List.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
	List.BackgroundTransparency = 1
	List.BorderColor3 = Color3.fromRGB(0, 0, 0)
	List.BorderSizePixel = 0
	List.Position = UDim2.new(0, 0, 1.43749905, 0)
	List.Size = UDim2.new(1, 0, 1.0625, 0)

	addCorner(List, UDim.new(0, 3))

	local UIListLayout = Instance.new("UIListLayout", List)
	UIListLayout.Padding = UDim.new(0.2)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	

	MakeDraggable(Binds, 25)
	MakeDraggable(Notifys, 25)
	MakeDraggable(Background, 25)
	MakeDraggable(Watermark, 25)
	
	local Left = Instance.new('Frame',Background)
	Left.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
	Left.Size = UDim2.new(0, 147, 0, 390)
	Left.Name = 'Left'
	
	addCorner(Left, UDim.new(0, 3))
	addStroker(Left, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
	
	local Title = Instance.new('TextLabel',Left)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0, 147, 0, 50)
	Title.ZIndex = 2
	Title.Name = 'Title'
	Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	Title.Text = setup.Name
	Title.TextColor3 = Color3.new(1, 1, 1)
	Title.TextScaled = true
	Title.TextWrapped = true

	local Tabs = Instance.new('ScrollingFrame',Left)
	Tabs.Active = true
	Tabs.BackgroundTransparency = 1
	Tabs.Position = UDim2.new(0, 0, 0.156410262, 0)
	Tabs.Size = UDim2.new(0, 147, 0, 329)
	Tabs.ClipsDescendants = true
	Tabs.Name = 'Tabs'
	Tabs.CanvasSize = UDim2.new(0, 0, 0, 0)
	Tabs.ScrollBarThickness = 0
	
	addPadding(Tabs, UDim.new(0, 0), UDim.new(0, 0), UDim.new(0, 0), UDim.new(0, 5))
	
	local UIGridLayout = Instance.new('UIGridLayout',Tabs)
	UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 10)
	UIGridLayout.CellSize = UDim2.new(1, 0, 0.100000001, 0)
	UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
	
	local Right = Instance.new('Frame',Background)
	Right.BackgroundColor3 = Color3.new(0.0823529, 0.0823529, 0.0823529)
	Right.Position = UDim2.new(0.255208343, 0, 0.00256410264, 0)
	Right.Size = UDim2.new(0, 429, 0, 390)
	Right.Name = 'Right'
	
	addStroker(Right, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
	addCorner(Right, UDim.new(0, 3))
	
	--<pages_folder>
	local pages_folder = Instance.new('Folder',Right)
	pages_folder.Name = 'pages_folder'

	local UIGradient = Instance.new('UIGradient',Title)
	UIGradient.Rotation = 90
	UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),ColorSequenceKeypoint.new(0.432526,Color3.new(1,1,1)),ColorSequenceKeypoint.new(0.448097,Color3.new(0,0.14902,1)),ColorSequenceKeypoint.new(0.477509,Color3.new(0,0.14902,1)),ColorSequenceKeypoint.new(0.581315,Color3.new(0,0.14902,1)),ColorSequenceKeypoint.new(0.638408,Color3.new(0.52549,0,0.00784314)),ColorSequenceKeypoint.new(1,Color3.new(1,0,0)),}

	local lib_functions = {
		change_name = function(name)
			Title.Text = name
		end,
		flags = flags,
		
		createTab = function(setup: {Name:string})
			local page_list = {}
			local opened_page = nil
			
			local Tab = Instance.new('TextButton',Tabs)
			Tab.AutoButtonColor = false
			Tab.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
			Tab.Name = 'Tab'
			Tab.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Tab.Text = setup.Name
			Tab.BorderSizePixel = 0
			Tab.TextColor3 = Color3.new(1, 1, 1)
			Tab.TextSize = 29
			Tab.TextWrapped = true

			local Indicate = Instance.new('Frame',Tab)
			Indicate.Position = UDim2.new(1, -3, 0, 0)
			Indicate.BackgroundTransparency = 1
			Indicate.BorderSizePixel = 0
			Indicate.Size = UDim2.new(0, 2, 0, 34)
			Indicate.Name = 'Indicate'
			
			local Pages = Instance.new('Frame',Right)
			Pages.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
			Pages.Size = UDim2.new(0, 429, 0, 33)
			Pages.Name = 'Pages'
			Pages.Visible = false
			Pages.BorderSizePixel = 0

			local UIGridLayout = Instance.new('UIGridLayout',Pages)
			UIGridLayout.CellSize = UDim2.new(0.300000012, 0, 0.800000012, 0)
			UIGridLayout.FillDirection = Enum.FillDirection.Vertical
			UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Center
			
			local open, close, tab_functions
			
			open = function()
				if OpenedTab then
					OpenedTab.close()
				end
				
				Pages.Visible = true
				
				OpenedTab = tab_functions
				
				if opened_page then
					opened_page.show()
				elseif #page_list > 0 then				
					page_list[1].open()
				end
				
				TweenService:Create(Indicate, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
			end
			
			close = function()
				Pages.Visible = false
				
				for _, page in pairs(page_list) do
					if page == opened_page then
						page.hide()
					end
				end
					
				TweenService:Create(Indicate, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
			end
			
			tab_functions = {
				change_name = function(name)
					Tab.Text = name
				end,
				open = open,
				close = close,
			}
			
			Tab.MouseButton1Click:Connect(open)
			
			tab_functions.createPage = function(setup: {Name:string})
				local page_button = Instance.new('TextButton',Pages)
				page_button.AutoButtonColor = false
				page_button.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
				page_button.Name = 'page_button'
				page_button.Text = setup.Name
				page_button.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				page_button.TextColor3 = Color3.new(1, 1, 1)
				page_button.TextSize = 23
				page_button.BorderSizePixel = 0
				page_button.TextWrapped = true

				local Frame = Instance.new('Frame',page_button)
				Frame.Position = UDim2.new(-1.06704817e-06, 0, 1, 0)
				Frame.BackgroundTransparency = 1
				Frame.BorderSizePixel = 0
				Frame.Size = UDim2.new(1, 0, 0, 2)
				
				local page = Instance.new('ScrollingFrame',pages_folder)
				page.Active = true
				page.BackgroundTransparency = 1
				page.Position = UDim2.new(0.0233100224, 0, 0.102564104, 0)
				page.Size = UDim2.new(0, 411, 0, 343)
				page.ClipsDescendants = true
				page.Name = 'page'
				page.AutomaticCanvasSize = Enum.AutomaticSize.Y
				page.CanvasSize = UDim2.new(0, 0, 0, 0)
				page.ScrollBarImageColor3 = Color3.new(1, 1, 1)
				page.ScrollBarThickness = 2
				page.Visible = false
				
				local left = Instance.new('Frame',page)
				left.AutomaticSize = Enum.AutomaticSize.Y
				left.BackgroundTransparency = 1
				left.Size = UDim2.new(0.5, 0, 1, 0)
				left.Name = 'left'
				
				addPadding(left, UDim.new(0, 5), UDim.new(0, 0), UDim.new(0, 0), UDim.new(0, 5))
				addListLayout(left, UDim.new(0, 8), Enum.HorizontalAlignment.Center, Enum.FillDirection.Vertical)
				
				local right = Instance.new('Frame',page)
				right.AutomaticSize = Enum.AutomaticSize.Y
				right.BackgroundTransparency = 1
				right.Position = UDim2.new(0.5, 0, 0, 0)
				right.Size = UDim2.new(0.5, 0, 1, 0)
				right.Name = 'right'
				
				addPadding(right, UDim.new(0, 5), UDim.new(0, 0), UDim.new(0, 0), UDim.new(0, 5))
				addListLayout(right, UDim.new(0, 8), Enum.HorizontalAlignment.Center, Enum.FillDirection.Vertical)
				
				local open, close, show, hide, page_functions
				
				open = function()
					if opened_page then
						opened_page.close()
					end
					
					opened_page = page_functions
					page.Visible = true
					
					TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
				end
				
				close = function()
					page.Visible = false
					TweenService:Create(Frame, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				end
				
				hide = function()
					page.Visible = false
				end
				
				show = function()
					page.Visible = true
				end
				
				page_button.MouseButton1Click:Connect(open)
				
				page_functions = {
					open = open,
					close = close,
					hide = hide,
					show = show,
				}
				table.insert(page_list, page_functions)
				
				page_functions.createSector = function(setup: {Name:string, Side:string, Description:string})
					local side = setup.Side == "left" and left or right
					
					local frame = Instance.new('Frame', side)
					frame.AutomaticSize = Enum.AutomaticSize.Y
					frame.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
					frame.Position = UDim2.new(0.0352798067, 0, 0, 0)
					frame.Size = UDim2.new(0, 191, 0, 0)
					frame.Name = 'frame'

					addCorner(frame, UDim.new(0, 3))
					addStroker(frame, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
					addListLayout(frame, UDim.new(0, 5), Enum.HorizontalAlignment.Center, Enum.FillDirection.Vertical)
					addPadding(frame, UDim.new(0, 5), UDim.new(0, 0), UDim.new(0, 0), UDim.new(0, 5))
	
					local Title = Instance.new('TextLabel',frame)
					Title.BackgroundTransparency = 1
					Title.Size = UDim2.new(0, 191, 0, 15)
					Title.Name = 'Title'
					Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
					Title.Text = setup.Name
					Title.TextColor3 = Color3.new(1, 1, 1)
					Title.TextSize = 19
					Title.TextWrapped = true
					Title.TextXAlignment = Enum.TextXAlignment.Left
					
					addPadding(Title, UDim.new(0, 0), UDim.new(0, 10), UDim.new(0, 0), UDim.new(0, 0))
					
					local Describe = Instance.new('TextLabel',frame)
					Describe.BackgroundTransparency = 1
					Describe.Position = UDim2.new(0, 0, 0.219999999, 0)
					Describe.Size = UDim2.new(0, 191, 0, 12)
					Describe.Name = 'Describe'
					Describe.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
					Describe.Text = setup.Description
					Describe.TextColor3 = Color3.new(0.32549, 0.32549, 0.32549)
					Describe.TextSize = 19
					Describe.TextWrapped = true
					Describe.TextXAlignment = Enum.TextXAlignment.Left
					
					addPadding(Describe, UDim.new(0, 0), UDim.new(0, 10), UDim.new(0, 0), UDim.new(0, 0))

					local Padding = Instance.new('Frame',frame)
					Padding.BackgroundTransparency = 1
					Padding.Position = UDim2.new(0.0523560196, 0, 0.560606062, 0)
					Padding.Size = UDim2.new(0, 171, 0, 1)
					Padding.Name = 'Padding'
					
					local sector_functions
					
					sector_functions = {}
					
					sector_functions.createButton = function(setup: {Title:string, Flag: string})
						local Button = Instance.new('Frame',frame)
						Button.AutomaticSize = Enum.AutomaticSize.XY
						Button.BackgroundTransparency = 1
						Button.Position = UDim2.new(0.0523560196, 0, 0.9296875, 0)
						Button.Size = UDim2.new(0, 171, 0, 18)
						Button.Name = 'Button'

						local TextButton = Instance.new('TextButton',Button)
						TextButton.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
						TextButton.Position = UDim2.new(0.0116959065, 0, 0, 0)
						TextButton.BackgroundTransparency = 0
						TextButton.Size = UDim2.new(0, 168, 0, 17)
						TextButton.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						TextButton.Text = setup.Title
						TextButton.TextColor3 = Color3.new(1, 1, 1)
						TextButton.TextSize = 19
						
						addStroker(TextButton, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addCorner(TextButton, UDim.new(0, 3))
						
						local event = Instance.new('BindableEvent')
						event.Name = setup.Flag
						
						local SetTitle = function(text: string)
							TweenService:Create(TextButton, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
							task.wait(0.1)
							TextButton.Text = text
							TweenService:Create(TextButton, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
						end
						
						flags[setup.Flag] = {
							CallBack = event.Event,
							SetTitle = SetTitle,
						}
						
						TextButton.MouseButton1Click:Connect(function()
							event:Fire()
						end)
						
						return flags[setup.Flag] :: {CallBack: RBXScriptSignal}
					end
					
					sector_functions.createToggle = function(setup: {Title:string, Flag: string})
						local toggled = false
						local opened_palet = nil
						
						local Toggle = Instance.new('Frame',frame)
						Toggle.BackgroundTransparency = 1
						Toggle.Position = UDim2.new(0.0549738221, 0, 0.627118647, 0)
						Toggle.Size = UDim2.new(0, 171, 0, 22)
						Toggle.Name = 'Toggle'

						local ImageButton = Instance.new('ImageButton',Toggle)
						ImageButton.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
						ImageButton.Position = UDim2.new(0.0116959065, 0, 0.0909090936, 0)
						ImageButton.Size = UDim2.new(0, 15, 0, 15)
						ImageButton.Image = 'rbxassetid://3926305904'
						ImageButton.ImageColor3 = Color3.new(0.156863, 0.156863, 0.156863)
						ImageButton.ImageRectOffset = Vector2.new(312, 4)
						ImageButton.ImageRectSize = Vector2.new(24, 24)	
						
						addStroker(ImageButton, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addCorner(ImageButton, UDim.new(0, 3))

						local Title = Instance.new('TextLabel',Toggle)
						Title.BackgroundTransparency = 1
						Title.Position = UDim2.new(0.152046785, 0, 0, 0)
						Title.Size = UDim2.new(0, 142, 0, 20)
						Title.Name = 'Title'
						Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						Title.Text = setup.Title
						Title.TextColor3 = Color3.new(0.796079, 0.796079, 0.796079)
						Title.TextSize = 20
						Title.TextWrapped = true
						Title.TextXAlignment = Enum.TextXAlignment.Left
						
						--//
						local modules = Instance.new('Frame',Toggle)
						modules.AutomaticSize = Enum.AutomaticSize.Y
						modules.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
						modules.Position = UDim2.new(0.5,1)
						modules.Size = UDim2.new(0, 181, 0, 7)
						modules.Visible = false
						modules.ZIndex = 2
						modules.AnchorPoint = Vector2.new(0.5,0)
						modules.Name = 'modules'

						addStroker(modules, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
						addCorner(modules, UDim.new(0, 3))
						addPadding(modules, UDim.new(0, 3), UDim.new(0, 4), UDim.new(0, 0), UDim.new(0, 3))
						addListLayout(modules, UDim.new(0, 0), Enum.HorizontalAlignment.Right, Enum.FillDirection.Vertical)

						local event = Instance.new('BindableEvent')
						event.Name = setup.Flag
						
						local update = function(value)
							toggled = value
							event:Fire(toggled)
							
							if toggled then
								TweenService:Create(ImageButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(1, 1, 1)}):Play()
							else
								TweenService:Create(ImageButton, TweenInfo.new(0.1), {BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)}):Play()
							end
						end
						
						local SetTitle = function(text: string)
							TweenService:Create(Title, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
							task.wait(0.1)
							Title.Text = text
							TweenService:Create(Title, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
						end
						
						local GetValue = function()
							return toggled
						end
						
						flags[setup.Flag] = {
							CallBack = event.Event,
							SetTitle = SetTitle,
							GetValue = GetValue,
							Update = update,
						}
						
						ImageButton.MouseButton1Click:Connect(function()
							toggled = not toggled
							update(toggled)
						end)
						ImageButton.MouseButton2Click:Connect(function()
							modules.Visible = not modules.Visible
						end)
						
						Mouse.Move:Connect(function()
							local mouser_position = Vector2.new(Mouse.X, Mouse.Y)
							local frame_position = modules.AbsolutePosition + modules.AbsoluteSize
							
							if math.abs(mouser_position.Y - frame_position.Y) - modules.AbsoluteSize.Y/2 > 120 or math.abs(mouser_position.X - frame_position.X) - modules.AbsoluteSize.X/2 > 90 then
								modules.Visible = false
							end
						end)
						
						local toggle_modules = {}
						
						toggle_modules.createBind = function(setup: {Title:string, Flag: string, Mode: string, BindTitle: string})
							
							local Bind = Instance.new('Frame',modules)
							Bind.BackgroundTransparency = 1
							Bind.Position = UDim2.new(0, 0, 0.0330272987, 0)
							Bind.Size = UDim2.new(0, 181, 0, 19)
							Bind.ZIndex = 2
							Bind.Name = 'Bind'

							local Title = Instance.new('TextLabel',Bind)
							Title.BackgroundTransparency = 1
							Title.Position = UDim2.new(0.0331491716, 0, 0, 0)
							Title.Size = UDim2.new(0, 175, 0, 20)
							Title.ZIndex = 2
							Title.Name = 'Title'
							Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
							Title.Text = setup.Title
							Title.TextColor3 = Color3.new(0.796079, 0.796079, 0.796079)
							Title.TextSize = 20
							Title.TextWrapped = true
							Title.TextXAlignment = Enum.TextXAlignment.Left

							local TextButton = Instance.new('TextButton',Bind)
							TextButton.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
							TextButton.Position = UDim2.new(0.633010805, 0, 0.084209241, 0)
							TextButton.Size = UDim2.new(0, 60, 0, 15)
							TextButton.ZIndex = 2
							TextButton.TextSize = 16
							TextButton.Font = Enum.Font.SourceSansBold
							TextButton.Text = 'none'
							TextButton.TextColor3 = Color3.new(1, 1, 1)

							addStroker(TextButton, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
							addCorner(TextButton, UDim.new(0, 3))
							
							--//
							local Bindmodules = Instance.new('Frame',Bind)
							Bindmodules.AutomaticSize = Enum.AutomaticSize.Y
							Bindmodules.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
							Bindmodules.Position = UDim2.new(1, 0, 0.0526315793, 0)
							Bindmodules.Size = UDim2.new(0, 54, 0, 27)
							Bindmodules.Visible = false
							Bindmodules.ZIndex = 4
							Bindmodules.Name = 'Bindmodules'

							addStroker(Bindmodules, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
							addCorner(Bindmodules, UDim.new(0, 3))
							addListLayout(Bindmodules, UDim.new(0, 0), Enum.HorizontalAlignment.Right, Enum.FillDirection.Vertical)

							local ModeButtons = {}
							local Modes = { 'Always', 'Toggle', 'Hold', 'Off' }
							local SelectMode = setup.Mode
							local KeyPicker = ""
							
	
							local TextLabel_2 = Instance.new("TextLabel", List)
							TextLabel_2.Name = "KeyBinderText"
							TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
							TextLabel_2.BorderSizePixel = 0
							TextLabel_2.Text = setup.BindTitle
							TextLabel_2.Visible = false
							TextLabel_2.Size = UDim2.new(0, 133, 0, 17)
							TextLabel_2.FontFace = Font.fromId(12187607287, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
							TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
							TextLabel_2.TextSize = 19.000
							TextLabel_2.Visible = false
							TextLabel_2.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
							TextLabel_2.BackgroundTransparency = 0.450
							TextLabel_2.TextWrapped = true
							
		
							for Idx, Mode in next, Modes do
								local ModeButton = {}

								local ModToggle = Instance.new('TextButton',Bindmodules)
								ModToggle.BackgroundTransparency = 1
								ModToggle.Size = UDim2.new(0, 54, 0, 15)
								ModToggle.ZIndex = 4
								ModToggle.Name = 'ModToggle'
								ModToggle.TextSize = 16
								ModToggle.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
								ModToggle.Text = Mode
								ModToggle.TextColor3 = Color3.new(1, 1, 1)

								function ModeButton:Select()
									for _, Button in next, ModeButtons do
										Button:Deselect()
									end
									SelectMode = Mode
									
									if SelectMode == "Always" then
										toggled = true
										TextLabel_2.Visible = true
										update(toggled)
									elseif SelectMode == "Off" then
										toggled = false
										TextLabel_2.Visible = false
										update(toggled)	
									end
									
									ModToggle.TextColor3 = Color3.fromRGB(102, 102, 102)
									Bindmodules.Visible = false
								end
								
								function ModeButton:Deselect()
									SelectMode = nil
									TextLabel_2.Visible = false
									ModToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
								end
								
								ModToggle.InputBegan:Connect(function(Input)
									if Input.UserInputType == Enum.UserInputType.MouseButton1 then
										ModeButton:Select()
									end
								end)
								
								if Mode == SelectMode then
									ModeButton:Select()
								end;

								ModeButtons[Mode] = ModeButton;
							end;

							
							local event = Instance.new('BindableEvent')
							event.Name = setup.Flag
							
							TextButton.InputBegan:Connect(function(Input)
								if Input.UserInputType == Enum.UserInputType.MouseButton1 then
									TextButton.Text = '...'

									wait(0.2)

									local Event;
									Event = InputService.InputBegan:Connect(function(Input)
										local Key
										if Input.UserInputType == Enum.UserInputType.Keyboard then
											if Input.KeyCode.Name == "Backspace" then
												Key = nil
												TextButton.Text = 'none'
											else
												Key = Input.KeyCode.Name
											end
										elseif Input.UserInputType == Enum.UserInputType.MouseButton1 then
											Key = 'MB1'
										elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
											Key = 'MB2'
										elseif Input.UserInputType == Enum.UserInputType.MouseButton3 then
											Key = 'MB3'
										end
										TextButton.Text = Key or "none"
										KeyPicker = Key
										Event:Disconnect()
									end)
								elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
									Bindmodules.Visible = not Bindmodules.Visible
								end
							end)
							
							InputService.InputBegan:Connect(function(input)
								if SelectMode == "Always" then
									TextLabel_2.Visible = true
									return
								elseif SelectMode == "Off" then
									TextLabel_2.Visible = false
									return
								end
								
								if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == KeyPicker then
									toggled = SelectMode == "Hold" and true or not toggled
									TextLabel_2.Visible = toggled
								elseif input.UserInputType == Enum.UserInputType.MouseButton1 and KeyPicker == "MB1" then
									toggled = SelectMode == "Hold" and true or not toggled
									TextLabel_2.Visible = toggled
								elseif input.UserInputType == Enum.UserInputType.MouseButton2 and KeyPicker == "MB2" then
									toggled = SelectMode == "Hold" and true or not toggled
									TextLabel_2.Visible = toggled
								elseif input.UserInputType == Enum.UserInputType.MouseButton3 and KeyPicker == "MB3" then
									toggled = SelectMode == "Hold" and true or not toggled
									TextLabel_2.Visible = toggled
								else
									TextLabel_2.Visible = false
									return
								end
								
								update(toggled)
							end)
							
							InputService.InputEnded:Connect(function(input)
								if SelectMode == "Hold" and toggled then
									toggled = false
									TextLabel_2.Visible = false
									update(toggled)
								end
							end)
							
							local GetValue = function()
								return {Key = KeyPicker, Mod = SelectMode}
							end
							
							local SetValue = function(setup: {Key: string, Mod: string})
								KeyPicker = setup.Key
								SelectMode = setup.Mod
								
								TextButton.Text = KeyPicker or "none"
							end
							
							flags[setup.Flag] = {
								CallBack = event.Event,
								SetTitle = SetTitle,
								GetValue = GetValue,
								Update = SetValue,
							}							
						end
						
						toggle_modules.createColorPicker = function(setup: {Title:string, Flag: string})
							local ColorPicker = Instance.new('Frame',modules)
							ColorPicker.BackgroundTransparency = 1
							ColorPicker.Position = UDim2.new(0, 0, 0.0330272987, 0)
							ColorPicker.Size = UDim2.new(0, 181, 0, 19)
							ColorPicker.ZIndex = 2
							ColorPicker.Name = 'ColorPicker'

							local Title = Instance.new('TextLabel',ColorPicker)
							Title.BackgroundTransparency = 1
							Title.Position = UDim2.new(0.0331491716, 0, 0, 0)
							Title.Size = UDim2.new(0, 175, 0, 20)
							Title.ZIndex = 2
							Title.Name = 'Title'
							Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
							Title.Text = setup.Title
							Title.TextColor3 = Color3.new(0.796079, 0.796079, 0.796079)
							Title.TextSize = 20
							Title.TextWrapped = true
							Title.TextXAlignment = Enum.TextXAlignment.Left
							
							local Frame = Instance.new('Frame',ColorPicker)
							Frame.BackgroundTransparency = 1
							Frame.Position = UDim2.new(0.329143375, 0, 0, 0)
							Frame.Size = UDim2.new(0, 115, 0, 20)
							Frame.ZIndex = 4
							
							local UIListLayout = Instance.new('UIListLayout',Frame)
							UIListLayout.Padding = UDim.new(0, 3)
							UIListLayout.FillDirection = Enum.FillDirection.Horizontal
							UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
							UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

							local colorpicker_modules = {}
							
							colorpicker_modules.createPicker = function(setup: {Title:string, Flag: string, Color: Color3})
								local Hue, Sat, Vib = setup.Color:ToHSV()
								local color = Color3.fromHSV(Hue, Sat, Vib)
								local value = {
									Sat = Sat,
									Vib = Vib,
									Hue = Hue,
								}
								
								local event = Instance.new('BindableEvent')
								event.Name = setup.Flag
								
								local OpenTextButton = Instance.new('TextButton',Frame)
								OpenTextButton.Size = UDim2.new(0, 17, 0, 13)
								OpenTextButton.ZIndex = 5
								OpenTextButton.AutoButtonColor = false
								OpenTextButton.BackgroundColor3 = color
								OpenTextButton.BorderSizePixel = 0
								OpenTextButton.Text = ''

								local ColorUI = Instance.new('Frame',OpenTextButton)
								ColorUI.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
								ColorUI.Size = UDim2.new(0, 166, 0, 128)
								ColorUI.Visible = false
								ColorUI.ZIndex = 6
								ColorUI.Name = 'ColorUI'
								ColorUI.Position = UDim2.new(0, 0, 0, 25)
								
								addStroker(ColorUI, Color3.new(0.164706, 0.164706, 0.164706), 0.6)
								addCorner(ColorUI, UDim.new(0, 3))

								local ImageButton = Instance.new('ImageButton',ColorUI)
								ImageButton.Position = UDim2.new(0.027285656, 0, 0.0390625, 0)
								ImageButton.Size = UDim2.new(0, 140, 0, 117)
								ImageButton.ZIndex = 6
								ImageButton.AutoButtonColor = false
								ImageButton.Image = 'rbxassetid://4155801252'
								ImageButton.BackgroundColor3 =  setup.Color == Color3.new(1,1,1) and Color3.new(1, 0, 0.0156863) or color
								ImageButton.BorderSizePixel = 1
								ImageButton.BorderColor3 = Color3.fromRGB(0,0,0)
								ImageButton.ImageColor3 = Color3.new(1, 1, 1)

								local TextButton = Instance.new('TextButton',ColorUI)
								TextButton.Position = UDim2.new(0.909638584, 0, 0.046875, 0)
								TextButton.Size = UDim2.new(0, 8, 0, 116)
								TextButton.ZIndex = 6
								TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								TextButton.AutoButtonColor = false
								TextButton.BorderSizePixel = 1
								TextButton.BorderColor3 = Color3.fromRGB(0,0,0)
								TextButton.Text = ''
								
								local SequenceTable = {};

								for Hue = 0, 1, 0.1 do
									table.insert(SequenceTable, ColorSequenceKeypoint.new(Hue, Color3.fromHSV(Hue, 1, 1)));
								end;
								
								local UIGradient = Instance.new('UIGradient',TextButton)
								UIGradient.Color = ColorSequence.new(SequenceTable)
								UIGradient.Rotation = 90
								
								local function update(color)
									event:Fire(color)
								end
								
								ImageButton.InputBegan:Connect(function(Input)
									if Input.UserInputType == Enum.UserInputType.MouseButton1 then
										while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
											local MinX = ImageButton.AbsolutePosition.X
											local MaxX = MinX + ImageButton.AbsoluteSize.X
											local MouseX = math.clamp(Mouse.X, MinX, MaxX)

											local MinY = ImageButton.AbsolutePosition.Y
											local MaxY = MinY + ImageButton.AbsoluteSize.Y
											local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

											value.Sat = (MouseX - MinX) / (MaxX - MinX)
											value.Vib = 1 - ((MouseY - MinY) / (MaxY - MinY))
								
											color = Color3.fromHSV(value.Hue, value.Sat, value.Vib)
											OpenTextButton.BackgroundColor3 = color
											
											update(color)

											RenderStepped:Wait()
										end
									end
								end)
								
								OpenTextButton.MouseButton1Click:Connect(function()
									if opened_palet and opened_palet ~= ColorUI then
										opened_palet.Visible = false
									end
									opened_palet = ColorUI
									ColorUI.Visible = not ColorUI.Visible						
								end)
								
								TextButton.InputBegan:Connect(function(Input)
									if Input.UserInputType == Enum.UserInputType.MouseButton1 then
										while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
											local MinY = TextButton.AbsolutePosition.Y
											local MaxY = MinY + TextButton.AbsoluteSize.Y
											local MouseY = math.clamp(Mouse.Y, MinY, MaxY)

											value.Hue = ((MouseY - MinY) / (MaxY - MinY))
											color = Color3.fromHSV(value.Hue, value.Sat, value.Vib)
											ImageButton.BackgroundColor3 = Color3.fromHSV(value.Hue,1,1)
											
											update(color)

											RenderStepped:Wait()
										end
									end
								end)

								flags[setup.Flag] = {
									CallBack = event.Event,
									Update = function(Color: Color3)
										print(Color)
										local Hue, Sat, Vib = Color:ToHSV()
										value = {
											Sat = Sat,
											Vib = Vib,
											Hue = Hue,
										}
										
										color = Color3.fromHSV(value.Hue, value.Sat, value.Vib)
										ImageButton.BackgroundColor3 = Color3.fromHSV(value.Hue,1,1)
										OpenTextButton.BackgroundColor3 = color
										
										update(color)
									end,
									GetValue = function()
										return value
									end,
								}		
	
								
							end
							return colorpicker_modules
						end
						return toggle_modules
					end
					
					sector_functions.createText = function(setup: {Title:string, Flag: string})
						
						local Text = Instance.new('Frame',frame)
						Text.AutomaticSize = Enum.AutomaticSize.XY
						Text.BackgroundTransparency = 1
						Text.Position = UDim2.new(0.0523560196, 0, 0.359259248, 0)
						Text.Size = UDim2.new(0, 171, 0, 19)
						Text.Name = 'Text'

						local TextLabel = Instance.new('TextLabel',Text)
						TextLabel.AutomaticSize = Enum.AutomaticSize.XY
						TextLabel.BackgroundTransparency = 1
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.RichText = true
						TextLabel.Text = setup.Title
						TextLabel.TextColor3 = Color3.new(1, 1, 1)
						TextLabel.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						TextLabel.TextSize = 27
						TextLabel.TextWrapped = true
						
						addStroker(TextLabel, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addCorner(TextLabel, UDim.new(0, 3))
						addPadding(Text, UDim.new(0, 5), UDim.new(0, 0), UDim.new(0, 0), UDim.new(0, 5))
						
						local SetTitle = function(text: string)
							TextLabel.Text = text
						end
						
						flags[setup.Flag] = {
							SetTitle = SetTitle,
						}	
					end
					
					sector_functions.createTextBox = function(setup: {Title:string, Flag: string})
						
						local TextBox = Instance.new('Frame', frame)
						TextBox.AutomaticSize = Enum.AutomaticSize.Y
						TextBox.BackgroundTransparency = 1
						TextBox.Position = UDim2.new(0.062827222, 0, 0.734375, 0)
						TextBox.Size = UDim2.new(0, 168, 0, 45)
						TextBox.Name = 'TextBox'

						addListLayout(TextBox, UDim.new(0, 4), Enum.HorizontalAlignment.Left, Enum.FillDirection.Vertical)


						local Title = Instance.new('TextLabel',TextBox)
						Title.BackgroundTransparency = 1
						Title.Size = UDim2.new(0, 171, 0, 13)
						Title.Name = 'Title'
						Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						Title.Text = setup.Title
						Title.TextColor3 = Color3.new(0.796079, 0.796079, 0.796079)
						Title.TextSize = 20
						Title.TextXAlignment = Enum.TextXAlignment.Left

						local TextBox = Instance.new('TextBox',TextBox)
						TextBox.Active = true
						TextBox.AutomaticSize = Enum.AutomaticSize.Y
						TextBox.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
						TextBox.Position = UDim2.new(0, 0, 0.400000006, 0)
						TextBox.Size = UDim2.new(0, 169, 0, 21)
						TextBox.PlaceholderColor3 = Color3.new(0.7, 0.7, 0.7)
						TextBox.PlaceholderText = 'Text'
						TextBox.RichText = true
						TextBox.ClearTextOnFocus = false
						TextBox.Text = ''
						TextBox.TextColor3 = Color3.new(1, 1, 1)
						TextBox.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						TextBox.TextSize = 20
						TextBox.TextWrapped = true
						TextBox.TextXAlignment = Enum.TextXAlignment.Left

						addStroker(TextBox, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addCorner(TextBox, UDim.new(0, 3))
						addPadding(TextBox, UDim.new(0, 0), UDim.new(0, 4), UDim.new(0, 0), UDim.new(0, 0))

						local event = Instance.new('BindableEvent')
						event.Name = setup.Flag

						local SetTitle = function(text: string)
							Title.Text = text
						end
						
						local SetValue = function(text: string)
							TextBox.Text = text
						end
						
						local GetValue = function()
							return TextBox.Text
						end
						
						TextBox.InputEnded:Connect(function()
							event:Fire(TextBox.Text)
						end)
						
						flags[setup.Flag] = {
							CallBack = event.Event,
							SetTitle = SetTitle,
							GetValue = GetValue,
							Update = SetValue,
						}	
					end
					
					sector_functions.createSlider = function(setup: {Title: string, Min: string, Default: string, Max: string, Rounding: string, Flag: string})
						local Values = {
							Min = setup.Min,
							Max = setup.Max,
							Value = setup.Default,
							Rounding = setup.Rounding,
						}
						
						local Slider = Instance.new('Frame', frame)
						Slider.BackgroundTransparency = 1
						Slider.Position = UDim2.new(0.0549738221, 0, 0.627118647, 0)
						Slider.Size = UDim2.new(0, 171, 0, 22)
						Slider.Name = 'Slider'

						local Slide = Instance.new('Frame',Slider)
						Slide.AnchorPoint = Vector2.new(0.5, 0.5)
						Slide.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
						Slide.Position = UDim2.new(0.649999976, 0, 0.5, 0)
						Slide.Size = UDim2.new(0.649999976, 0, 0.150000006, 0)
						Slide.Name = 'Slide'
						Slide.ClipsDescendants = false
						
						local fill = Instance.new("Frame", Slide)
						fill.Transparency = 1
						fill.Size = UDim2.new(0,0,1,0)
						
						addStroker(Slide, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addCorner(Slide, UDim.new(0, 16))

						local button = Instance.new('TextButton',Slide)
						button.AnchorPoint = Vector2.new(0.5, 0.5)
						button.AutomaticSize = Enum.AutomaticSize.X
						button.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
						button.Position = UDim2.new(0, 0, 0.5, 0)
						button.Size = UDim2.new(0, 0, 0, 15)
						button.Name = 'button'
						button.Text = '1'
						button.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						button.TextColor3 = Color3.new(1, 1, 1)
						button.TextSize = 17
						button.TextWrapped = true

						addStroker(button, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addCorner(button, UDim.new(0, 16))
						addPadding(button, UDim.new(0, 0), UDim.new(0, 5), UDim.new(0, 5), UDim.new(0, 0))

						local Title = Instance.new('TextLabel',Slider)
						Title.BackgroundTransparency = 1
						Title.Size = UDim2.new(0, 60, 0, 20)
						Title.Name = 'Title'
						Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						Title.Text = setup.Title
						Title.TextColor3 = Color3.new(0.796079, 0.796079, 0.796079)
						Title.TextSize = 20
						Title.TextWrapped = true
						Title.TextXAlignment = Enum.TextXAlignment.Left
						
						local event = Instance.new('BindableEvent')
						event.Name = setup.Flag


						local function Round(Value)
							if Values.Rounding == 0 then
								return math.floor(Value)
							end
							
							return tonumber(string.format('%.' .. Values.Rounding .. 'f', Value))
						end
						
						local function MapValue(Value, MinA, MaxA, MinB, MaxB)
							return (1 - ((Value - MinA) / (MaxA - MinA))) * MinB + ((Value - MinA) / (MaxA - MinA)) * MaxB
						end
						
						local function GetValueFromXOffset(X)
							return Round(MapValue(X, 0, Slide.AbsoluteSize.X, Values.Min, Values.Max))
						end
						
						local event = Instance.new('BindableEvent')
						event.Name = setup.Flag
						
						local X = math.ceil(MapValue(Values.Value, Values.Min, Values.Max, 0, Slide.AbsoluteSize.X))
						fill.Size = UDim2.new(0, X, 1, 0)
						button.Position = UDim2.new(0,fill.Size.X.Offset,0.5,0)

						button.Text = Values.Value
						
						button.InputBegan:Connect(function(Input)
							if Input.UserInputType == Enum.UserInputType.MouseButton1 then
								local mPos = Mouse.X;
								local gPos = fill.Size.X.Offset;
								local Diff = mPos - (fill.AbsolutePosition.X + gPos);
								
								while InputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
									local nMPos = Mouse.X
									local nX = math.clamp(gPos + (nMPos - mPos) + Diff, 0, Slide.AbsoluteSize.X)

									local nValue = GetValueFromXOffset(nX)
									local OldValue = Values.Value
									Values.Value = nValue

									local X = math.ceil(MapValue(Values.Value, Values.Min, Values.Max, 0, Slide.AbsoluteSize.X))
									fill.Size = UDim2.new(0, X, 1, 0)
									button.Position = UDim2.new(0,fill.Size.X.Offset,0.5,0)
									
									button.Text = Values.Value
									
									if nValue ~= OldValue then
										event:Fire(Values.Value)
									end;

									RenderStepped:Wait()
								end
							end
						end)
						
						local SetTitle = function(text: string)
							Title.Text = text
						end

						local SetValue = function(value: string)
							Values.Value = value
							
							local X = math.ceil(MapValue(Values.Value, Values.Min, Values.Max, 0, Slide.AbsoluteSize.X))
							fill.Size = UDim2.new(0, X, 1, 0)
							button.Position = UDim2.new(0,fill.Size.X.Offset,0.5,0)

							button.Text = Values.Value
							event:Fire(Values.Value)
						end

						local GetValue = function()
							return Values.Value
						end
						
						flags[setup.Flag] = {
							CallBack = event.Event,
							SetTitle = SetTitle,
							GetValue = GetValue,
							Update = SetValue,
						}
						
					end
					
					sector_functions.createDropBox = function(drop_setup: {Title:string, Flag: string, Multiple: boolean})
						local active_buttons = {}

						local DropBox = Instance.new('Frame',frame)
						DropBox.BackgroundTransparency = 1
						DropBox.Position = UDim2.new(0.0523560196, 0, 0.552941203, 0)
						DropBox.Size = UDim2.new(0, 171, 0, 44)
						DropBox.Name = 'DropBox'

						local Title = Instance.new('TextLabel',DropBox)
						Title.BackgroundTransparency = 1
						Title.Position = UDim2.new(0, 0, 0.100000001, 0)
						Title.Size = UDim2.new(0, 171, 0, 13)
						Title.Name = 'Title'
						Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						Title.Text = drop_setup.Title
						Title.TextColor3 = Color3.new(0.796079, 0.796079, 0.796079)
						Title.TextSize = 20
						Title.TextWrapped = true
						Title.TextXAlignment = Enum.TextXAlignment.Left

						local DBoxFrame = Instance.new('Frame',DropBox)
						DBoxFrame.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
						DBoxFrame.Position = UDim2.new(0.0116959065, 0, 0.474999994, 0)
						DBoxFrame.Size = UDim2.new(0, 169, 0, 20)
						DBoxFrame.Name = 'DBoxFrame'

						addCorner(DBoxFrame, UDim.new(0,3))
						addStroker(DBoxFrame, Color3.new(0.458824, 0.458824, 0.458824), 0.6)

						local Title = Instance.new('TextLabel',DBoxFrame)
						Title.BackgroundTransparency = 1
						Title.Position = UDim2.new(0.035502959, 0, 0, 0)
						Title.Size = UDim2.new(0, 163, 0, 20)
						Title.Name = 'Title'
						Title.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
						Title.Text = '--'
						Title.TextColor3 = Color3.new(1, 1, 1)
						Title.TextWrapped = true
						Title.TextSize = 17
						Title.TextXAlignment = Enum.TextXAlignment.Left
						Title.MaxVisibleGraphemes = 35

						local ImageLabel = Instance.new('ImageLabel',DBoxFrame)
						ImageLabel.BackgroundTransparency = 1
						ImageLabel.Position = UDim2.new(0.899408281, 0, 0.200000003, 0)
						ImageLabel.Size = UDim2.new(0, 12, 0, 12)
						ImageLabel.Name = 'ImageLabel'
						ImageLabel.Image = 'rbxassetid://16368985219'
						ImageLabel.ImageColor3 = Color3.new(1, 1, 1)

						local ScrollingFrame = Instance.new('ScrollingFrame',DropBox)
						ScrollingFrame.Active = true
						ScrollingFrame.BackgroundColor3 = Color3.new(0.0941176, 0.0941176, 0.0941176)
						ScrollingFrame.Position = UDim2.new(0.0120000001, 0, 1, 0)
						ScrollingFrame.Size = UDim2.new(0, 169, 0, 0)
						ScrollingFrame.Visible = false
						ScrollingFrame.ZIndex = 2
						ScrollingFrame.AutomaticSize = Enum.AutomaticSize.Y
						ScrollingFrame.ClipsDescendants = true
						ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
						ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
						ScrollingFrame.ScrollBarImageColor3 = Color3.new(1, 1, 1)
						ScrollingFrame.ScrollBarThickness = 4

						addCorner(ScrollingFrame, UDim.new(0,3))
						addListLayout(ScrollingFrame, UDim.new(0, 5), Enum.HorizontalAlignment.Left, Enum.FillDirection.Vertical)
						addStroker(ScrollingFrame, Color3.new(0.458824, 0.458824, 0.458824), 0.6)
						addPadding(ScrollingFrame, UDim.new(0, 5), UDim.new(0, 5), UDim.new(0,0), UDim.new(0, 5))

						local TextButton = Instance.new('TextButton',DropBox)
						TextButton.BackgroundTransparency = 1
						TextButton.Position = UDim2.new(0.0116959065, 0, 0.47500056, 0)
						TextButton.Size = UDim2.new(0, 170, 0, 19)
						TextButton.ZIndex = 3
						TextButton.Text = ''

						Mouse.Move:Connect(function()
							local mouser_position = Vector2.new(Mouse.X, Mouse.Y)
							local frame_position = ScrollingFrame.AbsolutePosition + ScrollingFrame.AbsoluteSize/2

							if math.abs(mouser_position.Y - frame_position.Y) - ScrollingFrame.AbsoluteSize.Y/2 > 50 or math.abs(mouser_position.X - frame_position.X) - ScrollingFrame.AbsoluteSize.X/2 > 50 then
								ScrollingFrame.Visible = false
								ImageLabel.Rotation = 0
							end
						end)

						TextButton.MouseButton1Click:Connect(function()
							ScrollingFrame.Visible = not ScrollingFrame.Visible

							if ScrollingFrame.Visible then
								ImageLabel.Rotation = 180
							else
								ImageLabel.Rotation = 0
							end
						end)

						local event = Instance.new('BindableEvent')

						local drop_box_functions = {}

						local function update()
							local gen_str = ""
							for _, str in pairs(active_buttons) do
								gen_str = gen_str .. str .. " "
							end

							if gen_str == "" then
								Title.Text = "---"
							else
								Title.Text = gen_str
							end
						end

						function drop_box_functions.createButton(setup: {Title: string, Default: boolean, Flag: string})
							local TextButton = Instance.new('TextButton',ScrollingFrame)
							TextButton.BackgroundTransparency = 1
							TextButton.Size = UDim2.new(0, 169, 0, 16)
							TextButton.ZIndex = 3
							TextButton.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
							TextButton.Text = setup.Title
							TextButton.Name = setup.Title
							TextButton.TextColor3 = setup.Default and Color3.new(1, 1, 1) or Color3.new(0.611765, 0.611765, 0.611765)
							TextButton.TextSize = 16
							TextButton.TextXAlignment = Enum.TextXAlignment.Left

							TextButton.MouseButton1Click:Connect(function()
								if active_buttons[setup.Title] then
									TextButton.TextColor3 =  Color3.new(0.611765, 0.611765, 0.611765)
									active_buttons[setup.Title] = nil
								else
									if not drop_setup.Multiple then
										for id,_ in pairs(active_buttons) do
											active_buttons[id] = nil
											ScrollingFrame[id].TextColor3 = Color3.new(0.611765, 0.611765, 0.611765)
										end
									end
									TextButton.TextColor3 =  Color3.new(1,1,1)
									active_buttons[setup.Title] = setup.Title
								end

								local gen_table = {}
								for _,title in pairs(active_buttons) do
									table.insert(gen_table, title)
								end
								event:Fire(gen_table)
								update()
							end)

							flags[setup.Flag] = {
								GetValue = function()
									local id = active_buttons[setup.Title]
									if id then
										return true
									else
										return false
									end
								end,
								Update = function(value: boolean)

									if active_buttons[setup.Title] and not value then
										active_buttons[setup.Title] = nil
									elseif not active_buttons[setup.Title] and value then
										active_buttons[setup.Title] = setup.Title
									end

									update()
									local gen_table = {}
									for _,title in pairs(active_buttons) do
										table.insert(gen_table, title)
									end
									event:Fire(gen_table)
								end,
								Remove = function()
									local id = table.find(active_buttons, setup.Title)
									if id then
										active_buttons[id] = nil
									end

									flags[setup.Flag] = nil
									TextButton:Remove()
								end,
							}

							if setup.Default then
								table.insert(active_buttons, setup.Title)
								update()
								event:Fire(active_buttons)
							end
						end

						flags[drop_setup.Flag] = {
							CallBack = event.Event,
							GetValue = function()
								local gen_table = {}
								for _,title in pairs(active_buttons) do
									table.insert(gen_table, title)
								end

								return gen_table
							end,
							Update = function(buttons: {})
								active_buttons = buttons
								update()
								event:Fire(active_buttons)
							end,
						}
						return drop_box_functions
					end
					return sector_functions
				end
				return page_functions
			end
			return tab_functions
		end,
		
		
		Notify = function(setup: {Tittle: string, Time: string})

			for i,v in pairs(Notifys:GetChildren()) do
				spawn(function()
					if v.ClassName == "Frame" then
						v.Position += UDim2.new(0, 0, 0, 25)
					end
				end)
			end

			local Notify = Instance.new('Frame',Notifys)
			Notify.AutomaticSize = Enum.AutomaticSize.X
			Notify.BackgroundColor3 = Color3.new(0.0666667, 0.0666667, 0.0666667)
			Notify.Position = UDim2.new(0, -105, 0, 0)
			Notify.Size = UDim2.new(0, 101, 0, 20)
			Notify.Name = 'Notify'

			addCorner(Notify, UDim.new(0, 3))

			local NotifyUIStroke = Instance.new('UIStroke',Notify)
			NotifyUIStroke.ApplyStrokeMode = "Border"
			NotifyUIStroke.Color = Color3.new(0.164706, 0.164706, 0.164706)
			NotifyUIStroke.Thickness = 2.4
			
			local NotifyTittle = Instance.new('TextLabel',Notify)
			NotifyTittle.AutomaticSize = Enum.AutomaticSize.X
			NotifyTittle.BackgroundTransparency = 1
			NotifyTittle.Size = UDim2.new(0, 100, 0, 20)
			NotifyTittle.Name = 'NotifyTittle'
			NotifyTittle.FontFace = Font.fromId(12187607287, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			NotifyTittle.Text = setup.Tittle
			NotifyTittle.TextSize = 16
			NotifyTittle.TextColor3 = Color3.new(1, 1, 1)
			NotifyTittle.TextXAlignment = Enum.TextXAlignment.Left

			local NotifyUIPadding = Instance.new('UIPadding',NotifyTittle)
			NotifyUIPadding.Name = 'UIPadding'
			NotifyUIPadding.PaddingLeft = UDim.new(0, 6)
			
			TweenService:Create(Notify, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {Position = Notify.Position + UDim2.new(0, 108, 0, 0)}):Play();
			
			wait(setup.Time)
			TweenService:Create(Notify, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {BackgroundTransparency = 1}):Play();
			TweenService:Create(NotifyTittle, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {TextTransparency = 1}):Play();
			TweenService:Create(NotifyUIStroke, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {Thickness = 0}):Play();
			wait(0.25)
			Notify:Remove()
	
		end,

		SetWatermark = function(setup: {Tittle: string, Visible: string})
			TweenService:Create(Watermark, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {BackgroundTransparency = setup.Visible and 0 or 1}):Play();
			TweenService:Create(WatermarkTitle, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {TextTransparency = setup.Visible and 0 or 1}):Play();
			TweenService:Create(WatermarkUIStroke, TweenInfo.new(0.25, Enum.EasingStyle["Linear"], Enum.EasingDirection["In"]), {Thickness = setup.Visible and 2.4 or 0}):Play();
			WatermarkTitle.Text = setup.Tittle
		end,
		SetKeyBind = function(setup: {Visible: string})
			Binds.Visible = setup.Visible
		end,
		
		HideMenu = function()
			Background.Visible = not Background.Visible
			if Background.Visible then NotifysTextLabel.TextTransparency = 0 else NotifysTextLabel.TextTransparency = 1 end
			if Background.Visible then NotifysUIStroke.Thickness = 2.4 else NotifysUIStroke.Thickness = 0 end
		end,
		InputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == "Insert" then
				Background.Visible = not Background.Visible
				
				if Background.Visible then
					NotifysTextLabel.TextTransparency = 0 
				else 
					NotifysTextLabel.TextTransparency = 1
				end
				
				if Background.Visible then
					NotifysUIStroke.Thickness = 2.4 
				else 
					NotifysUIStroke.Thickness = 0 
				end
				
				if not Background.Visible then
					draggbles[Notifys]:Disconnect()
					draggbles[Binds]:Disconnect()
				else
					MakeDraggable(Notifys, 25)
					MakeDraggable(Binds, 25)
				end
			end
		end)
		
	
	}
	return lib_functions
end
return lib

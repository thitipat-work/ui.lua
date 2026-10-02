local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

local localPlayer = game:GetService("Players").LocalPlayer
local configFileName = localPlayer.Name .. ".Json"

local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
gethui = gethui or function()
	return CoreGui
end

local currentCamera = workspace.CurrentCamera
local mouse = localPlayer:GetMouse()
local touchEnabled = UserInputService.TouchEnabled or false

local index3 = {
	Theme = {}, MenuKeybind = tostring(Enum.KeyCode.RightControl), Flags = {},
	Tween = {
		Time = 0.3, Style = Enum.EasingStyle.Quad, Direction = Enum.EasingDirection.Out,
	},
	FadeSpeed = 0.2,
	Folders = {
		Directory = "AnimeMysteriousScript", Configs = "AnimeMysteriousScript/Configs",
	},
	Pages = {}, Sections = {}, Connections = {}, Threads = {}, ThemeMap = {}, ThemeItems = {}, OpenFrames = {}, SetFlags = {},
	UnnamedConnections = 0, UnnamedFlags = 0, Holder = nil, NotifHolder = nil, UnusedHolder = nil, Font = nil,
}

index3.__index = index3
index3.Sections.__index = index3.Sections
index3.Pages.__index = index3.Pages

local keyNames = {
	Unknown = "Unknown", Backspace = "Back", Tab = "Tab", Clear = "Clear", Return = "Return", Pause = "Pause", Escape = "Escape",
	Space = "Space", QuotedDouble = "\"", Hash = "#", Dollar = "$", Percent = "%", Ampersand = "&", Quote = "'", LeftParenthesis = "(",
	RightParenthesis = " )", Asterisk = "*", Plus = "+", Comma = ",", Minus = "-", Period = ".", Slash = "`", Three = "3", Seven = "7",
	Eight = "8", Colon = ":", Semicolon = ";", LessThan = "<", GreaterThan = ">", Question = "?", Equals = "=", At = "@",
	LeftBracket = "LeftBracket", RightBracket = "RightBracked", BackSlash = "BackSlash", Caret = "^", Underscore = "_", Backquote = "`",
	LeftCurly = "{", Pipe = "|", RightCurly = "}", Tilde = "~", Delete = "Delete", End = "End", KeypadZero = "Keypad0",
	KeypadOne = "Keypad1", KeypadTwo = "Keypad2", KeypadThree = "Keypad3", KeypadFour = "Keypad4", KeypadFive = "Keypad5",
	KeypadSix = "Keypad6", KeypadSeven = "Keypad7", KeypadEight = "Keypad8", KeypadNine = "Keypad9", KeypadPeriod = "Keypad.",
	KeypadDivide = "Keypad/", KeypadMultiply = "KeypadM", KeypadMinus = "KeypadM", KeypadPlus = "KeypadP", KeypadEnter = "KeypadE",
	KeypadEquals = "KeypadE", Insert = "Insert", Home = "Home", PageUp = "PageUp", PageDown = "PageDown", RightShift = "RightShift",
	LeftShift = "LeftShift", RightControl = "RightControl", LeftControl = "LeftControl", LeftAlt = "LeftAlt", RightAlt = "RightAlt",
}

index3.Theme = table.clone(({
	Preset = {
		AccentGradient = Color3.fromRGB(183, 115, 115), ["Background 2"] = Color3.fromRGB(10, 10, 12),
		Background = Color3.fromRGB(12, 12, 14), Text = Color3.fromRGB(235, 235, 235), Outline = Color3.fromRGB(25, 25, 28),
		["Section Top"] = Color3.fromRGB(28, 26, 32), ["Section Background"] = Color3.fromRGB(10, 10, 12),
		["Section Background 2"] = Color3.fromRGB(14, 14, 16), Accent = Color3.fromRGB(255, 0, 0), Element = Color3.fromRGB(16, 16, 18),
	},
	}).Preset)
for _, v78 in index3.Folders do
	if not isfolder(v78) then
		makefolder(v78)
	end
end

local index4 = {}
index4.__index = index4

index4.Create = function(arg, arg2, arg3, arg4, arg5)
	local instance = arg5 and arg2 or arg2.Instance
	arg3 = arg3 or TweenInfo.new(index3.Tween.Time, index3.Tween.Style, index3.Tween.Direction)
	local t18 = { Tween = TweenService:Create(instance, arg3, arg4), Info = arg3, Goal = arg4, Item = instance }
	t18.Tween:Play()
	setmetatable(t18, index4)
	return t18
end

index4.GetProperty = function(arg, arg2)
	local item = arg2 or arg.Item
	if item:IsA("Frame") then
		return { "BackgroundTransparency" }
	end
	if item:IsA("TextLabel") or item:IsA("TextButton") then
		return { "TextTransparency", "BackgroundTransparency" }
	end
	if item:IsA("ImageLabel") or item:IsA("ImageButton") then
		return { "BackgroundTransparency", "ImageTransparency" }
	end
	if item:IsA("ScrollingFrame") then
		return { "BackgroundTransparency", "ScrollBarImageTransparency" }
	end
	if item:IsA("TextBox") then
		return { "TextTransparency", "BackgroundTransparency" }
	end
	if item:IsA("UIStroke") then
		return { "Transparency" }
	end
end

index4.FadeItem = function(arg, arg2, arg3, arg4, arg5)
	local item = arg2 or arg.Item
	local v78 = item[arg3]
	item[arg3] = arg4 and 1 or v78
	local v79 = index4
	local create = v79.Create
	local tweenInfo = TweenInfo.new(arg5 or index3.Tween.Time, index3.Tween.Style, index3.Tween.Direction)
	local t18 = {}
	t18[arg3] = arg4 and v78 or 1
	local v80 = create(v79, item, tweenInfo, t18, true)
	index3:Connect(v80.Tween.Completed, function()
		if not arg4 then
			task.wait()
			item[arg3] = v78
		end
	end)
	return v80
end

index4.Get = function(arg)
	if not arg.Tween then
		return
	end
	return arg.Tween, arg.Info, arg.Goal
end

index4.Pause = function(arg)
	if not arg.Tween then
		return
	end
	arg.Tween:Pause()
end

index4.Play = function(arg)
	if not arg.Tween then
		return
	end
	arg.Tween:Play()
end

index4.Clean = function(arg)
	if not arg.Tween then
		return
	end
	index4:Pause()
end

local index5 = {}
index5.__index = index5

index5.Create = function(arg, arg2, arg3)
	local t18 = { Instance = Instance.new(arg2), Properties = arg3, Class = arg2 }
	setmetatable(t18, index5)
	local instance = t18.Instance
	instance.Name = "\0"
	if instance:IsA("GuiObject") then
		instance.BorderSizePixel = 0
		instance.BorderColor3 = Color3.fromRGB(0, 0, 0)
		instance.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	end
	for k_, v78 in t18.Properties do
		instance[k_] = v78
	end
	return t18
end

index5.FadeItem = function(arg, arg2, arg3)
	local instance = arg.Instance
	if arg2 == true then
		instance.Visible = true
	end
	local descendants = instance:GetDescendants()
	table.insert(descendants, instance)
	for _, v78 in descendants do
		local property = index4:GetProperty(v78)
		if property then
			if type(property) == "table" then
				for _, v79 in property do
					index4:FadeItem(v78, v79, not arg2, arg3)
				end
			else
				index4:FadeItem(v78, property, not arg2, arg3)
			end
		end
	end
end

index5.AddToTheme = function(arg, arg2)
	if not arg.Instance then
		return
	end
	index3:AddToTheme(arg, arg2)
end

index5.ChangeItemTheme = function(arg, arg2)
	if not arg.Instance then
		return
	end
	index3:ChangeItemTheme(arg, arg2)
end

index5.Connect = function(arg, arg2, arg3, arg4)
	if not arg.Instance then
		return
	end
	if arg2 == "MouseButton1Down" or arg2 == "MouseButton1Click" then
		if arg.Instance:IsA("GuiButton") then
			arg2 = "Activated"
		elseif touchEnabled then
			return index3:Connect(arg.Instance.InputBegan, function(arg5)
				if arg5.UserInputType == Enum.UserInputType.MouseButton1 or arg5.UserInputType == Enum.UserInputType.Touch then
					arg3(arg5)
				end
				end, arg4)
		end
	elseif arg2 == "MouseButton1Click" or arg2 == "MouseButton2Click" then
		if touchEnabled then
			arg2 = "TouchLongPress"
		end
	end
	if not arg.Instance[arg2] then
		return
	end
	return index3:Connect(arg.Instance[arg2], arg3, arg4)
end

index5.Tween = function(arg, arg2, arg3)
	if not arg.Instance then
		return
	end
	return index4:Create(arg, arg2, arg3)
end

index5.Disconnect = function(arg, arg2)
	if not arg.Instance then
		return
	end
	return index3:Disconnect(arg2)
end

index5.Clean = function(arg)
	if not arg.Instance then
		return
	end
	arg.Instance:Destroy()
end

index5.MakeDraggable = function(arg)
	if not arg.Instance then
		return
	end
	local instance = arg.Instance
	local b15 = false
	local position = nil
	local position2 = nil
	local function f27(arg2)
		local n = arg2.Position - position
		local n32 = position2.X.Offset + n.X
		local n33 = position2.Y.Offset + n.Y
		local absoluteSize = instance.Parent.AbsoluteSize
		local absoluteSize2 = instance.AbsoluteSize
		local v78 = math.clamp(n32, 0, absoluteSize.X - absoluteSize2.X)
		local v79 = math.clamp(n33, 0, absoluteSize.Y - absoluteSize2.Y)
		arg:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, v78, 0, v79) })
	end
	local connection = nil
	arg:Connect("InputBegan", function(arg2)
		if arg2.UserInputType == Enum.UserInputType.MouseButton1 or arg2.UserInputType == Enum.UserInputType.Touch then
			b15 = true
			position = arg2.Position
			position2 = instance.Position
			if connection then
				return
			end
			connection = arg2.Changed:Connect(function()
				if arg2.UserInputState == Enum.UserInputState.End then
					b15 = false
					connection:Disconnect()
					connection = nil
				end
			end)
		end
	end)
	index3:Connect(UserInputService.InputChanged, function(arg2)
		if arg2.UserInputType == Enum.UserInputType.MouseMovement or arg2.UserInputType == Enum.UserInputType.Touch then
			if b15 then
				f27(arg2)
			end
		end
	end)
	return b15
end

index5.MakeResizeable = function(arg, arg2, arg3, arg4)
	if not arg.Instance then
		return
	end
	local instance = arg.Instance
	local b15 = false
	local v78 = nil
	local mouseLocation = nil
	local v79 = nil
	local v80 = nil
	local function f27(arg5, arg6, arg7)
		local tween = index5:Create("TextButton", {
			Size = arg7, Position = arg6, BackgroundColor3 = Color3.fromRGB(166, 147, 243), BackgroundTransparency = 1, Text = "",
			AutoButtonColor = false, Parent = instance, ZIndex = 99999, BorderColor3 = Color3.fromRGB(27, 42, 53),
		})
		tween:AddToTheme({ BackgroundColor3 = "Accent" })
		return tween
	end
	local t18 = {}
	local t19 = { Button = f27("Left", UDim2.new(0, 0, 0, 0), UDim2.new(0, 2, 1, 0)), Side = "L" }
	local v81 = 2
	local v82 = 1
	local t20 = { Button = f27("Right", UDim2.new(1, -2, 0, 0), UDim2.new(0, v81, v82, 0)), Side = "R" }
	local v83 = 0
	local v84 = 2
	local t21 = { Button = f27("Top", UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, v83, v84)), Side = "T" }
	local t22 = { Button = f27("Bottom", UDim2.new(0, 0, 1, -2), UDim2.new(1, 0, 0, 2)), Side = "B" }
	t18[1] = t19
	t18[2] = t20
	t18[3] = t21
	t18[4] = t22
	local function f28(arg5)
		b15 = true
		v78 = arg5
		mouseLocation = UserInputService:GetMouseLocation()
		v79 = Vector2.new(instance.Position.X.Offset, instance.Position.Y.Offset)
		v80 = Vector2.new(instance.Size.X.Offset, instance.Size.Y.Offset)
		for _, v85 in t18 do
			v85.Button:Tween(nil, { BackgroundTransparency = v85.Side == arg5 and 0 or 1 })
		end
	end
	local function f29()
		b15 = false
		v78 = nil
		for _, v85 in t18 do
			v85.Button.Instance.BackgroundTransparency = 1
		end
	end
	for _, v85 in t18 do
		v85.Button:Connect("InputBegan", function(arg5)
			if arg5.UserInputType == Enum.UserInputType.MouseButton1 then
				f28(v85.Side)
			end
		end)
	end
	index3:Connect(UserInputService.InputEnded, function(arg5)
		if arg5.UserInputType == Enum.UserInputType.MouseButton1 then
			if b15 then
				f29()
			end
		end
	end)
	index3:Connect(RunService.RenderStepped, function()
		if not b15 or not v78 then
			return
		end
		local mouseLocation2 = UserInputService:GetMouseLocation()
		local n = mouseLocation2.X - mouseLocation.X
		local n32 = mouseLocation2.Y - mouseLocation.Y
		local x = v79.X
		local y = v79.Y
		local x2 = v80.X
		local y2 = v80.Y
		if v78 == "Left" then
			x = v79.X + n
			x2 = v80.X - n
			if arg4 then
				arg4.Left.Y = y2
			end
		elseif v78 == "Right" then
			local n33 = v80.X + n
			if arg4 then
				arg4.Right.Y = y2
				x2 = n33
			else
				x2 = n33
			end
		elseif v78 == "Top" then
			y = v79.Y + n32
			y2 = v80.Y - n32
			if arg4 then
				arg4.Top.X = x2
			end
		elseif v78 == "B" then
			y2 = v80.Y + n32
			if arg4 then
				arg4.Bottom.X = x2
			end
		end
		if x2 < arg2.X then
			if v78 == "L" then
				x -= arg2.X - x2
			end
			x2 = arg2.X
		end
		if y2 < arg2.Y then
			if v78 == "T" then
				y -= arg2.Y - y2
			end
			y2 = arg2.Y
		end
		arg:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(x, y) })
		arg:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(x2, y2) })
	end)
end

index5.OnHover = function(arg, arg2)
	if not arg.Instance then
		return
	end
	return index3:Connect(arg.Instance.MouseEnter, arg2)
end

index5.OnHoverLeave = function(arg, arg2)
	if not arg.Instance then
		return
	end
	return index3:Connect(arg.Instance.MouseLeave, arg2)
end

local t18 = { New = function(arg, arg2, arg3, arg4, arg5)
	if not isfile(arg5.Id) then
		writefile(arg5.Id, game:HttpGet(arg5.Url))
	end
	local t19 = {
		name = arg2, faces = { { name = arg2, weight = arg3, style = arg4, assetId = getcustomasset(arg5.Id) } },
	}
	local jsonEncode = HttpService.JSONEncode
	writefile(("%*/%*.font"):format(index3.Folders.Assets, arg2), jsonEncode(HttpService, t19))
	local v78 = getcustomasset
	local str8 = ("%*/%*.font"):format(index3.Folders.Assets, arg2)
	return v78(str8)
end }

local font = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)

index3.Fonts = {
	SemiBold = font, Regular = Font.new("rbxassetid://12187365364", Enum.FontWeight.Regular, Enum.FontStyle.Normal),
	Light = Font.new("rbxassetid://12187365364", Enum.FontWeight.Light, Enum.FontStyle.Normal),
}

index3.Font = font

index3.Holder = index5:Create("ScreenGui", {
	Parent = gethui(), Name = "ReaperX", ZIndexBehavior = Enum.ZIndexBehavior.Global, DisplayOrder = 2, ResetOnSpawn = false,
})

index3.UnusedHolder = index5:Create("ScreenGui", {
	Parent = gethui(), ZIndexBehavior = Enum.ZIndexBehavior.Global, Enabled = false, ResetOnSpawn = false,
})

index3.NotifHolder = index5:Create("Frame", {
	Parent = index3.Holder.Instance, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X,
})

index5:Create("UIListLayout", {
	Parent = index3.NotifHolder.Instance, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder,
})

index5:Create("UIPadding", {
	Parent = index3.NotifHolder.Instance, PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12), PaddingRight = UDim.new(0, 12),
	PaddingLeft = UDim.new(0, 12),
})

index3.Unload = function(arg)
	for _, v78 in arg.Connections do
		v78.Connection:Disconnect()
	end
	for _, v78 in arg.Threads do
		coroutine.close(v78)
	end
	if arg.Holder then
		arg.Holder:Clean()
	end
	index3 = nil
	getgenv().Library = nil
end

index3.GetImage = function(arg, arg2)
	local v78 = arg.Images[arg2]
	if not v78 then
		return
	end
	return getcustomasset(arg.Folders.Assets .. "/" .. v78[1])
end

index3.Round = function(arg, arg2, arg3)
	local n = 1 / (arg3 or 1)
	return math.floor(arg2 * n) / n
end

index3.Thread = function(arg, arg2)
	local thread = coroutine.create(arg2)
	coroutine.wrap(function()
		coroutine.resume(thread)
	end)()
	table.insert(arg.Threads, thread)
	return thread
end

index3.SafeCall = function(arg, arg2, ...)
	local ok = pcall(arg2, table.unpack({ ... }))
	if not ok then
		return false
	end
	return ok
end

index3.Connect = function(arg, arg2, arg3, arg4)
	local t18 = {
		Event = arg2, Callback = arg3,
		Name = arg4 or string.format("connection_number_%s_%s", arg.UnnamedConnections + 1, HttpService:GenerateGUID(false)),
		Connection = nil,
	}
	index3:Thread(function()
		t18.Connection = arg2:Connect(arg3)
	end)
	table.insert(arg.Connections, t18)
	return t18
end

index3.Disconnect = function(arg, arg2)
	for _, v78 in arg.Connections do
		if v78.Name == arg2 then
			v78.Connection:Disconnect()
			break
		end
	end
end

index3.NextFlag = function(arg)
	return string.format("flag_number_%s_%s", arg.UnnamedFlags + 1, HttpService:GenerateGUID(false))
end

index3.AddToTheme = function(arg, arg2, arg3)
	local instance = arg2.Instance or arg2
	local t18 = { Item = instance, Properties = arg3 }
	for k_, v78 in t18.Properties do
		if type(v78) == "string" then
			instance[k_] = arg.Theme[v78]
		else
			instance[k_] = v78()
		end
	end
	table.insert(arg.ThemeItems, t18)
	arg.ThemeMap[instance] = t18
end

index3.ToRich = function(arg, arg2, arg3)
	return (("<font color=\"rgb(%*, %*, %*)\">%*</font>"):format(math.floor(arg3.R * 255), math.floor(arg3.G * 255), math.floor(arg3.B * 255), arg2))
end

index3.ReadConfigFile = function(arg, arg2)
	if type(arg2) ~= "string" or arg2 == "" then
		return nil
	end
	local str8 = index3.Folders.Configs .. "/" .. arg2
	local ok, result = pcall(function()
		if not isfile(str8) then
			return nil
		end
		return HttpService:JSONDecode(readfile(str8))
	end)
	return ok and type(result) == "table" and result or nil
end

index3.GetConfig = function(arg, arg2)
	local t18 = {}
	index3:SafeCall(function()
		for k_, v78 in index3.Flags do
			if type(v78) == "table" and v78.Key then
				t18[k_] = { Key = tostring(v78.Key), Mode = v78.Mode }
			elseif type(v78) == "table" and v78.Color then
				t18[k_] = { Color = "#" .. v78.HexValue, Alpha = v78.Alpha }
			else
				t18[k_] = v78
			end
		end
	end)
	local b15 = type(arg2) == "table" and arg2 or index3:ReadConfigFile(arg2)
	if b15 then
		index3:SafeCall(function()
			for k_, v78 in b15 do
				if t18[k_] == nil and index3.SetFlags[k_] == nil then
					t18[k_] = v78
				end
			end
		end)
	end
	return HttpService:JSONEncode(t18)
end

local t18 = { "Default", "Auto Load", "Macro Record" }

index3.LoadConfig = function(arg, arg2, currentConfig)
	local data2 = HttpService:JSONDecode(arg2)
	local v78, v79 = index3:SafeCall(function()
		for k_, v80 in data2 do
			if not table.find(t18, tostring(k_)) then
				local v81 = index3.SetFlags[k_]
				if v81 then
					if type(v80) == "table" and v80.Key then
						v81(v80)
					elseif type(v80) == "table" and v80.Color then
						v81(v80.Color, v80.Alpha)
					else
						v81(v80)
					end
				end
			end
		end
	end)
	index3.CurrentConfig = currentConfig
	return v78, v79
end

index3.AutoSave = function()
	pcall(function()
		if not index3.Loading then
			return
		end
		if index3.CurrentConfig ~= configFileName then
			return
		end
		if isfile(index3.Folders.Configs .. "/" .. configFileName) then
			if index3.CurrentConfig == configFileName then
				writefile(index3.Folders.Configs .. "/" .. configFileName, index3:GetConfig(configFileName))
			end
		end
	end)
end

index3.DeleteConfig = function(arg, arg2)
	if isfile(index3.Folders.Configs .. "/" .. arg2) then
		delfile(index3.Folders.Configs .. "/" .. arg2)
	end
end

index3.RefreshConfigsList = function(arg, arg2)
	local t18 = {}
	local t19 = {}
	local v78 = string.gsub(index3.Folders.Configs, index3.Folders.Directory .. "/", "")
	for k_, config in listfiles(index3.Folders.Configs) do
		t19[k_] = string.gsub(config, index3.Folders.Directory .. "\\" .. v78 .. "\\", "")
	end
	if not (#t19 ~= t18) then
		for i = 1, #t19 do
			if t19[i] ~= t18[i] then
				break
			end
		end
	else
		arg2:Refresh(t19)
	end
end

index3.ChangeItemTheme = function(arg, arg2, properties)
	local instance = arg2.Instance or arg2
	if not arg.ThemeMap[instance] then
		return
	end
	arg.ThemeMap[instance].Properties = properties
	arg.ThemeMap[instance] = arg.ThemeMap[instance]
end

index3.ChangeTheme = function(arg, arg2, arg3)
	arg.Theme[arg2] = arg3
	for _, v78 in arg.ThemeItems do
		for k_, v79 in v78.Properties do
			if type(v79) == "string" and v79 == arg2 then
				v78.Item[k_] = arg3
			elseif type(v79) == "function" then
				v78.Item[k_] = v79()
			end
		end
	end
end

index3.IsMouseOverFrame = function(arg, arg2)
	local instance = arg2.Instance
	local v78 = Vector2.new(mouse.X, mouse.Y)
	return v78.X >= instance.AbsolutePosition.X and v78.X <= instance.AbsolutePosition.X + instance.AbsoluteSize.X and v78.Y >= instance.AbsolutePosition.Y and v78.Y <= instance.AbsolutePosition.Y + instance.AbsoluteSize.Y
end

index3.Lerp = function(arg, arg2, arg3, arg4)
	return arg2 + (arg3 - arg2) * arg4
end

index3.CompareVectors = function(arg, arg2, arg3)
	return arg2.X < arg3.X or arg2.Y < arg3.Y
end

index3.IsClipped = function(arg, arg2, arg3)
	local absolutePosition = arg3.AbsolutePosition
	local n = absolutePosition + arg3.AbsoluteSize
	local absolutePosition2 = arg2.AbsolutePosition
	local n32 = absolutePosition2 + arg2.AbsoluteSize
	return index3:CompareVectors(absolutePosition2, absolutePosition) or index3:CompareVectors(n, n32)
end

index3.GetCalculatedRayPosition = function(arg, arg2, arg3, arg4, arg5)
	local n = arg4 - arg2
	return arg4 + -(arg3.x * n.x + arg3.y * n.y + arg3.z * n.z) / (arg3.x * arg5.x + arg3.y * arg5.y + arg3.z * arg5.z) * arg5
end

index3.UpdateText = function(arg)
	for _, v78 in arg.UnusedHolder.Instance:GetDescendants() do
		if v78:IsA("TextLabel") or v78:IsA("TextButton") or v78:IsA("TextBox") then
			v78.FontFace = index3.Font
		end
	end
	for _, v78 in arg.Holder.Instance:GetDescendants() do
		if v78:IsA("TextLabel") or v78:IsA("TextButton") or v78:IsA("TextBox") then
			v78.FontFace = index3.Font
		end
	end
end

index3.MakeBlurred = function(arg, arg2, arg3)
	local instance = arg2.Instance
	local v78 = instance
	local tween = index5:Create("Part", {
		Material = Enum.Material.Glass, Transparency = 1, Reflectance = 1, CastShadow = false, Anchored = true, CanCollide = false,
		CanQuery = false, CollisionGroup = "Default", Size = Vector3.new(1, 1, 1) * 0.01, Color = Color3.fromRGB(0, 0, 0),
		Parent = currentCamera, Name = "Part",
	})
	local tween2 = index5:Create("BlockMesh", { Parent = tween.Instance, Name = "BlockMesh" })
	local tween3 = index5:Create("DepthOfFieldEffect", {
		Parent = Lighting, Enabled = true, FarIntensity = 0, FocusDistance = 0, InFocusRadius = 1000, NearIntensity = 1, Name = "",
	})
	local n = 0
	local b15 = false
	index3:Connect(RunService.RenderStepped, function(arg4)
		n += arg4
		if n < 0.033333333333333333 then
			return
		end
		n = 0
		if not (arg3.IsOpen and instance.Visible) then
			if b15 then
				b15 = false
				tween3.Instance.NearIntensity = 0
				tween2.Instance.Offset = Vector3.new(0, 0, 0)
				tween2.Instance.Scale = Vector3.new(0, 0, 0)
			end
			return
		end
		if not b15 then
			b15 = true
			tween3.Instance.NearIntensity = 1
			tween.Instance.Transparency = 0.85
			tween.Instance.Size = Vector3.new(1, 1, 1) * 0.01
		end
		local absolutePosition = v78.AbsolutePosition
		local n32 = absolutePosition + v78.AbsoluteSize
		local v79 = currentCamera:ScreenPointToRay(absolutePosition.X, absolutePosition.Y, 1)
		local v80 = currentCamera:ScreenPointToRay(n32.X, n32.Y, 1)
		local n33 = currentCamera.CFrame.Position + currentCamera.CFrame.LookVector * (1 - currentCamera.NearPlaneZ)
		local lookVector = currentCamera.CFrame.LookVector
		local calculatedRayPosition = index3:GetCalculatedRayPosition(n33, lookVector, v79.Origin, v79.Direction)
		local calculatedRayPosition2 = index3:GetCalculatedRayPosition(n33, lookVector, v80.Origin, v80.Direction)
		local v81 = currentCamera.CFrame:PointToObjectSpace(calculatedRayPosition)
		local v82 = currentCamera.CFrame:PointToObjectSpace(calculatedRayPosition2)
		tween2.Instance.Offset = (v81 + v82) / 2
		tween2.Instance.Scale = (v82 - v81) / 100
		tween.Instance.CFrame = currentCamera.CFrame
	end)
end

index3.EscapePattern = function(arg, arg2)
	local b15 = false
	if string.match(arg2, "[%(%)%.%%%+%-%*%?%[%]%^%$]") then
		b15 = true
	end
	if b15 then
		return string.gsub(arg2, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
	end
	return arg2
end

index3.CreateColorpicker = function(arg, arg2)
	local t18 = {
		Flag = arg2.Flag, Hue = 0, Saturation = 0, Value = 0, Alpha = 0, Color = Color3.fromRGB(0, 0, 0), HexValue = "#000000",
		SavedColors = {}, IsOpen = false,
	}
	local t19 = {
		ColorpickerButton = index5:Create("TextButton", {
			Parent = arg2.Parent.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
			AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Size = UDim2.new(0, 100, 0, 20), ZIndex = 2, TextSize = 14,
		}),
	}
	if not arg2.Parent2.Instance:FindFirstChild("nig") then
		t19.PaletteIcon = index5:Create("ImageLabel", {
			Parent = arg2.Parent2.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 16, 0, 16),
			AnchorPoint = Vector2.new(0.5, 1), Image = "rbxassetid://92464809279921", Name = "nig", BackgroundTransparency = 1,
			Position = UDim2.new(1, -16, 1, -6), ZIndex = 2,
		})
		t19.PaletteIcon:OnHover(function()
			t19.PaletteIcon:Tween(nil, { ImageColor3 = index3.Theme.Accent })
		end)
		t19.PaletteIcon:OnHoverLeave(function()
			t19.PaletteIcon:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
		end)
	end
	t19.Color = index5:Create("Frame", {
		Parent = t19.ColorpickerButton.Instance, Size = UDim2.new(0, 15, 0, 15), Position = UDim2.new(0, 0, 0, 2), ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(124, 77, 255),
	})
	index5:Create("UICorner", { Parent = t19.Color.Instance, CornerRadius = UDim.new(1, 0) })
	t19.Text = index5:Create("TextLabel", {
		Parent = t19.ColorpickerButton.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "#7842ff",
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(0, 25, 0, 2),
		ZIndex = 2, TextSize = 14,
	})
	t19.Text:AddToTheme({ TextColor3 = "Text" })
	t19.ColorpickerWindow = index5:Create("TextButton", {
		Parent = index3.UnusedHolder.Instance, AutoButtonColor = false, Text = "", Visible = false,
		Position = UDim2.new(0.5, 0, 0.033642716705799103, 0), Size = UDim2.new(0, 235, 0, 270),
		BackgroundColor3 = Color3.fromRGB(255, 255, 25),
	})
	t19.ColorpickerWindow:AddToTheme({ BackgroundColor3 = "Background" })
	index5:Create("UICorner", { Parent = t19.ColorpickerWindow.Instance, CornerRadius = UDim.new(0, 6) })
	t19.Palette = index5:Create("TextButton", {
		Parent = t19.ColorpickerWindow.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
		AutoButtonColor = false, Position = UDim2.new(0, 15, 0, 10), Size = UDim2.new(1, -31, 1, -159), TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(90, 163, 255),
	})
	t19.Saturation = index5:Create("Frame", {
		Parent = t19.Palette.Instance, Size = UDim2.new(1, 1, 1, 0),
	})
	local v78 = 1
	local v79 = 0
	index5:Create("UIGradient", {
		Parent = t19.Saturation.Instance,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(v78, v79) }),
	})
	index5:Create("UICorner", { Parent = t19.Saturation.Instance, CornerRadius = UDim.new(0, 4) })
	t19.Value = index5:Create("Frame", {
		Parent = t19.Palette.Instance, Size = UDim2.new(1, 1, 1, 1), BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	})
	index5:Create("UIGradient", {
		Parent = t19.Value.Instance, Rotation = 90,
		Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0) }),
	})
	index5:Create("UICorner", { Parent = t19.Value.Instance, CornerRadius = UDim.new(0, 4) })
	index5:Create("UICorner", { Parent = t19.Palette.Instance, CornerRadius = UDim.new(0, 4) })
	t19.PaletteDragger = index5:Create("Frame", {
		Parent = t19.Palette.Instance, BackgroundTransparency = 1, Position = UDim2.new(0, 15, 0, 15), Size = UDim2.new(0, 10, 0, 10),
	})
	index5:Create("UIStroke", {
		Parent = t19.PaletteDragger.Instance, Color = Color3.fromRGB(255, 255, 255), ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
	index5:Create("UICorner", { Parent = t19.PaletteDragger.Instance })
	t19.Hue = index5:Create("TextButton", {
		Parent = t19.ColorpickerWindow.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
		AutoButtonColor = false, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 15, 1, -125), Size = UDim2.new(1, -31, 0, 6),
		TextSize = 14,
	})
	index5:Create("UICorner", { Parent = t19.Hue.Instance, CornerRadius = UDim.new(1, 0) })
	t19.HueInline = index5:Create("TextButton", {
		Parent = t19.Hue.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		Size = UDim2.new(1, 0, 1, 0), TextSize = 14,
	})
	index5:Create("UICorner", { Parent = t19.HueInline.Instance, CornerRadius = UDim.new(1, 0) })
	local v80 = index5
	local create = v80.Create
	local t20 = { Parent = t19.HueInline.Instance, Name = "\0" }
	local t21 = {}
	local v81 = ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0))
	local v82 = ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0))
	local v83 = ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0))
	local v84 = ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255))
	local v85 = ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255))
	local v86 = 0
	local v87 = ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255))
	t21[1] = v81
	t21[2] = v82
	t21[3] = v83
	t21[4] = v84
	t21[5] = v85
	t21[6] = v87
	local values = table.pack(ColorSequenceKeypoint.new(1, Color3.fromRGB(255, v86, 0)))
	table.move(values, 1, values.n, 7, t21)
	t20.Color = ColorSequence.new(t21)
	create(v80, "UIGradient", t20)
	t19.HueDragger = index5:Create("Frame", {
		Parent = t19.HueInline.Instance, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 15, 0.5, 0),
		Size = UDim2.new(0, 12, 0, 12),
	})
	index5:Create("UICorner", { Parent = t19.HueDragger.Instance, CornerRadius = UDim.new(1, 0) })
	t19.Alpha = index5:Create("TextButton", {
		Parent = t19.ColorpickerWindow.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
		AutoButtonColor = false, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 15, 1, -107), Size = UDim2.new(1, -32, 0, 6),
		TextSize = 14, BackgroundColor3 = Color3.fromRGB(90, 163, 255),
	})
	index5:Create("UICorner", { Parent = t19.Alpha.Instance, CornerRadius = UDim.new(1, 0) })
	local v88 = 255
	index5:Create("UIGradient", {
		Parent = t19.Alpha.Instance,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, v88)) }),
	})
	t19.AlphaDragger = index5:Create("Frame", {
		Parent = t19.Alpha.Instance, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 15, 0.5, 0), Size = UDim2.new(0, 12, 0, 12),
	})
	index5:Create("UICorner", { Parent = t19.AlphaDragger.Instance, CornerRadius = UDim.new(1, 0) })
	t19.SavedColors = index5:Create("ScrollingFrame", {
		Parent = t19.ColorpickerWindow.Instance, AutomaticCanvasSize = Enum.AutomaticSize.Y, AnchorPoint = Vector2.new(0, 1),
		CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarImageColor3 = Color3.fromRGB(124, 163, 255), MidImage = "rbxassetid://86870199131153",
		ScrollBarThickness = 0, Size = UDim2.new(1, -20, 0, 69), Selectable = false, TopImage = "rbxassetid://86870199131153",
		Position = UDim2.new(0, 10, 1, -30), BottomImage = "rbxassetid://86870199131153", BackgroundTransparency = 1,
	})
	index5:Create("UIGridLayout", {
		Parent = t19.SavedColors.Instance, SortOrder = Enum.SortOrder.LayoutOrder, CellPadding = UDim2.new(0, 10, 0, 10),
		CellSize = UDim2.new(0, 25, 0, 27),
	})
	index5:Create("UIPadding", {
		Parent = t19.SavedColors.Instance, PaddingLeft = UDim.new(0, 5), PaddingTop = UDim.new(0, 5), PaddingRight = UDim.new(0, -125),
		PaddingBottom = UDim.new(0, 5),
	})
	t19.HEXInput = index5:Create("TextBox", {
		Parent = t19.ColorpickerWindow.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		ClearTextOnFocus = false, Text = "#7ca3ff", AnchorPoint = Vector2.new(1, 1), Size = UDim2.new(0, 140, 0, 24),
		TextTransparency = 0.5, PlaceholderColor3 = Color3.fromRGB(185, 185, 185), Position = UDim2.new(1, -8, 1, -8),
		TextXAlignment = Enum.TextXAlignment.Left, TextSize = 14, BackgroundColor3 = Color3.fromRGB(30, 29, 31),
	})
	t19.HEXInput:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UIPadding", { Parent = t19.HEXInput.Instance, PaddingLeft = UDim.new(0, 5) })
	t19.HexLabel = index5:Create("TextLabel", {
		Parent = t19.ColorpickerWindow.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "Custom:",
		TextTransparency = 0.5, AnchorPoint = Vector2.new(0, 1), Size = UDim2.new(0, 40, 0, 24), Position = UDim2.new(0, 10, 1, -8),
		TextSize = 14, BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(30, 29, 32),
	})
	t19.HexLabel:AddToTheme({ TextColor3 = "Text" })
	index5:Create("UICorner", { Parent = t19.HEXInput.Instance, CornerRadius = UDim.new(0, 4) })
	t18.Get = function()
		return t18.Color, t18.Alpha
	end
	t18.Update = function(arg3, arg4)
		local hue = t18.Hue
		t18.Color = Color3.fromHSV(hue, t18.Saturation, t18.Value)
		t18.HexValue = t18.Color:ToHex()
		index3.Flags[t18.Flag] = { Alpha = t18.Alpha, Color = t18.Color, HexValue = t18.HexValue, Transparency = 1 - t18.Alpha }
		t19.Color:Tween(nil, { BackgroundColor3 = t18.Color })
		t19.Palette:Tween(nil, { BackgroundColor3 = Color3.fromHSV(hue, 1, 1) })
		t19.Text.Instance.Text = ("#" .. t18.HexValue):upper()
		t19.HEXInput.Instance.Text = "#" .. t18.HexValue
		if not arg4 then
			t19.Alpha:Tween(nil, { BackgroundColor3 = t18.Color })
		end
		if arg2.Callback then
			index3:SafeCall(arg2.Callback, t18.Color, t18.Alpha)
		end
	end
	local b15 = false
	local connection = nil
	t18.SlidePalette = function(arg3, arg4)
		if not arg4 or not b15 then
			return
		end
		local v89 = math.clamp(1 - (arg4.Position.X - t19.Palette.Instance.AbsolutePosition.X) / t19.Palette.Instance.AbsoluteSize.X, 0, 1)
		local v90 = math.clamp(1 - (arg4.Position.Y - t19.Palette.Instance.AbsolutePosition.Y) / t19.Palette.Instance.AbsoluteSize.Y, 0, 1)
		t18.Saturation = v89
		t18.Value = v90
		local v91 = math.clamp((arg4.Position.X - t19.Palette.Instance.AbsolutePosition.X) / t19.Palette.Instance.AbsoluteSize.X, 0, 0.955)
		local v92 = math.clamp((arg4.Position.Y - t19.Palette.Instance.AbsolutePosition.Y) / t19.Palette.Instance.AbsoluteSize.Y, 0, 0.955)
		t19.PaletteDragger:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(v91, 0, v92, 0) })
		t18:Update()
	end
	local b16 = false
	local connection2 = nil
	t18.SlideHue = function(arg3, arg4)
		if not arg4 or not b16 then
			return
		end
		t18.Hue = math.clamp((arg4.Position.X - t19.Hue.Instance.AbsolutePosition.X) / t19.Hue.Instance.AbsoluteSize.X, 0, 1)
		local v89 = math.clamp((arg4.Position.X - t19.Hue.Instance.AbsolutePosition.X) / t19.Hue.Instance.AbsoluteSize.X, 0, 0.955)
		t19.HueDragger:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(v89, 0, 0.5, 0) })
		t18:Update()
	end
	local b17 = false
	local connection3 = nil
	t18.SlideAlpha = function(arg3, arg4)
		if not arg4 or not b17 then
			return
		end
		t18.Alpha = math.clamp((arg4.Position.X - t19.Alpha.Instance.AbsolutePosition.X) / t19.Alpha.Instance.AbsoluteSize.X, 0, 1)
		local v89 = math.clamp((arg4.Position.X - t19.Alpha.Instance.AbsolutePosition.X) / t19.Alpha.Instance.AbsoluteSize.X, 0, 0.955)
		t19.AlphaDragger:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(v89, 0, 0.5, 0) })
		t18:Update(true)
	end
	local b18 = false
	local connection4 = nil
	t18.SetOpen = function(arg3, isOpen)
		if b18 then
			return
		end
		t18.IsOpen = isOpen
		b18 = true
		if t18.IsOpen then
			t19.ColorpickerWindow.Instance.Visible = true
			t19.ColorpickerWindow.Instance.Parent = index3.Holder.Instance
			connection4 = RunService.RenderStepped:Connect(function()
				t19.ColorpickerWindow.Instance.Position = UDim2.new(0, t19.ColorpickerButton.Instance.AbsolutePosition.X, 0, t19.ColorpickerButton.Instance.AbsolutePosition.Y + t19.ColorpickerButton.Instance.AbsoluteSize.Y + 5)
			end)
			if arg2.Section.IsSettings ~= true then
				for _, v89 in index3.OpenFrames do
					if v89 ~= t18 then
						v89:SetOpen(false)
					end
				end
			end
			index3.OpenFrames[t18] = t18
		else
			if not arg2.Section.IsSettings then
				if index3.OpenFrames[t18] then
					index3.OpenFrames[t18] = nil
				end
			end
			if connection4 then
				connection4:Disconnect()
				connection4 = nil
			end
		end
		local descendants = t19.ColorpickerWindow.Instance:GetDescendants()
		table.insert(descendants, t19.ColorpickerWindow.Instance)
		local v89 = nil
		for _, v90 in descendants do
			local property = index4:GetProperty(v90)
			if property then
				if not v90.ClassName:find("UI") then
					local n = t18.IsOpen and arg2.Section.IsSettings and 9
					local zIndex
					if n then
						zIndex = n
					else
						zIndex = t18.IsOpen and not arg2.Section.IsSettings and 3
					end
					zIndex = zIndex or 1
					v90.ZIndex = zIndex
				end
				if type(property) == "table" then
					for _, v91 in property do
						v89 = index4:FadeItem(v90, v91, isOpen, index3.FadeSpeed)
					end
				else
					v89 = index4:FadeItem(v90, property, isOpen, index3.FadeSpeed)
				end
			end
		end
		v89.Tween.Completed:Connect(function()
			b18 = false
			t19.ColorpickerWindow.Instance.Visible = t18.IsOpen
			task.wait(0.2)
			t19.ColorpickerWindow.Instance.Parent = not t18.IsOpen and index3.UnusedHolder.Instance or index3.Holder.Instance
		end)
	end
	t18.Set = function(arg3, arg4, alpha)
		if type(arg4) == "table" then
			arg4 = Color3.fromRGB(arg4[1], arg4[2], arg4[3])
			alpha = arg4[4]
		elseif type(arg4) == "string" then
			arg4 = Color3.fromHex(arg4)
		end
		local v89 = t18
		local v90 = t18
		local v91 = t18
		local v92, v93, v94 = arg4:ToHSV()
		v89.Hue = v92
		v90.Saturation = v93
		v91.Value = v94
		t18.Alpha = alpha or 0
		local v95 = math.clamp(1 - t18.Saturation, 0, 0.955)
		local v96 = math.clamp(1 - t18.Value, 0, 0.955)
		local v97 = math.clamp(t18.Alpha, 0, 0.955)
		local v98 = math.clamp(t18.Hue, 0, 0.955)
		t19.PaletteDragger:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(v95, 0, v96, 0) })
		t19.HueDragger:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(v98, 0, 0.5, 0) })
		t19.AlphaDragger:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(v97, 0, 0.5, 0) })
		t18:Update()
	end
	t19.ColorpickerButton:Connect("MouseButton1Down", function()
		t18:SetOpen(not t18.IsOpen)
	end)
	t19.Palette:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			b15 = true
			t18:SlidePalette(arg3)
			if connection then
				return
			end
			connection = arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					b15 = false
					connection:Disconnect()
					connection = nil
				end
			end)
		end
	end)
	t19.HueInline:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			b16 = true
			t18:SlideHue(arg3)
			if connection2 then
				return
			end
			connection2 = arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					b16 = false
					connection2:Disconnect()
					connection2 = nil
				end
			end)
		end
	end)
	t19.Alpha:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			b17 = true
			t18:SlideAlpha(arg3)
			if connection3 then
				return
			end
			connection3 = arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					b17 = false
					connection3:Disconnect()
					connection3 = nil
				end
			end)
		end
	end)
	AddColor = function(arg3)
		local n = #t18.SavedColors + 1
		local tween = index5:Create("TextButton", {
			Parent = t19.SavedColors.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
			AutoButtonColor = false, Size = UDim2.new(0, 200, 0, 50), TextSize = 14, BackgroundTransparency = 1, ZIndex = 4,
			BackgroundColor3 = arg3,
		})
		index5:Create("UICorner", { Parent = tween.Instance, CornerRadius = UDim.new(0, 6) })
		local tween2 = index5:Create("UIStroke", {
			Parent = tween.Instance, ApplyStrokeMode = Enum.ApplyStrokeMode.Border, Color = Color3.fromRGB(255, 255, 255), Thickness = 1.5,
			Transparency = 1,
		})
		tween:OnHover(function()
			tween2:Tween(nil, { Transparency = 0 })
		end)
		tween:OnHoverLeave(function()
			tween2:Tween(nil, { Transparency = 1 })
		end)
		t18.SavedColors[n] = { Color = arg3, Alpha = t18.Alpha }
		tween:Connect("MouseButton1Down", function()
			local v89 = t18.SavedColors[n]
			t18:Set(v89.Color, v89.Alpha)
		end)
		tween:Tween(nil, { BackgroundTransparency = 0 })
	end
	local t22 = {
		Orange = Color3.fromRGB(245, 114, 66), Pink = Color3.fromRGB(245, 66, 191), Purple = Color3.fromRGB(124, 54, 245),
		["Pink 2"] = Color3.fromRGB(202, 110, 255), ["Pink 3"] = Color3.fromRGB(250, 142, 239), Yellow = Color3.fromRGB(214, 200, 92),
		["Orange 2"] = Color3.fromRGB(255, 93, 48), ["Orange 3"] = Color3.fromRGB(255, 150, 56), Green = Color3.fromRGB(0, 255, 0),
		Blue = Color3.fromRGB(0, 116, 200), Maroon = Color3.fromRGB(128, 0, 76), ["Whiteish Pink"] = Color3.fromRGB(255, 194, 245),
		White = Color3.fromRGB(255, 255, 255), Red = Color3.fromRGB(255, 0, 0), ["Sky Blue"] = Color3.fromRGB(171, 209, 255),
	}
	AddColor(t22.Orange)
	AddColor(t22.Pink)
	AddColor(t22.Purple)
	AddColor(t22["Pink 2"])
	AddColor(t22["Pink 3"])
	AddColor(t22.Yellow)
	AddColor(t22["Orange 2"])
	AddColor(t22["Orange 3"])
	AddColor(t22.Green)
	AddColor(t22.Blue)
	AddColor(t22.Maroon)
	AddColor(t22["Whiteish Pink"])
	AddColor(t22.White)
	AddColor(t22.Red)
	AddColor(t22["Sky Blue"])
	t19.HEXInput:Connect("FocusLost", function()
		local alpha = t18.Alpha
		t18:Set(tostring(t19.HEXInput.Instance.Text), alpha)
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseMovement or arg3.UserInputType == Enum.UserInputType.Touch then
			if b15 then
				t18:SlidePalette(arg3)
			end
			if b16 then
				t18:SlideHue(arg3)
			end
			if b17 then
				t18:SlideAlpha(arg3)
			end
		end
	end)
	index3:Connect(UserInputService.InputBegan, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			if not t18.IsOpen then
				return
			end
			if index3:IsMouseOverFrame(t19.ColorpickerWindow) or index3:IsMouseOverFrame(t19.PaletteIcon) and not arg2.Section.IsSettings then
				return
			end
			t18:SetOpen(false)
		end
	end)
	if arg2.Default then
		t18:Set(arg2.Default, arg2.Alpha)
	end
	index3.SetFlags[t18.Flag] = function(arg3, arg4)
		t18:Set(arg3, arg4)
	end
	return t18, t19
end

index3.KeybindList = function(arg, arg2)
	local keyList = {}
	index3.KeyList = keyList
	local t18 = {
		KeybindsList = index5:Create("Frame", {
			Parent = index3.Holder.Instance, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 0.30000001192092896,
			Position = UDim2.new(0, 20, 0.5, 20), Size = UDim2.new(0, 100, 0, 30), AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(27, 25, 29),
		}),
	}
	t18.KeybindsList:AddToTheme({ BackgroundColor3 = "Section Background" })
	t18.KeybindsList:MakeDraggable()
	index5:Create("UICorner", { Parent = t18.KeybindsList.Instance })
	t18.Top = index5:Create("Frame", {
		Parent = t18.KeybindsList.Instance, Size = UDim2.new(1, 12, 0, 40), BackgroundColor3 = Color3.fromRGB(31, 31, 36),
	})
	t18.Top:AddToTheme({ BackgroundColor3 = "Section Background 2" })
	t18.Icon = index5:Create("ImageLabel", {
		Parent = t18.Top.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 21, 0, 20),
		AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://81598136527047", BackgroundTransparency = 1,
		Position = UDim2.new(0, 15, 0.5, 0), ZIndex = 2,
	})
	local v78 = index5
	local create = v78.Create
	local v79 = "UIGradient"
	local v80 = 1
	create(v78, v79, {
		Parent = t18.Icon.Instance, Name = "\0",
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(125, 125, 125)), ColorSequenceKeypoint.new(v80, Color3.fromRGB(255, 255, 255)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t18.Title = index5:Create("TextLabel", {
		Parent = t18.Top.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(248, 248, 248), Text = arg2,
		AutomaticSize = Enum.AutomaticSize.X, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1,
		Position = UDim2.new(0, 45, 0.5, -1), ZIndex = 2, TextSize = 15,
	})
	t18.Title:AddToTheme({ TextColor3 = "Text" })
	index5:Create("UICorner", { Parent = t18.Top.Instance })
	index5:Create("Frame", {
		Parent = t18.Top.Instance, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 0, 1, 0), Size = UDim2.new(0, 10, 0, 5),
		BackgroundColor3 = Color3.fromRGB(31, 31, 36),
	}):AddToTheme({ BackgroundColor3 = "Section Background 2" })
	index5:Create("Frame", {
		Parent = t18.Top.Instance, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, 0, 1, 0), Size = UDim2.new(0, 10, 0, 5),
		BackgroundColor3 = Color3.fromRGB(32, 31, 36),
	}):AddToTheme({ BackgroundColor3 = "Section Background 2" })
	t18.Content = index5:Create("Frame", {
		Parent = t18.KeybindsList.Instance, BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 40), Size = UDim2.new(1, 12, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})
	index5:Create("UIListLayout", {
		Parent = t18.Content.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", {
		Parent = t18.Content.Instance, PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
	})
	index5:Create("UIPadding", { Parent = t18.KeybindsList.Instance, PaddingRight = UDim.new(0, 12) })
	keyList.SetVisibility = function()
		t18.KeybindsList.Instance.Visible = false
	end
	keyList.Add = function(arg3, arg4, arg5)
		local tween = index5:Create("TextButton", {
			Parent = t18.Content.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
			BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20), TextSize = 14,
		})
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.new(0, 6, 0, 6),
		})
		index5:Create("UIGradient", {
			Parent = tween2.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		index5:Create("UICorner", { Parent = tween2.Instance })
		local tween3 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0.30000001192092896, Text = arg4 .. " [" .. arg5 .. "]", Size = UDim2.new(0, 0, 0, 15),
			AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.5, 0),
			AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
		})
		tween3:AddToTheme({ TextColor3 = "Text" })
		tween.Set = function(arg6, arg7, arg8)
			tween3.Instance.Text = arg7 .. " [" .. arg8 .. "]"
		end
		tween.SetStatus = function(arg6, arg7)
			if arg7 then
				tween3:Tween(nil, { Position = UDim2.new(0, 15, 0.5, 0), TextTransparency = 0 })
				tween2:Tween(nil, { BackgroundTransparency = 0 })
			else
				tween3:Tween(nil, { Position = UDim2.new(0, 0, 0.5, 0), TextTransparency = 0.3 })
				tween2:Tween(nil, { BackgroundTransparency = 1 })
			end
		end
		return tween
	end
	return keyList
end

index3.Notification = function(arg, arg2)
	local t18 = {
		Notification = index5:Create("Frame", {
			Parent = index3.NotifHolder.Instance, BackgroundTransparency = 0.34999999403953552, AutomaticSize = Enum.AutomaticSize.XY,
			BackgroundColor3 = Color3.fromRGB(27, 25, 29),
		}),
	}
	t18.Title = index5:Create("TextLabel", {
		Parent = t18.Notification.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(255, 255, 255), Text = arg2.Title,
		BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 15), RichText = true, AutomaticSize = Enum.AutomaticSize.XY, TextSize = 14,
	})
	t18.Title:AddToTheme({ TextColor3 = "Text" })
	index5:Create("UIPadding", {
		Parent = t18.Notification.Instance, PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingRight = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 8),
	})
	index5:Create("UICorner", { Parent = t18.Notification.Instance, CornerRadius = UDim.new(0, 5) })
	t18.Description = index5:Create("TextLabel", {
		Parent = t18.Notification.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(255, 255, 255),
		TextTransparency = 0.30000001192092896, Text = arg2.Description, Size = UDim2.new(0, 0, 0, 15), RichText = true,
		BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 20), AutomaticSize = Enum.AutomaticSize.XY, TextSize = 14,
	})
	t18.Description:AddToTheme({ TextColor3 = "Text" })
	t18.Accent = index5:Create("Frame", {
		Parent = t18.Notification.Instance,
		Position = UDim2.new(0, 0, 0, t18.Description.Instance.AbsoluteSize.Y + t18.Title.Instance.AbsoluteSize.Y + 12),
		Size = UDim2.new(0, 0, 0, 6),
	})
	index5:Create("UICorner", { Parent = t18.Accent.Instance, CornerRadius = UDim.new(1, 0) })
	local v78 = index5
	local create = v78.Create
	local v79 = "UIGradient"
	local v80 = 1
	create(v78, v79, {
		Parent = t18.Accent.Instance, Name = "\0",
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(v80, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t18.Icon = index5:Create("ImageLabel", {
		Parent = t18.Notification.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), AnchorPoint = Vector2.new(1, 0),
		Image = "rbxassetid://" .. arg2.Icon, BackgroundTransparency = 1, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 16, 0, 16),
	})
	if not arg2.IconColor then
		index5:Create("UIGradient", {
			Parent = t18.Icon.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
	else
		local end_ = arg2.IconColor.End
		index5:Create("UIGradient", {
			Parent = t18.Icon.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, arg2.IconColor.Start), ColorSequenceKeypoint.new(1, end_) }),
		})
	end
	local absoluteSize = t18.Notification.Instance.AbsoluteSize
	t18.Notification.Instance.Size = UDim2.new(0, 0, 0, 0)
	for _, v81 in t18 do
		if v81.Instance:IsA("Frame") then
			v81.Instance.BackgroundTransparency = 1
		elseif v81.Instance:IsA("TextLabel") then
			v81.Instance.TextTransparency = 1
		elseif v81.Instance:IsA("ImageLabel") then
			v81.Instance.ImageTransparency = 1
		end
	end
	task.wait(0.2)
	t18.Notification.Instance.AutomaticSize = Enum.AutomaticSize.Y
	index3:Thread(function()
		for _, v81 in t18 do
			if v81.Instance:IsA("Frame") then
				v81:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), { BackgroundTransparency = 0 })
			elseif v81.Instance:IsA("TextLabel") then
				v81:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), { TextTransparency = 0 })
			elseif v81.Instance:IsA("ImageLabel") then
				v81:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), { ImageTransparency = 0 })
			end
		end
		t18.Notification:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), { Size = UDim2.new(0, absoluteSize.X, 0, absoluteSize.Y) })
		t18.Accent:Tween(TweenInfo.new(arg2.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), { Size = UDim2.new(1, 0, 0, 6) })
		task.delay(arg2.Duration + 0.15, function()
			for _, v81 in t18 do
				if v81.Instance:IsA("Frame") then
					v81:Tween(nil, { BackgroundTransparency = 1 })
				elseif v81.Instance:IsA("TextLabel") then
					v81:Tween(nil, { TextTransparency = 1 })
				elseif v81.Instance:IsA("ImageLabel") then
					v81:Tween(nil, { ImageTransparency = 1 })
				end
			end
			t18.Notification:Tween(TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0), { Size = UDim2.new(0, 0, 0, 0) })
			task.wait(0.5)
			t18.Notification:Clean()
		end)
	end)
end

index3.Window = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = {
		Name = t18.Name or t18.name or "Window", SubName = t18.SubName or t18.subname or "Fine-tuning for sure wins",
		Logo = t18.Logo or t18.logo or "1l20959262762131", Pages = {}, Items = {}, IsOpen = false, CurrentAlignment = "LeftTabs",
	}
	local items = {
		MainFrame = index5:Create("Frame", {
			Parent = index3.Holder.Instance, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 0.12,
			Position = UDim2.new(0.55199998617172241, 0, 0.5, 0), Size = UDim2.new(0, 609, 0, 580), ZIndex = 2,
			BackgroundColor3 = Color3.fromRGB(27, 25, 29),
		}),
	}
	items.MainFrame:AddToTheme({ BackgroundColor3 = "Background" })
	if touchEnabled then
		items.UIScale = index5:Create("UIScale", { Parent = items.MainFrame.Instance, Scale = 0.69999998807907104 })
	else
		items.UIScale = index5:Create("UIScale", { Parent = items.MainFrame.Instance, Scale = 0.875 })
	end
	local function f27(arg3, arg4, arg5)
		local tween = index5:Create("TextButton", {
			Parent = items.MainFrame.Instance, Text = "", AutoButtonColor = false, Size = UDim2.new(0, 20, 0, 20), AnchorPoint = arg3,
			Position = arg4, BackgroundTransparency = 1, ZIndex = 5, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
			BorderColor3 = Color3.fromRGB(27, 42, 53),
		})
		tween:AddToTheme({ BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = tween.Instance, CornerRadius = UDim.new(0, 6) })
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, Size = UDim2.new(0, 0, 0, 0), AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1, ZIndex = 5, BorderColor3 = Color3.fromRGB(27, 42, 53),
		})
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(0, 6) })
		index5:Create("UIGradient", {
			Parent = tween2.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		for i = 1, 3 do
			local n = 3 + (i - 1) * 3
			local tween3 = index5:Create("Frame", {
				Parent = tween.Instance, Size = UDim2.new(0, 2, 0, 7), AnchorPoint = arg3,
				Position = UDim2.new(arg3.X, arg3.X == 1 and -n or n, arg3.Y, arg3.Y == 1 and -n or n), Rotation = -45,
				BackgroundTransparency = 0.35, ZIndex = 6, BackgroundColor3 = Color3.fromRGB(220, 220, 220),
				BorderColor3 = Color3.fromRGB(27, 42, 53),
			})
			tween3:AddToTheme({ BackgroundColor3 = "Text" })
			index5:Create("UICorner", { Parent = tween3.Instance, CornerRadius = UDim.new(1, 0) })
		end
		tween:OnHover(function()
			tween2:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
			tween:Tween(nil, { BackgroundTransparency = 0.3 })
		end)
		tween:OnHoverLeave(function()
			tween2:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
			tween:Tween(nil, { BackgroundTransparency = 1 })
		end)
		local b15 = false
		local mouseLocation = nil
		local scale = nil
		local position = nil
		local v78 = nil
		local connection = nil
		tween:Connect("InputBegan", function(arg6)
			if arg6.UserInputType == Enum.UserInputType.MouseButton1 or arg6.UserInputType == Enum.UserInputType.Touch then
				b15 = true
				mouseLocation = UserInputService:GetMouseLocation()
				scale = items.UIScale.Instance.Scale
				position = items.MainFrame.Instance.Position
				local absoluteSize = items.MainFrame.Instance.AbsoluteSize
				v78 = Vector2.new(absoluteSize.X / scale, absoluteSize.Y / scale)
				if connection then
					return
				end
				connection = arg6.Changed:Connect(function()
					if arg6.UserInputState == Enum.UserInputState.End then
						b15 = false
						connection:Disconnect()
						connection = nil
					end
				end)
			end
		end)
		index3:Connect(UserInputService.InputChanged, function(arg6)
			if not b15 then
				return
			end
			if not mouseLocation or not v78 or not position or not scale then
				return
			end
			if arg6.UserInputType ~= Enum.UserInputType.MouseMovement and arg6.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			local mouseLocation2 = UserInputService:GetMouseLocation()
			local v79 = math.clamp(scale + (mouseLocation2.X - mouseLocation.X + mouseLocation2.Y - mouseLocation.Y) / 2 / (v78.X + v78.Y) / 2 * arg5, 0.4, 2.5)
			items.UIScale.Instance.Scale = v79
			if arg5 == -1 then
				local n = v79 - scale
				items.MainFrame.Instance.Position = UDim2.new(position.X.Scale, position.X.Offset - v78.X * n, position.Y.Scale, position.Y.Offset - v78.Y * n)
			end
		end)
		return tween
	end
	items.ResizeBR = f27(Vector2.new(1, 1), UDim2.new(1, -6, 1, -6), 1)
	items.ResizeTL = f27(Vector2.new(0, 0), UDim2.new(0, 6, 0, 6), -1)
	local v78 = OriginalSizes
	items.MainFrame:MakeResizeable(Vector2.new(items.MainFrame.Instance.AbsoluteSize.X, items.MainFrame.Instance.AbsoluteSize.Y), Vector2.new(9999, 9999), v78)
	index3:MakeBlurred(items.MainFrame, t19)
	items.LeftTabs = index5:Create("Frame", {
		Parent = items.MainFrame.Instance, Visible = true, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.15,
		Size = UDim2.new(0, 203, 1, 0), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(27, 25, 29),
	})
	items.LeftTabs:AddToTheme({ BackgroundColor3 = "Background" })
	index3:MakeBlurred(items.LeftTabs, t19)
	local instance = items.MainFrame.Instance
	local b15 = false
	local position = nil
	local position2 = nil
	local function f28(arg3)
		local n = arg3.Position - position
		items.MainFrame:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(position2.X.Scale, position2.X.Offset + n.X, position2.Y.Scale, position2.Y.Offset + n.Y) })
	end
	items.MainFrame:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			if items.ResizeBR and index3:IsMouseOverFrame(items.ResizeBR) then
				return
			end
			if items.ResizeTL and index3:IsMouseOverFrame(items.ResizeTL) then
				return
			end
			b15 = true
			position = arg3.Position
			position2 = instance.Position
			arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					b15 = false
				end
			end)
		end
	end)
	items.LeftTabs:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			b15 = true
			position = arg3.Position
			position2 = instance.Position
			arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					b15 = false
				end
			end)
		end
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseMovement or arg3.UserInputType == Enum.UserInputType.Touch then
			if b15 then
				f28(arg3)
			end
		end
	end)
	items.FloatingButton = index5:Create("TextButton", {
		Parent = index3.Holder.Instance, Text = "", AutoButtonColor = false, Position = UDim2.new(0.5, 0, 0, 20),
		AnchorPoint = Vector2.new(0.5, 0), Visible = true, Size = UDim2.new(0, 50, 0, 50), BackgroundTransparency = 0.5, ZIndex = 127,
		BackgroundColor3 = index3.Theme.Background,
	})
	items.FloatingButton:AddToTheme({ BackgroundColor3 = "Background" })
	local instance2 = items.FloatingButton.Instance
	local b16 = false
	local position3 = nil
	local position4 = nil
	local function f29(arg3)
		local n = arg3.Position - position3
		items.FloatingButton:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(position4.X.Scale, position4.X.Offset + n.X, position4.Y.Scale, position4.Y.Offset + n.Y) })
	end
	items.FloatingButton:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			b16 = true
			position3 = arg3.Position
			position4 = instance2.Position
			arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					b16 = false
				end
			end)
		end
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseMovement or arg3.UserInputType == Enum.UserInputType.Touch then
			if b16 then
				f29(arg3)
			end
		end
	end)
	items.FloatingLogo = index5:Create("ImageLabel", {
		Parent = items.FloatingButton.Instance, Image = "rbxassetid://" .. t19.Logo, BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 127, Size = UDim2.new(1, -27, 1, -25),
	})
	index5:Create("UICorner", { Parent = items.FloatingButton.Instance, CornerRadius = UDim.new(1, 0), Name = "UICorner" })
	index5:Create("UIGradient", {
		Parent = items.FloatingLogo.Instance, Enabled = true, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	items.PagePlaceholder = index5:Create("Frame", {
		Parent = items.MainFrame.Instance, Visible = true, AnchorPoint = Vector2.new(0, 0), BackgroundTransparency = 1,
		Size = UDim2.new(0, 0, 0, 0), ZIndex = 2,
	})
	index5:Create("UIListLayout", {
		Parent = items.LeftTabs.Instance, Padding = UDim.new(0, 12), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", {
		Parent = items.LeftTabs.Instance, PaddingTop = UDim.new(0, 15), PaddingBottom = UDim.new(0, 15), PaddingRight = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 12),
	})
	items.Logo = index5:Create("ImageLabel", {
		Parent = items.MainFrame.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), ScaleType = Enum.ScaleType.Fit,
		Size = UDim2.new(0, 35, 0, 35), Image = "rbxassetid://" .. t19.Logo, BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 12),
		ZIndex = 2,
	})
	index5:Create("UIGradient", {
		Parent = items.Logo.Instance, Enabled = true, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	items.Title = index5:Create("TextLabel", {
		Parent = items.MainFrame.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = t19.Name,
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(0, 52, 0, 13),
		ZIndex = 2, TextSize = 16,
	})
	items.Title:AddToTheme({ TextColor3 = "Text" })
	items.SubTitle = index5:Create("TextLabel", {
		Parent = items.MainFrame.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.40000000596046448, Text = t19.SubName, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		BackgroundTransparency = 1, Position = UDim2.new(0, 52, 0, 30), ZIndex = 2, TextSize = 14,
	})
	items.SubTitle:AddToTheme({ TextColor3 = "Text" })
	t19.SetSubName = function(arg3, arg4)
		items.SubTitle.Instance.Text = tostring(arg4)
	end
	items.Content = index5:Create("Frame", {
		Parent = items.MainFrame.Instance, BackgroundTransparency = 0.75, Position = UDim2.new(0, 0, 0, 55), Size = UDim2.new(1, 0, 1, -55),
		ZIndex = 2, BackgroundColor3 = Color3.fromRGB(27, 27, 29),
	})
	items.Content:AddToTheme({ BackgroundColor3 = "Background" })
	items.CloseButton = index5:Create("TextButton", {
		Parent = items.MainFrame.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.20000000298023224, Position = UDim2.new(1, -14, 0, 11),
		Size = UDim2.new(0, 32, 0, 32), ZIndex = 2, TextSize = 14, BackgroundColor3 = Color3.fromRGB(27, 27, 29),
	})
	items.CloseButton:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = items.CloseButton.Instance, CornerRadius = UDim.new(0, 7) })
	items.CloseIcon = index5:Create("ImageLabel", {
		Parent = items.CloseButton.Instance, ImageColor3 = Color3.fromRGB(240, 240, 240), ImageTransparency = 0.30000001192092896,
		Size = UDim2.new(0, 11, 0, 11), AnchorPoint = Vector2.new(0.5, 0.5), Image = "rbxassetid://130510492706892",
		BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 3,
	})
	items.CloseIcon:AddToTheme({ ImageColor3 = "Text" })
	items.CloseButton:Connect("MouseButton1Down", function()
		index3:Unload()
	end)
	items.CloseIconAccent = index5:Create("Frame", {
		Parent = items.CloseButton.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, BackgroundTransparency = 1,
	})
	index5:Create("UICorner", { Parent = items.CloseIconAccent.Instance, CornerRadius = UDim.new(0, 7) })
	index5:Create("UICorner", { Parent = items.MainFrame.Instance, CornerRadius = UDim.new(0, 4) })
	index5:Create("UICorner", { Parent = items.LeftTabs.Instance, CornerRadius = UDim.new(0, 4) })
	items.LeftBottomPixels = index5:Create("Frame", {
		Parent = items.MainFrame.Instance, AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, Position = UDim2.new(0, 1, 1, 0),
		Size = UDim2.new(0, 5, 0, 5), ZIndex = 2,
	})
	items.___1 = index5:Create("Frame", {
		Parent = items.LeftBottomPixels.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 0.11999999731779099,
		Position = UDim2.new(0, 2, 1, 0), Size = UDim2.new(0, 1, 0, 1),
	})
	items.___1:AddToTheme({ BackgroundColor3 = "Background" })
	items.___2 = index5:Create("Frame", {
		Parent = items.LeftBottomPixels.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 0.11999999731779099,
		Position = UDim2.new(0, 4, 1, 0), Size = UDim2.new(0, 1, 0, 1),
	})
	items.___2:AddToTheme({ BackgroundColor3 = "Background" })
	items.___3 = index5:Create("Frame", {
		Parent = items.LeftBottomPixels.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 0.11999999731779099,
		Position = UDim2.new(0, 3, 1, 0), Size = UDim2.new(0, 1, 0, 1),
	})
	items.___3:AddToTheme({ BackgroundColor3 = "Background" })
	items.___4 = index5:Create("Frame", {
		Parent = items.LeftBottomPixels.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 0.11999999731779099,
		Position = UDim2.new(0, 3, 1, -1), Size = UDim2.new(0, 1, 0, 1),
	})
	items.___4:AddToTheme({ BackgroundColor3 = "Background" })
	items.___5 = index5:Create("Frame", {
		Parent = items.LeftBottomPixels.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 0.11999999731779099,
		Position = UDim2.new(0, 4, 1, -1), Size = UDim2.new(0, 1, 0, 1),
	})
	items.___5:AddToTheme({ BackgroundColor3 = "Background" })
	items.___6 = index5:Create("Frame", {
		Parent = items.LeftBottomPixels.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 0.11999999731779099,
		Position = UDim2.new(0, 5, 1, 0), Size = UDim2.new(0, 1, 0, 1),
	})
	items.___6:AddToTheme({ BackgroundColor3 = "Background" })
	items.LeftTopPixels = index5:Create("Frame", {
		Parent = items.MainFrame.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 1, 0, 0),
		Size = UDim2.new(0, 5, 0, 5), ZIndex = 2,
	})
	items.___7 = index5:Create("Frame", {
		Parent = items.LeftTopPixels.Instance, Size = UDim2.new(0, 1, 0, 1), Position = UDim2.new(0, 2, 0, 0), ZIndex = 2,
		BackgroundTransparency = 0.12,
	})
	items.___7:AddToTheme({ BackgroundColor3 = "Background" })
	items.___8 = index5:Create("Frame", {
		Parent = items.LeftTopPixels.Instance, Size = UDim2.new(0, 1, 0, 1), BackgroundTransparency = 0.12,
		Position = UDim2.new(0, 3, 0, 0), ZIndex = 2,
	})
	items.___8:AddToTheme({ BackgroundColor3 = "Background" })
	items.___9 = index5:Create("Frame", {
		Parent = items.LeftTopPixels.Instance, Size = UDim2.new(0, 1, 0, 1), Position = UDim2.new(0, 4, 0, 0),
		BackgroundTransparency = 0.12, ZIndex = 2,
	})
	items.___9:AddToTheme({ BackgroundColor3 = "Background" })
	items.___10 = index5:Create("Frame", {
		Parent = items.LeftTopPixels.Instance, Size = UDim2.new(0, 1, 0, 1), Position = UDim2.new(0, 5, 0, 0),
		BackgroundTransparency = 0.12, ZIndex = 2,
	})
	items.___10:AddToTheme({ BackgroundColor3 = "Background" })
	items.___11 = index5:Create("Frame", {
		Parent = items.LeftTopPixels.Instance, Size = UDim2.new(0, 1, 0, 1), Position = UDim2.new(0, 3, 0, 1), ZIndex = 2,
		BackgroundTransparency = 0.12,
	})
	items.___11:AddToTheme({ BackgroundColor3 = "Background" })
	items.___12 = index5:Create("Frame", {
		Parent = items.LeftTopPixels.Instance, Size = UDim2.new(0, 1, 0, 1), Position = UDim2.new(0, 4, 0, 1), ZIndex = 2,
		BackgroundTransparency = 0.12,
	})
	items.___12:AddToTheme({ BackgroundColor3 = "Background" })
	t19.SetTransparency = function()
		items.MainFrame.Instance.BackgroundTransparency = index3.Flags.BackgroundTransparency
		items.LeftTabs.Instance.BackgroundTransparency = index3.Flags.BackgroundTransparency
		if touchEnabled then
			items.FloatingButton.Instance.BackgroundTransparency = index3.Flags.BackgroundTransparency
		end
		for k_, v79 in items do
			if k_:find("___") then
				v79.Instance.BackgroundTransparency = tonumber(index3.Flags.BackgroundTransparency)
			end
		end
	end
	index5:Create("UIGradient", {
		Parent = items.CloseIconAccent.Instance,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		Rotation = -115,
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	items.SettingsButton = index5:Create("TextButton", {
		Parent = items.MainFrame.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.20000000298023224, Position = UDim2.new(1, -98, 0, 11),
		Size = UDim2.new(0, 32, 0, 32), ZIndex = 2, TextSize = 14, BackgroundColor3 = Color3.fromRGB(27, 25, 29),
	})
	items.SettingsButton:AddToTheme({ BackgroundColor3 = "Element" })
	items.SearchButton = index5:Create("TextButton", {
		Parent = items.MainFrame.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.20000000298023224, Position = UDim2.new(1, -56, 0, 11),
		Size = UDim2.new(0, 32, 0, 32), ZIndex = 2, TextSize = 14, BackgroundColor3 = Color3.fromRGB(27, 25, 29),
	})
	items.SearchButton:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = items.SearchButton.Instance, CornerRadius = UDim.new(0, 7) })
	items.SearchIcon = index5:Create("ImageLabel", {
		Parent = items.SearchButton.Instance, ImageColor3 = Color3.fromRGB(240, 240, 240), ImageTransparency = 0.30000001192092896,
		Size = UDim2.new(0, 14, 0, 14), AnchorPoint = Vector2.new(0.5, 0.5), Image = "rbxassetid://3926305904",
		ImageRectOffset = Vector2.new(964, 324), ImageRectSize = Vector2.new(36, 36), BackgroundTransparency = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 3,
	})
	items.SearchIcon:AddToTheme({ ImageColor3 = "Text" })
	items.SearchIconAccent = index5:Create("Frame", {
		Parent = items.SearchButton.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, BackgroundTransparency = 1,
	})
	index5:Create("UICorner", { Parent = items.SearchIconAccent.Instance, CornerRadius = UDim.new(0, 7) })
	index5:Create("UIGradient", {
		Parent = items.SearchIconAccent.Instance,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		Rotation = -115,
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	items.SearchButton:OnHover(function()
		items.SearchIconAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
	end)
	items.SearchButton:OnHoverLeave(function()
		items.SearchIconAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
	end)
	items.SearchOverlay = index5:Create("TextButton", {
		Parent = index3.UnusedHolder.Instance, Visible = false, Text = "", AutoButtonColor = false, BackgroundTransparency = 0.4,
		Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0), ZIndex = 50, ClipsDescendants = true,
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
	})
	items.SearchPanel = index5:Create("Frame", {
		Parent = items.SearchOverlay.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.8, 0, 0.7, 0), ZIndex = 51, BackgroundColor3 = Color3.fromRGB(27, 27, 29),
	})
	items.SearchPanel:AddToTheme({ BackgroundColor3 = "Background" })
	index5:Create("UICorner", { Parent = items.SearchPanel.Instance, CornerRadius = UDim.new(0, 8) })
	index5:Create("UIStroke", {
		Parent = items.SearchPanel.Instance, Color = Color3.fromRGB(35, 33, 38), ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Thickness = 1,
	}):AddToTheme({ Color = "Outline" })
	items.SearchInputContainer = index5:Create("Frame", {
		Parent = items.SearchPanel.Instance, Position = UDim2.new(0, 12, 0, 12), Size = UDim2.new(1, -24, 0, 36), ZIndex = 52,
		BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	items.SearchInputContainer:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UISizeConstraint", {
		Parent = items.SearchPanel.Instance, MaxSize = Vector2.new(480, 380), MinSize = Vector2.new(300, 240),
	})
	index5:Create("UICorner", { Parent = items.SearchInputContainer.Instance, CornerRadius = UDim.new(0, 6) })
	items.SearchInputIcon = index5:Create("ImageLabel", {
		Parent = items.SearchInputContainer.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 16, 0, 16),
		AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(964, 324),
		ImageRectSize = Vector2.new(36, 36), BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0.5, 0), ZIndex = 53,
	})
	items.SearchInput = index5:Create("TextBox", {
		Parent = items.SearchInputContainer.Instance, FontFace = index3.Font, CursorPosition = -1,
		TextColor3 = Color3.fromRGB(240, 240, 240), Text = "", ZIndex = 53, Size = UDim2.new(1, -50, 1, 0),
		Position = UDim2.new(0, 38, 0, 0), PlaceholderColor3 = Color3.fromRGB(140, 140, 140), TextXAlignment = Enum.TextXAlignment.Left,
		PlaceholderText = "Search sections...", TextSize = 14, BackgroundTransparency = 1,
	})
	items.SearchInput:AddToTheme({ TextColor3 = "Text" })
	items.SearchResults = index5:Create("ScrollingFrame", {
		Parent = items.SearchPanel.Instance, Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
		Size = UDim2.new(1, -16, 1, -68), Position = UDim2.new(0, 8, 0, 56), BackgroundTransparency = 1, ZIndex = 52,
		CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	items.SearchResults:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UIListLayout", {
		Parent = items.SearchResults.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", {
		Parent = items.SearchResults.Instance, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4),
		PaddingRight = UDim.new(0, 8),
	})
	items.SearchEmpty = index5:Create("TextLabel", {
		Parent = items.SearchPanel.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(141, 141, 150), Text = "No sections found",
		Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0, 80), BackgroundTransparency = 1, TextSize = 13, Visible = false,
		ZIndex = 52,
	})
	items.SearchHint = index5:Create("TextLabel", {
		Parent = items.SearchPanel.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(120, 120, 130), Text = "ESC to close",
		Size = UDim2.new(1, -24, 0, 20), AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 12, 1, -8), BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Right, TextSize = 12, ZIndex = 52,
	})
	local b17 = false
	local t20 = {}
	local function f30()
		for _, v79 in t20 do
			v79.Frame:Clean()
		end
		t20 = {}
	end
	local function f31(arg3)
		local parent = arg3.Items.Section.Instance.Parent
		if not parent or not parent:IsA("ScrollingFrame") then
			return
		end
		local n = arg3.Items.Section.Instance.AbsolutePosition.Y - parent.AbsolutePosition.Y + parent.CanvasPosition.Y
		index4:Create(parent, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { CanvasPosition = Vector2.new(0, math.max(0, n - 10)) }, true)
		local topBackground = arg3.Items.TopBackground
		local backgroundColor3 = topBackground.Instance.BackgroundColor3
		local t21 = { BackgroundColor3 = index3.Theme.Accent }
		topBackground:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), t21)
		task.delay(0.6, function()
			local t22 = { BackgroundColor3 = backgroundColor3 }
			topBackground:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), t22)
		end)
	end
	local function f32(arg3, arg4)
		local tween = index5:Create("TextButton", {
			Parent = items.SearchResults.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
			AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 56), ZIndex = 53, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(31, 29, 33),
		})
		tween:AddToTheme({ BackgroundColor3 = "Section Top" })
		index5:Create("UICorner", { Parent = tween.Instance, CornerRadius = UDim.new(0, 6) })
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, Size = UDim2.new(0, 32, 0, 32), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 10, 0.5, 0),
			ZIndex = 54, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		})
		tween2:AddToTheme({ BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(0, 6) })
		local tween3 = index5:Create("ImageLabel", {
			Parent = tween2.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 16, 0, 16),
			AnchorPoint = Vector2.new(0.5, 0.5), Image = "rbxassetid://" .. (arg4.Icon or "123944728972740"), BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 55,
		})
		index5:Create("UIGradient", { Parent = tween3.Instance }):AddToTheme({ Color = function()
			local v79 = 1
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v79, accentGradient) })
		end })
		local tween4 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "", RichText = true,
			Size = UDim2.new(1, -60, 0, 16), Position = UDim2.new(0, 52, 0, 10), BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 54, TextSize = 14,
		})
		tween4:AddToTheme({ TextColor3 = "Text" })
		local tween5 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(160, 160, 160), TextTransparency = 0.2,
			Text = arg4.Description ~= "" and arg4.Description or "(no description)", Size = UDim2.new(1, -60, 0, 14),
			Position = UDim2.new(0, 52, 0, 30), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 54, TextSize = 12,
		})
		local tween6 = index5:Create("Frame", {
			Parent = tween.Instance, Size = UDim2.new(0, 3, 0.7, 0), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
			BackgroundTransparency = 1, ZIndex = 55,
		})
		index5:Create("UICorner", { Parent = tween6.Instance, CornerRadius = UDim.new(1, 0) })
		index5:Create("UIGradient", { Parent = tween6.Instance, Rotation = 90 }):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		tween:OnHover(function()
			tween:Tween(nil, { BackgroundTransparency = 0 })
			tween6:Tween(nil, { BackgroundTransparency = 0 })
		end)
		tween:OnHoverLeave(function()
			tween:Tween(nil, { BackgroundTransparency = 0.2 })
			tween6:Tween(nil, { BackgroundTransparency = 1 })
		end)
		return { Frame = tween, Title = tween4, Desc = tween5, Icon = tween3, Page = arg3, Section = arg4 }
	end
	local function f33(arg3, arg4)
		if not arg4 or arg4 == "" then
			return arg3
		end
		local v79 = string.lower(arg3)
		local v80 = string.lower(arg4)
		local v81 = index3:EscapePattern(v80)
		local n = 1
		local str8 = ""
		while true do
			local v82, v83 = string.find(v79, v81, n)
			if v82 then
				local v84 = index3
				local toRich = v84.ToRich
				str8 = (str8 .. string.sub(arg3, n, v82 - 1)) .. toRich(v84, string.sub(arg3, v82, v83), index3.Theme.Accent)
				n = v83 + 1
				continue
			end
			break
		end
		return str8 .. string.sub(arg3, n)
	end
	local function f34(arg3)
		f30()
		arg3 = arg3 or ""
		local v79 = string.lower(arg3)
		local b18 = false
		for _, v80 in t19.Pages do
			for _, v81 in v80.Sections do
				local name = v81.Name or ""
				local description = v81.Description or ""
				local name2 = v80.Name or ""
				local b19 = arg3 == ""
				if not b19 then
					local escapePattern = index3.EscapePattern
					b19 = string.find(string.lower(name), escapePattern(index3, v79))
				end
				if not b19 then
					local escapePattern = index3.EscapePattern
					b19 = string.find(string.lower(description), escapePattern(index3, v79))
				end
				if not b19 then
					local escapePattern = index3.EscapePattern
					b19 = string.find(string.lower(name2), escapePattern(index3, v79))
				end
				if b19 then
					local v82 = f32(v80, v81)
					local v83 = f33(name2, arg3)
					local v84 = f33(name, arg3)
					v82.Title.Instance.Text = index3:ToRich(v83, Color3.fromRGB(141, 141, 150)) .. "  ›  " .. v84
					if arg3 ~= "" and description ~= "" then
						v82.Desc.Instance.Text = f33(description, arg3)
						v82.Desc.Instance.RichText = true
					end
					v82.Frame:Connect("MouseButton1Down", function()
						t19:CloseSearch()
						if not v80.Active then
							for _, v85 in t19.Pages do
								v85:Turn(v85 == v80)
							end
						end
						task.delay(0.4, function()
							f31(v81)
						end)
					end)
					table.insert(t20, v82)
					b18 = true
				end
			end
		end
		items.SearchEmpty.Instance.Visible = not b18
	end
	t19.OpenSearch = function()
		if b17 then
			return
		end
		b17 = true
		items.SearchOverlay.Instance.Parent = items.MainFrame.Instance
		items.SearchOverlay.Instance.Visible = true
		items.SearchInput.Instance.Text = ""
		f34("")
		items.SearchOverlay.Instance.BackgroundTransparency = 1
		items.SearchOverlay:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 0.4 })
		items.SearchPanel.Instance.Position = UDim2.new(0.5, 0, 0.5, -24)
		items.SearchPanel:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, 0, 0.5, 0) })
		task.wait(0.05)
		items.SearchInput.Instance:CaptureFocus()
	end
	t19.CloseSearch = function()
		if not b17 then
			return
		end
		b17 = false
		items.SearchInput.Instance:ReleaseFocus()
		items.SearchOverlay:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
		task.delay(0.2, function()
			if not b17 then
				items.SearchOverlay.Instance.Visible = false
				items.SearchOverlay.Instance.Parent = index3.UnusedHolder.Instance
				f30()
			end
		end)
	end
	index3:Connect(items.SearchInput.Instance:GetPropertyChangedSignal("Text"), function()
		f34(items.SearchInput.Instance.Text)
	end)
	items.SearchButton:Connect("MouseButton1Down", function()
		t19:OpenSearch()
	end)
	items.SearchOverlay:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			if not index3:IsMouseOverFrame(items.SearchPanel) then
				t19:CloseSearch()
			end
		end
	end)
	index3:Connect(UserInputService.InputBegan, function(arg3)
		if arg3.KeyCode == Enum.KeyCode.Escape and b17 then
			t19:CloseSearch()
		end
	end)
	items.SearchOverlay.Instance.Active = true
	index5:Create("UICorner", { Parent = items.SettingsButton.Instance, CornerRadius = UDim.new(0, 7) })
	items.SettingsIcon = index5:Create("ImageLabel", {
		Parent = items.SettingsButton.Instance, ImageColor3 = Color3.fromRGB(240, 240, 240), ImageTransparency = 0.30000001192092896,
		Size = UDim2.new(0, 15, 0, 14), AnchorPoint = Vector2.new(0.5, 0.5), Image = "rbxassetid://122669828593160",
		BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 3,
	})
	items.SettingsIcon:AddToTheme({ ImageColor3 = "Text" })
	items.SettingsIconAccent = index5:Create("Frame", {
		Parent = items.SettingsButton.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, BackgroundTransparency = 1,
	})
	index5:Create("UICorner", { Parent = items.SettingsIconAccent.Instance, CornerRadius = UDim.new(0, 7) })
	index5:Create("UIGradient", {
		Parent = items.SettingsIconAccent.Instance,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		Rotation = -115,
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	items.SettingsButton:OnHover(function()
		items.SettingsIconAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
	end)
	items.SettingsButton:OnHoverLeave(function()
		items.SettingsIconAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
	end)
	items.CloseButton:OnHover(function()
		items.CloseIconAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
	end)
	items.CloseButton:OnHoverLeave(function()
		items.CloseIconAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
	end)
	local t21 = { IsOpen = false, Name = "" .. #index3.Sections, Items = {}, IsSettings = true, Elements = {} }
	local items2 = {
		Settings = index5:Create("Frame", {
			Parent = index3.UnusedHolder.Instance, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.89496046304702759, 0, 0.29451856017112732, 0), Size = UDim2.new(0, 245, 0, 159), ZIndex = 2,
			AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(21, 21, 24),
		}),
	}
	items2.Settings:AddToTheme({ BackgroundColor3 = "Section Background 2" })
	index5:Create("UICorner", { Parent = items2.Settings.Instance, CornerRadius = UDim.new(0, 6) })
	items2.CloseButton = index5:Create("TextButton", {
		Parent = items2.Settings.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 8, 1, -8), Size = UDim2.new(1, -16, 0, 32), ZIndex = 2, TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	items2.CloseButton:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = items2.CloseButton.Instance, CornerRadius = UDim.new(0, 4) })
	items2.Text = index5:Create("TextLabel", {
		Parent = items2.CloseButton.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = "Close", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 2, TextSize = 14,
	})
	items2.Content = index5:Create("ScrollingFrame", {
		Parent = items2.Settings.Instance, AutomaticCanvasSize = Enum.AutomaticSize.Y, Selectable = false, Size = UDim2.new(1, -8, 1, -46),
		Position = UDim2.new(0, 4, 0, 4), ScrollBarThickness = 2, BackgroundTransparency = 1, CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	items2.Content:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UIListLayout", {
		Parent = items2.Content.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", {
		Parent = items2.Content.Instance, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingRight = UDim.new(0, 4),
		PaddingLeft = UDim.new(0, 4),
	})
	items2.Accent = index5:Create("Frame", {
		Parent = items2.CloseButton.Instance, Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
	})
	local v79 = 1
	items2.Gradient = index5:Create("UIGradient", {
		Parent = items2.Accent.Instance, Enabled = true, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(v79, Color3.fromRGB(143, 143, 143)) }),
	})
	items2.Gradient:AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	index5:Create("UICorner", { Parent = items2.Accent.Instance, CornerRadius = UDim.new(0, 4) })
	index5:Create("UICorner", { Parent = items2.CloseButton.Instance, CornerRadius = UDim.new(0, 4) })
	items2.CloseButton:OnHover(function()
		items2.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
	end)
	items2.CloseButton:OnHoverLeave(function()
		items2.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
	end)
	local connection = nil
	local b18 = false
	t21.SetOpen = function(arg3, isOpen)
		if b18 then
			return
		end
		t21.IsOpen = isOpen
		b18 = true
		if t21.IsOpen then
			for _, v80 in t21.Elements do
				v80:RefreshPosition(true)
				task.wait(0.03)
			end
			items2.Settings.Instance.Visible = true
			items2.Settings.Instance.Parent = index3.Holder.Instance
			connection = RunService.RenderStepped:Connect(function()
				items2.Settings.Instance.Position = UDim2.new(0, items.SettingsIcon.Instance.AbsolutePosition.X, 0, items.SettingsIcon.Instance.AbsolutePosition.Y + items.SettingsButton.Instance.AbsoluteSize.Y + 108)
				items2.Settings.Instance.Size = UDim2.new(0, 325, 0, 230)
			end)
			for _, v80 in index3.OpenFrames do
				if v80 ~= t21 then
					v80:SetOpen(false)
				end
			end
			index3.OpenFrames[t21] = t21
		else
			for _, v80 in t21.Elements do
				v80:RefreshPosition(false)
			end
			if index3.OpenFrames[t21] then
				index3.OpenFrames[t21] = nil
			end
			if connection then
				connection:Disconnect()
				connection = nil
			end
		end
		local descendants = items2.Settings.Instance:GetDescendants()
		table.insert(descendants, items2.Settings.Instance)
		local v80 = nil
		for _, v81 in descendants do
			local property = index4:GetProperty(v81)
			if property then
				if not v81.ClassName:find("UI") then
					v81.ZIndex = t21.IsOpen and 7 or 1
					items2.Text.Instance.ZIndex = 8
				end
				if type(property) == "table" then
					for _, v82 in property do
						v80 = index4:FadeItem(v81, v82, isOpen, index3.FadeSpeed)
					end
				else
					v80 = index4:FadeItem(v81, property, isOpen, index3.FadeSpeed)
				end
			end
		end
		v80.Tween.Completed:Connect(function()
			b18 = false
			items2.Settings.Instance.Visible = t21.IsOpen
			task.wait(0.2)
			items2.Settings.Instance.Parent = not t21.IsOpen and index3.UnusedHolder.Instance or index3.Holder.Instance
		end)
	end
	items2.CloseButton:Connect("MouseButton1Down", function()
		t21:SetOpen(false)
	end)
	items.SettingsButton:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			t21:SetOpen(not t21.IsOpen)
		end
	end)
	t21.Items = items2
	setmetatable(t21, index3.Sections)
	t21:Label("First gradient color"):Colorpicker({
		Flag = "AccentColor", Default = index3.Theme.Accent,
		Callback = function(accent)
			index3.Theme.Accent = accent
			index3:ChangeTheme("Accent", accent)
		end,
	})
	t21:Label("Second gradient color"):Colorpicker({
		Flag = "AccentGradientColor", Default = index3.Theme.AccentGradient,
		Callback = function(accentGradient)
			index3.Theme.AccentGradient = accentGradient
			index3:ChangeTheme("AccentGradient", accentGradient)
		end,
	})
	t21:Dropdown({
		Name = "Font weight", Flag = "FontStyle", Default = "SemiBold", Items = { "Light", "Regular", "SemiBold" }, Searchable = true,
		Callback = function(arg3)
			local v80 = index3.Fonts[arg3]
			if v80 then
				index3.Font = v80
				index3:UpdateText()
			end
		end,
	})
	t21:Slider({
		Name = "Background Transparency", Default = 0, Decimals = 0.01, Max = 1, Min = 0, Suffix = "%", Flag = "BackgroundTransparency",
		Callback = function(arg3)
			t19:SetTransparency(arg3)
		end,
	})
	t21:Keybind({
		Name = "Menu Keybind", Flag = "MenuBind", Default = Enum.KeyCode.Z,
		Callback = function(arg3)
			t19:SetOpen(arg3)
		end,
	})
	t19.Items = items
	local b19 = false
	t19.SetCenter = function()
		local absolutePosition = items.MainFrame.Instance.AbsolutePosition
		task.wait()
		items.MainFrame.Instance.AnchorPoint = Vector2.new(0, 0)
		items.MainFrame.Instance.Position = UDim2.new(0, absolutePosition.X, 0, absolutePosition.Y)
	end
	t19.SetOpen = function(arg3, isOpen)
		if b19 then
			return
		end
		t19.IsOpen = isOpen
		b19 = true
		if t19.IsOpen then
			items.MainFrame.Instance.Visible = true
		end
		local descendants = items.MainFrame.Instance:GetDescendants()
		table.insert(descendants, items.MainFrame.Instance)
		local v80 = nil
		for _, v81 in descendants do
			local property = index4:GetProperty(v81)
			if property then
				if type(property) == "table" then
					for _, v82 in property do
						v80 = index4:FadeItem(v81, v82, isOpen, index3.FadeSpeed)
					end
				else
					v80 = index4:FadeItem(v81, property, isOpen, index3.FadeSpeed)
				end
			end
		end
		v80.Tween.Completed:Connect(function()
			b19 = false
			items.MainFrame.Instance.Visible = t19.IsOpen
		end)
	end
	items.FloatingButton:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			t19:SetOpen(not t19.IsOpen)
		end
	end)
	t19.Init = function()
		for _, v80 in t19.Pages do
			if v80.Active then
				for _, v81 in v80.Sections do
					task.spawn(function()
						v81:TweenElements(true)
					end)
				end
			end
		end
	end
	t19:SetCenter()
	task.wait()
	t19:SetOpen(true)
	return setmetatable(t19, index3)
end

index3.Category = function(arg, arg2)
	({
		Category = index5:Create("TextLabel", {
			Parent = arg.Items.LeftTabs.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
			TextTransparency = 0.40000000596046448, Text = arg2, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(1, 0, 0, 15),
			BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2, TextSize = 14,
		}),
	}).Category:AddToTheme({ TextColor3 = "Text" })
end

index3.Page = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = {
		Window = arg, Name = t18.Name or t18.name or "Page", Icon = t18.Icon or t18.icon or "100050851789190",
		Columns = t18.Columns or t18.columns or 2, Items = {}, ColumnsData = {}, Sections = {}, Active = false,
	}
	local items = {
		Inactive = index5:Create("TextButton", {
			Parent = t19.Window.Items.LeftTabs.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
			AutoButtonColor = false, BackgroundTransparency = 1, Size = UDim2.new(0, 200, 0, 40), ZIndex = 2, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(124, 77, 255),
		}),
	}
	items.Inactive:AddToTheme({ BackgroundColor3 = "Accent" })
	index5:Create("UICorner", { Parent = items.Inactive.Instance, CornerRadius = UDim.new(0, 5) })
	local v78 = index5
	local create = v78.Create
	local v79 = "UIGradient"
	local t20 = { Parent = items.Inactive.Instance, Name = "\0" }
	local t21 = {}
	local v80 = NumberSequenceKeypoint.new(0, 0.41874998807907104)
	local v81 = NumberSequenceKeypoint.new(0.445, 0.78125)
	local v82 = NumberSequenceKeypoint.new(0.751, 0.9375)
	t21[1] = v80
	t21[2] = v81
	t21[3] = v82
	local values = table.pack(NumberSequenceKeypoint.new(1, 1))
	table.move(values, 1, values.n, 4, t21)
	t20.Transparency = NumberSequence.new(t21)
	items.Gradient = create(v78, v79, t20)
	items.Icon = index5:Create("ImageLabel", {
		Parent = items.Inactive.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 18, 0, 18),
		AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://" .. t19.Icon, BackgroundTransparency = 1,
		Position = UDim2.new(0, 16, 0.5, 0), ZIndex = 2,
	})
	index5:Create("UIGradient", { Parent = items.Icon.Instance, Rotation = -115 }):AddToTheme({ Color = function()
		local v83 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v83, accentGradient) })
	end })
	items.Text = index5:Create("TextLabel", {
		Parent = items.Inactive.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = t19.Name,
		AutomaticSize = Enum.AutomaticSize.X, AnchorPoint = Vector2.new(0, 0.5), Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1,
		Position = UDim2.new(0, 45, 0.5, 0), ZIndex = 2, TextSize = 14,
	})
	items.Text:AddToTheme({ TextColor3 = "Text" })
	items.Page = index5:Create("Frame", {
		Parent = index3.UnusedHolder.Instance, Visible = false, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), ZIndex = 2,
		Position = UDim2.new(0, 0, 0, 60),
	})
	index5:Create("UIListLayout", {
		Parent = items.Page.Instance, FillDirection = Enum.FillDirection.Horizontal, HorizontalFlex = Enum.UIFlexAlignment.Fill,
		Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder, VerticalFlex = Enum.UIFlexAlignment.Fill,
	})
	index5:Create("UIPadding", {
		Parent = items.Page.Instance, PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10), PaddingRight = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 10),
	})
	for i = 1, t19.Columns do
		local tween = index5:Create("ScrollingFrame", {
			Parent = items.Page.Instance, ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Active = true,
			AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 0, BackgroundTransparency = 1,
			Size = UDim2.new(0, 100, 0, 100), ZIndex = 2, CanvasSize = UDim2.new(0, 0, 0, 0),
		})
		index5:Create("UIListLayout", {
			Parent = tween.Instance, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder,
		})
		t19.ColumnsData[i] = tween
	end
	t19.Items = items
	local b15 = false
	t19.Turn = function(arg3, active)
		if b15 then
			return
		end
		t19.Active = active
		b15 = true
		items.Page.Instance.Visible = active
		items.Page.Instance.Parent = active and t19.Window.Items.Content.Instance or index3.UnusedHolder.Instance
		if t19.Active then
			items.Inactive:Tween(nil, { BackgroundTransparency = 0.25 })
			items.Page:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) })
			for _, v83 in t19.Sections do
				task.spawn(function()
					v83:TweenElements(true, true)
				end)
			end
		else
			items.Inactive:Tween(nil, { BackgroundTransparency = 1 })
			items.Page:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 60) })
		end
		local children = items.Page.Instance:GetChildren()
		table.insert(children, items.Page.Instance)
		local v83 = nil
		for _, v84 in children do
			local property = index4:GetProperty(v84)
			if property then
				local v85 = "table"
				if type(property) == v85 then
					for _, v86 in property do
						v83 = index4:FadeItem(v84, v86, active, index3.FadeSpeed)
					end
				else
					v83 = index4:FadeItem(v84, property, active, index3.FadeSpeed)
				end
			end
		end
		if not v83 then
			b15 = false
			return
		end
		index3:Connect(v83.Tween.Completed, function()
			b15 = false
		end)
	end
	items.Inactive:Connect("MouseButton1Down", function()
		for _, v83 in t19.Window.Pages do
			if v83 == t19 and t19.Active then
				return
			end
			v83:Turn(v83 == t19)
		end
	end)
	if #t19.Window.Pages == 0 then
		t19:Turn(true)
	end
	table.insert(t19.Window.Pages, t19)
	return setmetatable(t19, index3.Pages)
end

index3.Pages.GlobalChat = function(arg, arg2)
	local globalChatt = {}
	index3.GlobalChatt = globalChatt
	local t18 = {
		GlobalChat = index5:Create("Frame", {
			Parent = arg.ColumnsData[arg2].Instance, BackgroundTransparency = 0.30000001192092896, Position = UDim2.new(0, 0, 0, 0),
			Size = UDim2.new(1, 0, 1, 0), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(27, 25, 29),
		}),
	}
	t18.GlobalChat:AddToTheme({ BackgroundColor3 = "Section Background 2" })
	t18.GlobalChat:MakeDraggable()
	index5:Create("UICorner", { Parent = t18.GlobalChat.Instance, CornerRadius = UDim.new(0, 6) })
	t18.Title = index5:Create("TextLabel", {
		Parent = t18.GlobalChat.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "GLOBAL CHAT",
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 13),
		ZIndex = 2, TextSize = 16,
	})
	t18.Title:AddToTheme({ TextColor3 = "Text" })
	t18.SubTitle = index5:Create("TextLabel", {
		Parent = t18.GlobalChat.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.40000000596046448, Text = "Chat with other users here.", AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 30), ZIndex = 2, TextSize = 14,
	})
	t18.SubTitle:AddToTheme({ TextColor3 = "Text" })
	t18.Message = index5:Create("Frame", {
		Parent = t18.GlobalChat.Instance, Active = true, AnchorPoint = Vector2.new(0, 1), Selectable = true, BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 1, -12), Size = UDim2.new(1, -66, 0, 32), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 29),
	})
	t18.Message:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t18.Message.Instance, CornerRadius = UDim.new(0, 4) })
	t18.Background = index5:Create("Frame", {
		Parent = t18.Message.Instance, Active = true, Size = UDim2.new(1, 0, 1, 0), Selectable = true, ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	t18.Background:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t18.Background.Instance, CornerRadius = UDim.new(0, 4) })
	t18.Input = index5:Create("TextBox", {
		Parent = t18.Background.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "", ZIndex = 2,
		Size = UDim2.new(1, -20, 0, 15), Position = UDim2.new(0, 10, 0, 8), BackgroundTransparency = 1,
		PlaceholderColor3 = Color3.fromRGB(185, 185, 185), TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Message...",
		TextSize = 14,
	})
	t18.Input:AddToTheme({ TextColor3 = "Text" })
	t18.SendButton = index5:Create("TextButton", {
		Parent = t18.GlobalChat.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -12, 1, -12), Size = UDim2.new(0, 32, 0, 32), TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(26, 26, 29),
	})
	t18.SendButton:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t18.SendButton.Instance, CornerRadius = UDim.new(0, 4) })
	t18.SendIcon = index5:Create("ImageLabel", {
		Parent = t18.SendButton.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), ImageTransparency = 0.2,
		AnchorPoint = Vector2.new(0.5, 0.5), Image = "rbxassetid://101636617799068", BackgroundTransparency = 1, ZIndex = 3,
		Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 22, 0, 22),
	})
	t18.Accent = index5:Create("Frame", {
		Parent = t18.SendButton.Instance, Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
	})
	index5:Create("UICorner", { Parent = t18.Accent.Instance, CornerRadius = UDim.new(0, 4) })
	index5:Create("UIGradient", {
		Parent = t18.Accent.Instance, Enabled = true, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local v78 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
	end })
	t18.SendButton:OnHover(function()
		t18.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
	end)
	t18.SendButton:OnHoverLeave(function()
		t18.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
	end)
	t18.Messages = index5:Create("ScrollingFrame", {
		Parent = t18.GlobalChat.Instance, ScrollBarImageColor3 = Color3.fromRGB(124, 163, 255), Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, Size = UDim2.new(1, -24, 1, -115), BackgroundTransparency = 1,
		Position = UDim2.new(0, 12, 0, 60), CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	t18.Messages:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UIListLayout", {
		Parent = t18.Messages.Instance, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", {
		Parent = t18.Messages.Instance, PaddingTop = UDim.new(0, 0), PaddingBottom = UDim.new(0, 0), PaddingRight = UDim.new(0, 10),
		PaddingLeft = UDim.new(0, 0),
	})
	t18.Status = index5:Create("Frame", {
		Parent = t18.GlobalChat.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, Position = UDim2.new(1, -12, 0, 10),
		Size = UDim2.new(0, 100, 0, 24),
	})
	t18.StatusCircle = index5:Create("Frame", {
		Parent = t18.Status.Instance, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, 12, 0, 12),
		BackgroundColor3 = Color3.fromRGB(255, 210, 62),
	})
	t18.Glow = index5:Create("ImageLabel", {
		Parent = t18.StatusCircle.Instance, ImageColor3 = Color3.fromRGB(255, 210, 62), ScaleType = Enum.ScaleType.Slice,
		ImageTransparency = 0.30000001192092896, Size = UDim2.new(1, 8, 1, 8), AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "http://www.roblox.com/asset/?id=18245826428", BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 2,
		SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79)),
	})
	index5:Create("UICorner", { Parent = t18.StatusCircle.Instance, CornerRadius = UDim.new(1, 0) })
	t18.StatusText = index5:Create("TextLabel", {
		Parent = t18.Status.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(255, 210, 62), Text = "67 Active | Connected",
		AnchorPoint = Vector2.new(1, 0.5), Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(1, -20, 0.5, 0),
		AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
	})
	globalChatt.SetVisibility = function(arg3, visible)
		t18.GlobalChat.Instance.Visible = visible
		t18.GlobalChat.Instance.Parent = visible and Data.MainFrame.Instance or index3.UnusedHolder
	end
	globalChatt.SetStatus = function(arg3, text, textColor3)
		t18.StatusText.Instance.Text = text
		t18.StatusText.Instance.TextColor3 = textColor3
		t18.StatusCircle.Instance.BackgroundColor3 = textColor3
	end
	globalChatt.SetStatusText = function(arg3, text)
		if not Done then
			t18.StatusText.Instance.TextColor3 = Color3.fromRGB(62, 255, 91)
			t18.Glow.Instance.ImageColor3 = Color3.fromRGB(62, 255, 91)
			t18.StatusCircle.Instance.BackgroundColor3 = Color3.fromRGB(62, 255, 91)
			Done = true
		end
		t18.StatusText.Instance.Text = text
	end
	local v78 = nil
	globalChatt.OnMessageSendPressed = function(arg3, arg4)
		v78 = arg4
	end
	globalChatt.GetTypedMessage = function()
		return t18.Input.Instance.Text
	end
	globalChatt.ClearText = function()
		t18.Input.Instance.Text = ""
	end
	globalChatt.SendMessage = function(arg3, arg4, arg5, arg6, arg7)
		local t19 = {}
		if not arg7 then
			t19.Message1 = index5:Create("Frame", {
				Parent = t18.Messages.Instance, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 45), ZIndex = 2,
				AutomaticSize = Enum.AutomaticSize.Y,
			})
			t19.PlayerName = index5:Create("TextLabel", {
				Parent = t19.Message1.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = arg5,
				Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, RichText = true, Position = UDim2.new(0, 38, 0, 0),
				TextTransparency = 0.3, ZIndex = 2, AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
			})
			t19.PlayerName:AddToTheme({ TextColor3 = "Text" })
			t19.RealMessage = index5:Create("Frame", {
				Parent = t19.Message1.Instance, Position = UDim2.new(0, 38, 0, 20), ZIndex = 2, AutomaticSize = Enum.AutomaticSize.XY,
				BackgroundColor3 = Color3.fromRGB(27, 25, 29),
			})
			t19.RealMessage:AddToTheme({ BackgroundColor3 = "Background" })
			index5:Create("UISizeConstraint", { Parent = t19.RealMessage.Instance, MaxSize = Vector2.new(370, 70) })
			index5:Create("UICorner", { Parent = t19.RealMessage.Instance, CornerRadius = UDim.new(0, 4) })
			t19.MessageText = index5:Create("TextLabel", {
				Parent = t19.RealMessage.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = arg6,
				BackgroundTransparency = 1, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left,
				AutomaticSize = Enum.AutomaticSize.XY, TextSize = 14, ZIndex = 2,
			})
			t19.MessageText:AddToTheme({ TextColor3 = "Text" })
			index5:Create("UIPadding", {
				Parent = t19.RealMessage.Instance, PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10),
			})
			t19.Avatar = index5:Create("ImageLabel", {
				Parent = t19.Message1.Instance, AnchorPoint = Vector2.new(0, 0.5), Image = arg4, BackgroundTransparency = 1,
				Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(0, 26, 0, 30), ZIndex = 2,
			})
			index5:Create("UICorner", { Parent = t19.Avatar.Instance, CornerRadius = UDim.new(0, 4) })
		else
			t19.Message1 = index5:Create("Frame", {
				Parent = t18.Messages.Instance, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 45), ZIndex = 2,
				AutomaticSize = Enum.AutomaticSize.Y,
			})
			t19.PlayerName = index5:Create("TextLabel", {
				Parent = t19.Message1.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = arg5,
				RichText = true, AnchorPoint = Vector2.new(1, 0), Size = UDim2.new(0, 0, 0, 15), ZIndex = 2, TextTransparency = 0.3,
				BackgroundTransparency = 1, Position = UDim2.new(1, -38, 0, 0), AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
			})
			t19.PlayerName:AddToTheme({ TextColor3 = "Text" })
			t19.RealMessage = index5:Create("Frame", {
				Parent = t19.Message1.Instance, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -38, 0, 20), ZIndex = 2,
				AutomaticSize = Enum.AutomaticSize.XY, BackgroundColor3 = Color3.fromRGB(27, 25, 29),
			})
			t19.RealMessage:AddToTheme({ BackgroundColor3 = "Background" })
			index5:Create("UISizeConstraint", { Parent = t19.RealMessage.Instance, MaxSize = Vector2.new(370, 75) })
			index5:Create("UICorner", { Parent = t19.RealMessage.Instance, CornerRadius = UDim.new(0, 4) })
			t19.MessageText = index5:Create("TextLabel", {
				Parent = t19.RealMessage.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = arg6,
				BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, AutomaticSize = Enum.AutomaticSize.XY, ZIndex = 2,
				TextWrapped = true, TextSize = 14,
			})
			t19.MessageText:AddToTheme({ TextColor3 = "Text" })
			index5:Create("UIPadding", {
				Parent = t19.RealMessage.Instance, PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10), PaddingLeft = UDim.new(0, 10),
			})
			t19.Avatar = index5:Create("ImageLabel", {
				Parent = t19.Message1.Instance, AnchorPoint = Vector2.new(1, 0.5), Image = arg4, ZIndex = 2, BackgroundTransparency = 1,
				Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, 30, 0, 30),
			})
			index5:Create("UICorner", { Parent = t19.Avatar.Instance, CornerRadius = UDim.new(0, 4) })
		end
	end
	t18.SendButton:Connect("MouseButton1Down", function()
		if globalChatt:GetTypedMessage() == "" then
			return
		end
		v78()
	end)
	t18.Messages:Connect("ChildAdded", function()
		task.wait()
		t18.Messages:Tween(nil, {
			CanvasPosition = Vector2.new(0, t18.Messages.Instance.AbsoluteCanvasSize.Y - t18.Messages.Instance.AbsoluteSize.Y),
		})
	end)
	for _, v79 in t18.GlobalChat.Instance:GetDescendants() do
		if not v79.ClassName:find("UI") then
			v79.ZIndex = 2
		end
	end
	t18.GlobalChat.Instance.ZIndex = 2
	t18.SendIcon.Instance.ZIndex = 3
	return globalChatt
end

index3.Pages.Section = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = {
		Window = arg.Window, Page = arg, Name = t18.Name or t18.name or "Section", Description = t18.Description or t18.Description or "",
		Icon = t18.Icon or t18.icon or "123944728972740", Side = t18.Side or t18.side or 1, Items = {}, IsActive = true,
		IsCollapsed = false, ExpandedHeight = nil, Elements = {},
	}
	local items = {
		Section = index5:Create("Frame", {
			Parent = t19.Page.ColumnsData[t19.Side].Instance, BackgroundTransparency = 0.64999997615814209, ClipsDescendants = true,
			Size = UDim2.new(1, 0, 0, 45), ZIndex = 2, AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(29, 28, 32),
		}),
	}
	items.Section:AddToTheme({ BackgroundColor3 = "Section Background 2" })
	items.Top = index5:Create("Frame", {
		Parent = items.Section.Instance, BackgroundTransparency = 0.64999997615814209, Size = UDim2.new(1, 0, 0, 55), ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(31, 31, 36),
	})
	items.Top:AddToTheme({ BackgroundColor3 = "Outline" })
	items.TopBackground = index5:Create("Frame", {
		Parent = items.Top.Instance, BackgroundTransparency = 0.64999997615814209, Position = UDim2.new(0, 1, 0, 1),
		Size = UDim2.new(1, -2, 1, -2), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 26),
	})
	items.TopBackground:AddToTheme({ BackgroundColor3 = "Section Top" })
	items.Icon = index5:Create("ImageLabel", {
		Parent = items.TopBackground.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(0, 21, 0, 24),
		AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://" .. t19.Icon, BackgroundTransparency = 1,
		Position = UDim2.new(0, 15, 0.5, 0), ZIndex = 2,
	})
	index5:Create("UIGradient", {
		Parent = items.Icon.Instance,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 131, 131)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	items.Description = index5:Create("TextLabel", {
		Parent = items.TopBackground.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(183, 183, 183), Text = t19.Description,
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(0, 50, 0, 28),
		TextTransparency = 0.4, ZIndex = 2, TextSize = 15,
	})
	items.Description:AddToTheme({ TextColor3 = "Text" })
	index5:Create("UICorner", { Parent = items.TopBackground.Instance, CornerRadius = UDim.new(0, 4) })
	items.Title = index5:Create("TextLabel", {
		Parent = items.TopBackground.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(248, 248, 248), Text = t19.Name,
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1, Position = UDim2.new(0, 50, 0, 10),
		ZIndex = 2, TextSize = 15,
	})
	items.Title:AddToTheme({ TextColor3 = "Text" })
	items.Toggle = index5:Create("TextButton", {
		Parent = items.Top.Instance, Active = true, Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5),
		Selectable = false, Position = UDim2.new(1, -15, 0.5, 0), Size = UDim2.new(0, 26, 0, 16), ZIndex = 2,
	})
	items.Circle = index5:Create("Frame", {
		Parent = items.Toggle.Instance, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0),
		Size = UDim2.new(0, 8, 0, 8), ZIndex = 2,
	})
	items.Circle:AddToTheme({ BackgroundColor3 = "Text" })
	index5:Create("UICorner", { Parent = items.Circle.Instance, CornerRadius = UDim.new(0, 99999) })
	index5:Create("UICorner", { Parent = items.Toggle.Instance, CornerRadius = UDim.new(0, 9) })
	items.Gradient = index5:Create("UIGradient", {
		Parent = items.Toggle.Instance, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	})
	items.Gradient:AddToTheme({ Color = function()
		local v78 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
	end })
	index5:Create("UICorner", { Parent = items.Top.Instance, CornerRadius = UDim.new(0, 4) })
	items.Fill = index5:Create("Frame", {
		Parent = items.Top.Instance, BackgroundTransparency = 1, Position = UDim2.new(0, 1, 1, -4), Size = UDim2.new(1, -2, 0, 4),
		ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 26),
	})
	items.Fill:AddToTheme({ BackgroundColor3 = "Section Background" })
	index5:Create("UICorner", { Parent = items.Fill.Instance, CornerRadius = UDim.new(0, 4) })
	items.TopFills = index5:Create("Frame", {
		Parent = items.Top.Instance, AnchorPoint = Vector2.new(0, 1), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 1, 0),
		Size = UDim2.new(1, 0, 0, 3),
	})
	items.Right1 = index5:Create("Frame", {
		Parent = items.TopFills.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.64999997615814209,
		Position = UDim2.new(1, -1, 0, 0), Size = UDim2.new(0, 1, 0, 1), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 30),
	})
	items.Right1:AddToTheme({ BackgroundColor3 = "Section Background" })
	items.Right2 = index5:Create("Frame", {
		Parent = items.TopFills.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.64999997615814209,
		Position = UDim2.new(1, -1, 0, 1), Size = UDim2.new(0, 1, 0, 1), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 26),
	})
	items.Right2:AddToTheme({ BackgroundColor3 = "Section Background" })
	items.Right3 = index5:Create("Frame", {
		Parent = items.TopFills.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.64999997615814209,
		Position = UDim2.new(1, -2, 0, 1), Size = UDim2.new(0, 1, 0, 1), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 30),
	})
	items.Right3:AddToTheme({ BackgroundColor3 = "Section Background" })
	items.Left1 = index5:Create("Frame", {
		Parent = items.TopFills.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.64999997615814209,
		Position = UDim2.new(0, 2, 0, 0), Size = UDim2.new(0, 1, 0, 1), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 30),
	})
	items.Left1:AddToTheme({ BackgroundColor3 = "Section Background" })
	items.Left2 = index5:Create("Frame", {
		Parent = items.TopFills.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.64999997615814209,
		Position = UDim2.new(0, 2, 0, 1), Size = UDim2.new(0, 1, 0, 1), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 30),
	})
	items.Left2:AddToTheme({ BackgroundColor3 = "Section Background" })
	items.Left3 = index5:Create("Frame", {
		Parent = items.TopFills.Instance, AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 0.64999997615814209,
		Position = UDim2.new(0, 3, 0, 1), Size = UDim2.new(0, 1, 0, 1), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(26, 26, 30),
	})
	items.Left3:AddToTheme({ BackgroundColor3 = "Section Background" })
	index5:Create("UICorner", { Parent = items.Section.Instance, CornerRadius = UDim.new(0, 4) })
	items.Background = index5:Create("Frame", {
		Parent = items.Section.Instance, BackgroundTransparency = 0.64999997615814209, Position = UDim2.new(0, 1, 0, 55),
		Size = UDim2.new(1, -2, 1, -56), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(24, 22, 25),
	})
	items.Background:AddToTheme({ BackgroundColor3 = "Section Background" })
	items.Content = index5:Create("Frame", {
		Parent = items.Background.Instance, BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 15), Size = UDim2.new(1, -24, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
	})
	index5:Create("UIListLayout", {
		Parent = items.Content.Instance, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	items.Fade = index5:Create("TextButton", {
		Parent = items.Background.Instance, BackgroundTransparency = 1, Size = UDim2.new(0, 0, 10, 0), AutoButtonColor = false,
		Visible = false, Text = "", ZIndex = 2, BackgroundColor3 = Color3.fromRGB(24, 22, 25),
	})
	items.Fade:AddToTheme({ BackgroundColor3 = "Section Background" })
	index5:Create("UICorner", { Parent = items.Fade.Instance, CornerRadius = UDim.new(0, 4) })
	index5:Create("UIPadding", { Parent = items.Content.Instance, PaddingBottom = UDim.new(0, 10) })
	t19.Items = items
	t19.SetCollapsed = function(arg3, isCollapsed, arg4)
		isCollapsed = isCollapsed and true or false
		if t19.IsCollapsed == isCollapsed then
			return
		end
		t19.IsCollapsed = isCollapsed
		t19.IsActive = not isCollapsed
		local instance = items.Section.Instance
		if isCollapsed then
			local y = instance.AbsoluteSize.Y
			if y > 55 then
				t19.ExpandedHeight = y
			end
			instance.AutomaticSize = Enum.AutomaticSize.None
			instance.Size = UDim2.new(1, 0, 0, math.max(y, 55))
			if arg4 then
				instance.Size = UDim2.new(1, 0, 0, 55)
				items.Background.Instance.Visible = false
			else
				items.Section:Tween(nil, { Size = UDim2.new(1, 0, 0, 55) })
				task.delay(index3.Tween.Time, function()
					if t19.IsCollapsed then
						items.Background.Instance.Visible = false
					end
				end)
			end
		else
			items.Background.Instance.Visible = true
			if arg4 then
				instance.Size = UDim2.new(1, 0, 0, 45)
				instance.AutomaticSize = Enum.AutomaticSize.Y
			else
				items.Section:Tween(nil, { Size = UDim2.new(1, 0, 0, t19.ExpandedHeight or 70 + items.Content.Instance.AbsoluteSize.Y) })
				task.delay(index3.Tween.Time, function()
					if t19.IsCollapsed then
						return
					end
					instance.Size = UDim2.new(1, 0, 0, 45)
					instance.AutomaticSize = Enum.AutomaticSize.Y
				end)
			end
		end
		if isCollapsed then
			items.Gradient.Instance.Enabled = false
			items.Toggle:ChangeItemTheme({ BackgroundColor3 = "Element" })
			items.Toggle:Tween(nil, { BackgroundColor3 = index3.Theme.Element })
			items.Circle:Tween(nil, {
				AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), BackgroundColor3 = index3.Theme.Text,
				BackgroundTransparency = 0.6,
			})
		else
			items.Gradient.Instance.Enabled = true
			items.Toggle:ChangeItemTheme({ BackgroundColor3 = "Text" })
			items.Toggle:Tween(nil, { BackgroundColor3 = index3.Theme.Text })
			items.Circle:Tween(nil, {
				AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -4, 0.5, 0), BackgroundColor3 = index3.Theme.Text,
				BackgroundTransparency = 0,
			})
		end
	end
	t19.Collapse = function(arg3, arg4)
		t19:SetCollapsed(true, arg4)
	end
	t19.Expand = function(arg3, arg4)
		t19:SetCollapsed(false, arg4)
	end
	t19.ToggleBackground = function()
		t19:SetCollapsed(not t19.IsCollapsed)
	end
	index3:Connect(items.Content.Instance.Changed, function(arg3)
		if arg3 == "AbsoluteSize" then
			items.Fade.Instance.Size = UDim2.new(1, 0, 0, items.Content.Instance.AbsoluteSize.Y + 10)
		end
	end)
	t19.TweenElements = function(arg3, arg4, arg5)
		if #t19.Elements > 15 or arg5 then
			for _, v78 in t19.Elements do
				v78:RefreshPosition(arg4)
			end
			return
		end
		for _, v78 in t19.Elements do
			v78:RefreshPosition(arg4)
			task.wait(0.03)
		end
	end
	items.Toggle:Connect("MouseButton1Down", function()
		t19:ToggleBackground()
	end)
	if t18.Collapsed or t18.collapsed then
		task.defer(function()
			t19:SetCollapsed(true, true)
		end)
	end
	t19.Page.Sections[t19.Name] = t19
	return setmetatable(t19, index3.Sections)
end

index3.Sections.Toggle = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Toggle" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Default = t18.Default or t18.default or false
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Value = false
	local t20 = {
		Toggle = index5:Create("TextButton", {
			Parent = t19.Section.Items.Content.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
			AutoButtonColor = false, BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 34), ZIndex = 2, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t20.Toggle:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Toggle.Instance, CornerRadius = UDim.new(0, 5) })
	t20.AccentBar = index5:Create("Frame", {
		Parent = t20.Toggle.Instance, Size = UDim2.new(0, 2, 1, -12), Position = UDim2.new(0, 4, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 3, BackgroundTransparency = 0.5, BackgroundColor3 = Color3.fromRGB(80, 80, 90),
	})
	index5:Create("UICorner", { Parent = t20.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	t20.AccentBarGradient = index5:Create("UIGradient", {
		Parent = t20.AccentBar.Instance, Enabled = false, Rotation = 90,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	})
	t20.AccentBarGradient:AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t20.Text = index5:Create("TextLabel", {
		Parent = t20.Toggle.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		Position = UDim2.new(0, 14, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3, TextSize = 14,
	})
	t20.Text:AddToTheme({ TextColor3 = "Text" })
	t20.Indicator = index5:Create("Frame", {
		Parent = t20.Toggle.Instance, Size = UDim2.new(0, 18, 0, 18), AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -8, 0.5, 0), ZIndex = 3, BackgroundColor3 = Color3.fromRGB(38, 36, 42),
	})
	t20.Indicator:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UICorner", { Parent = t20.Indicator.Instance, CornerRadius = UDim.new(0, 4) })
	t20.Accent = index5:Create("Frame", {
		Parent = t20.Indicator.Instance, Size = UDim2.new(0, 0, 0, 0), ZIndex = 3, AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
	})
	index5:Create("UICorner", { Parent = t20.Accent.Instance, CornerRadius = UDim.new(0, 4) })
	t20.CheckImage = index5:Create("ImageLabel", {
		Parent = t20.Accent.Instance, Size = UDim2.new(0, 0, 0, 0), AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "rbxassetid://121760666525660", BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 4,
		ImageTransparency = 1,
	})
	t20.CheckImage:AddToTheme({ ImageColor3 = "Text" })
	t20.Gradient = index5:Create("UIGradient", {
		Parent = t20.Accent.Instance, Enabled = true, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	})
	t20.Gradient:AddToTheme({ Color = function()
		local v78 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
	end })
	t20.Toggle:OnHover(function()
		t20.Toggle:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 0.15 })
	end)
	t20.Toggle:OnHoverLeave(function()
		local t21 = { BackgroundTransparency = 0 }
		t20.Toggle:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), t21)
	end)
	t19.Get = function()
		return t19.Value
	end
	t19.Set = function(arg3, value)
		t19.Value = value
		index3.Flags[t19.Flag] = value
		if t19.Value then
			t20.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.1, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundTransparency = 0, Size = UDim2.new(1, 0, 1, 0) })
			t20.CheckImage:Tween(nil, { ImageTransparency = 0, Size = UDim2.new(0, 10, 0, 9) })
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0 })
			t20.AccentBarGradient.Instance.Enabled = true
			t20.Text:Tween(nil, { TextTransparency = 0 })
		else
			t20.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.05, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0) })
			t20.CheckImage:Tween(nil, { ImageTransparency = 1, Size = UDim2.new(0, 0, 0, 0) })
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0.5 })
			t20.AccentBarGradient.Instance.Enabled = false
			t20.Text:Tween(nil, { TextTransparency = 0.3 })
		end
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value)
		end
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Toggle.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 0.5, 0) })
			t20.Indicator:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, -8, 0.5, 0) })
			t20.AccentBar:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 4, 0.5, 0) })
		else
			t20.Text.Instance.Position = UDim2.new(0, 74, 0.5, 0)
			t20.Indicator.Instance.Position = UDim2.new(1, 52, 0.5, 0)
			t20.AccentBar.Instance.Position = UDim2.new(0, -20, 0.5, 0)
		end
	end
	local items = {}
	t19.Settings = function(arg3, arg4)
		local settings_ = { IsOpen = false, Name = "", Items = {}, IsSettings = true, Elements = {} }
		t19.Settings = settings_
		items = {}
		items.Settings = index5:Create("Frame", {
			Parent = index3.UnusedHolder.Instance, Visible = false, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.89496046304702759, 0, 0.29451856017112732, 0), Size = UDim2.new(0, 245, 0, 159), ZIndex = 2,
			AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(21, 21, 24),
		})
		items.Settings:AddToTheme({ BackgroundColor3 = "Background" })
		index5:Create("UICorner", { Parent = items.Settings.Instance, CornerRadius = UDim.new(0, 6) })
		items.SettingsIcon = index5:Create("ImageLabel", {
			Parent = t20.Text.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 14, 0, 14),
			AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://101500482366184", BackgroundTransparency = 1,
			Position = UDim2.new(1, 6, 0.5, 1), ZIndex = 3,
		})
		t20.SettingsIcon = items.SettingsIcon
		items.Content = index5:Create("ScrollingFrame", {
			Parent = items.Settings.Instance, AutomaticCanvasSize = Enum.AutomaticSize.Y, Selectable = false,
			Size = UDim2.new(1, -8, 1, -46), Position = UDim2.new(0, 4, 0, 4), ScrollBarThickness = 2, BackgroundTransparency = 1,
			CanvasSize = UDim2.new(0, 0, 0, 0),
		})
		items.Content:AddToTheme({ ScrollBarImageColor3 = "Accent" })
		index5:Create("UIListLayout", {
			Parent = items.Content.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
		})
		index5:Create("UIPadding", {
			Parent = items.Content.Instance, PaddingTop = UDim.new(0, 4), PaddingBottom = UDim.new(0, 4), PaddingRight = UDim.new(0, 4),
			PaddingLeft = UDim.new(0, 4),
		})
		items.Button = index5:Create("TextButton", {
			Parent = items.Settings.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
			AutoButtonColor = false, Size = UDim2.new(1, -16, 0, 32), ZIndex = 2, AnchorPoint = Vector2.new(0, 1),
			Position = UDim2.new(0, 8, 1, -8), TextSize = 14, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		})
		items.Button:AddToTheme({ BackgroundColor3 = "Element" })
		items.Accent = index5:Create("Frame", {
			Parent = items.Button.Instance, Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, BackgroundTransparency = 1,
			AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		})
		items.Gradient = index5:Create("UIGradient", {
			Parent = items.Accent.Instance, Enabled = true, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		})
		items.Gradient:AddToTheme({ Color = function()
			local v78 = 1
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
		end })
		index5:Create("UICorner", { Parent = items.Accent.Instance, CornerRadius = UDim.new(0, 4) })
		index5:Create("UICorner", { Parent = items.Button.Instance, CornerRadius = UDim.new(0, 4) })
		items.Text = index5:Create("TextLabel", {
			Parent = items.Button.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
			TextTransparency = 0.30000001192092896, Text = "Close", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
			AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 2,
			TextSize = 14,
		})
		items.Text:AddToTheme({ TextColor3 = "Text" })
		items.Button:OnHover(function()
			items.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
		end)
		items.Button:OnHoverLeave(function()
			items.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
		end)
		local connection = nil
		local b15 = false
		settings_.SetOpen = function(arg5, isOpen)
			if b15 then
				return
			end
			settings_.IsOpen = isOpen
			b15 = true
			if settings_.IsOpen then
				task.spawn(function()
					for _, v78 in settings_.Elements do
						v78:RefreshPosition(true)
						task.wait(0.03)
					end
				end)
				items.Settings.Instance.Visible = true
				items.Settings.Instance.Parent = index3.Holder.Instance
				connection = RunService.RenderStepped:Connect(function()
					items.Settings.Instance.Position = UDim2.new(0, t20.Toggle.Instance.AbsolutePosition.X + t20.Toggle.Instance.AbsoluteSize.X / 1.9 + 15, 0, t20.Toggle.Instance.AbsolutePosition.Y + t20.Toggle.Instance.AbsoluteSize.Y + arg4 / 1.9)
					items.Settings.Instance.Size = UDim2.new(0, 245, 0, arg4)
				end)
				for _, v78 in index3.OpenFrames do
					if v78 ~= settings_ then
						v78:SetOpen(false)
					end
				end
				index3.OpenFrames[settings_] = settings_
			else
				for _, v78 in settings_.Elements do
					v78:RefreshPosition(false)
				end
				if index3.OpenFrames[settings_] then
					index3.OpenFrames[settings_] = nil
				end
				if connection then
					connection:Disconnect()
					connection = nil
				end
			end
			local descendants = items.Settings.Instance:GetDescendants()
			table.insert(descendants, items.Settings.Instance)
			local v78 = nil
			for _, v79 in descendants do
				local property = index4:GetProperty(v79)
				if property then
					if not v79.ClassName:find("UI") then
						v79.ZIndex = settings_.IsOpen and 7 or 1
					end
					if type(property) == "table" then
						for _, v80 in property do
							v78 = index4:FadeItem(v79, v80, isOpen, index3.FadeSpeed)
						end
					else
						v78 = index4:FadeItem(v79, property, isOpen, index3.FadeSpeed)
					end
				end
			end
			v78.Tween.Completed:Connect(function()
				b15 = false
				items.Settings.Instance.Visible = settings_.IsOpen
				task.wait(0.2)
				items.Settings.Instance.Parent = not settings_.IsOpen and index3.UnusedHolder and index3.UnusedHolder.Instance or index3.Holder.Instance
			end)
		end
		items.Button:Connect("MouseButton1Down", function()
			settings_:SetOpen(false)
		end)
		items.SettingsIcon:Connect("InputBegan", function(arg5)
			if arg5.UserInputType == Enum.UserInputType.MouseButton1 or arg5.UserInputType == Enum.UserInputType.Touch then
				settings_:SetOpen(not settings_.IsOpen)
			end
		end)
		index3:Connect(UserInputService.InputBegan, function(arg5)
			if arg5.UserInputType == Enum.UserInputType.MouseButton1 or arg5.UserInputType == Enum.UserInputType.Touch then
				if index3:IsMouseOverFrame(items.Settings) then
					return
				end
				settings_:SetOpen(false)
			end
		end)
		settings_.Items = items
		setmetatable(settings_, index3.Sections)
		return settings_
	end
	t19.Colorpicker = function(arg3, arg4)
		local t21 = arg4 or {}
		local t22 = {
			Window = t19.Window, Page = t19.Page, Section = t19.Section, Flag = t21.Flag or t21.flag or index3:NextFlag(),
			Default = t21.Default or t21.default or Color3.fromRGB(255, 255, 255),
			Callback = t21.Callback or t21.callback or function() end,
			Alpha = t21.Alpha or t21.alpha or false,
		}
		return (index3:CreateColorpicker({
			Parent = t20.SubElements, Page = t22.Page, Section = t22.Section, Flag = t22.Flag, Default = t22.Default,
			Callback = t22.Callback, Alpha = t22.Alpha,
		}))
	end
	t19.Keybind = function(arg3, arg4)
		local t21 = arg4 or {}
		local t22 = {
			Window = t19.Window, Page = t19.Page, Section = t19.Section, Flag = t21.Flag or t21.flag or index3:NextFlag(),
			Default = t21.Default or t21.default or Enum.KeyCode.E,
			Callback = t21.Callback or t21.callback or function() end,
			Mode = t21.Mode or t21.mode or "Toggle",
		}
		return (index3:CreateKeybind({
			Parent = t20.SubElements, Page = t22.Page, Section = t22.Section, Flag = t22.Flag, Default = t22.Default, Mode = t22.Mode,
			Callback = t22.Callback,
		}))
	end
	t20.Toggle:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			if t20.SettingsIcon and index3:IsMouseOverFrame(t20.SettingsIcon) then
				return
			end
			t19:Set(not t19.Value)
		end
	end)
	t19:Set(t19.Default)
	index3.SetFlags[t19.Flag] = function(arg3)
		task.delay(0.25, function()
			t19:Set(arg3)
		end)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.Button = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = {
		Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Button", Icon = t18.Icon or t18.icon or nil,
		Callback = t18.Callback or t18.callback or function() end,
	}
	local t20 = {
		Button = index5:Create("TextButton", {
			Parent = t19.Section.Items.Content.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
			AutoButtonColor = false, Size = UDim2.new(1, 0, 0, 34), ZIndex = 2, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t20.Button:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Button.Instance, CornerRadius = UDim.new(0, 5) })
	t20.AccentBar = index5:Create("Frame", {
		Parent = t20.Button.Instance, Size = UDim2.new(0, 2, 1, -12), Position = UDim2.new(0, 4, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 3, BackgroundTransparency = 0.5, BackgroundColor3 = Color3.fromRGB(80, 80, 90),
	})
	index5:Create("UICorner", { Parent = t20.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	t20.AccentBarGradient = index5:Create("UIGradient", { Parent = t20.AccentBar.Instance, Enabled = false, Rotation = 90 })
	t20.AccentBarGradient:AddToTheme({ Color = function()
		local v78 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
	end })
	t20.Accent = index5:Create("Frame", {
		Parent = t20.Button.Instance, Size = UDim2.new(0, 0, 0, 0), ZIndex = 2, BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
	})
	local v78 = 1
	t20.Gradient = index5:Create("UIGradient", {
		Parent = t20.Accent.Instance, Enabled = true, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(v78, Color3.fromRGB(143, 143, 143)) }),
	})
	t20.Gradient:AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	index5:Create("UICorner", { Parent = t20.Accent.Instance, CornerRadius = UDim.new(0, 5) })
	t20.Text = index5:Create("TextLabel", {
		Parent = t20.Button.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 3, TextSize = 14,
	})
	t20.Text:AddToTheme({ TextColor3 = "Text" })
	if t19.Icon then
		t20.Icon = index5:Create("ImageLabel", {
			Parent = t20.Text.Instance, ImageColor3 = Color3.fromRGB(240, 240, 240), ImageTransparency = 0.30000001192092896,
			Size = UDim2.new(0, 18, 0, 18), AnchorPoint = Vector2.new(1, 0.5), Image = "rbxassetid://" .. t19.Icon,
			BackgroundTransparency = 1, Position = UDim2.new(0, -8, 0.5, 0), ZIndex = 3,
		})
		t20.Icon:AddToTheme({ ImageColor3 = "Text" })
	end
	t20.Button:OnHover(function()
		t20.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
		t20.AccentBar:Tween(nil, { BackgroundTransparency = 0 })
		t20.AccentBarGradient.Instance.Enabled = true
	end)
	t20.Button:OnHoverLeave(function()
		t20.Accent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
		t20.AccentBar:Tween(nil, { BackgroundTransparency = 0.5 })
		t20.AccentBarGradient.Instance.Enabled = false
	end)
	t19.SetVisibility = function(arg3, visible)
		t20.Button.Instance.Visible = visible
	end
	t19.Press = function()
		t20.Button:ChangeItemTheme({ BackgroundColor3 = "Accent" })
		t20.Button:Tween(nil, { BackgroundColor3 = index3.Theme.Accent })
		t20.Text:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0), TextTransparency = 0 })
		if t19.Icon then
			t20.Icon:Tween(nil, { ImageColor3 = Color3.fromRGB(0, 0, 0), ImageTransparency = 0 })
		end
		task.wait(0.2)
		index3:SafeCall(t19.Callback)
		t20.Button:ChangeItemTheme({ BackgroundColor3 = "Element" })
		t20.Button:Tween(nil, { BackgroundColor3 = index3.Theme.Element })
		t20.Text:Tween(nil, { TextColor3 = index3.Theme.Text, TextTransparency = 0.3 })
		if t19.Icon then
			t20.Icon:Tween(nil, { ImageColor3 = index3.Theme.Text, ImageTransparency = 0.3 })
		end
	end
	t20.Button:Connect("MouseButton1Down", function()
		t19:Press()
	end)
	return t19
end

index3.Sections.Slider = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Slider" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Min = t18.Min or t18.min or 0
	t19.Default = t18.Default or t18.default or 0
	t19.Max = t18.Max or t18.max or 100
	t19.Suffix = t18.Suffix or t18.suffix or ""
	t19.Decimals = t18.Decimals or t18.decimals or 1
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Value = 0
	t19.Sliding = false
	local t20 = {
		Slider = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 48), ZIndex = 2,
			BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t20.Slider:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Slider.Instance, CornerRadius = UDim.new(0, 5) })
	t20.AccentBar = index5:Create("Frame", {
		Parent = t20.Slider.Instance, Size = UDim2.new(0, 2, 1, -14), Position = UDim2.new(0, 4, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 3, BackgroundTransparency = 0,
	})
	index5:Create("UICorner", { Parent = t20.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	index5:Create("UIGradient", {
		Parent = t20.AccentBar.Instance, Rotation = 90,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t20.Text = index5:Create("TextLabel", {
		Parent = t20.Slider.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.15,
		Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1,
		Position = UDim2.new(0, 14, 0, 8), ZIndex = 3, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
	})
	t20.Text:AddToTheme({ TextColor3 = "Text" })
	t20.Value = index5:Create("TextLabel", {
		Parent = t20.Slider.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = "50%", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, Position = UDim2.new(1, -14, 0, 8), ZIndex = 3, TextSize = 14,
	})
	t20.Value:AddToTheme({ TextColor3 = "Text" })
	t20.RealSlider = index5:Create("TextButton", {
		Parent = t20.Slider.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 34, 1, -10), Size = UDim2.new(1, -68, 0, 7), ZIndex = 3, TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(38, 36, 42),
	})
	t20.RealSlider:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UICorner", { Parent = t20.RealSlider.Instance })
	t20.Accent = index5:Create("Frame", {
		Parent = t20.RealSlider.Instance, Size = UDim2.new(0.5, 0, 1, 0), ZIndex = 3,
	})
	index5:Create("UICorner", { Parent = t20.Accent.Instance })
	t20.Icon = index5:Create("ImageLabel", {
		Parent = t20.Accent.Instance, Size = UDim2.new(0, 16, 0, 12), AnchorPoint = Vector2.new(0.5, 0.5),
		Image = "rbxassetid://117786983271442", BackgroundTransparency = 1, Position = UDim2.new(1, 5, 0.5, 0), ZIndex = 4,
	})
	index5:Create("UIGradient", {
		Parent = t20.Accent.Instance, Rotation = -102,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 166, 166)) }),
	}):AddToTheme({ Color = function()
		local v78 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
	end })
	t20.Plus = index5:Create("TextButton", {
		Parent = t20.Slider.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = "+", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5),
		Size = UDim2.new(0, 20, 0, 20), BackgroundTransparency = 1, Position = UDim2.new(1, -10, 1, -14), ZIndex = 3, TextSize = 16,
	})
	t20.Plus:AddToTheme({ TextColor3 = "Text" })
	t20.Minus = index5:Create("TextButton", {
		Parent = t20.Slider.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = "-", AutoButtonColor = false, AnchorPoint = Vector2.new(0, 0.5),
		Size = UDim2.new(0, 20, 0, 24), BackgroundTransparency = 1, Position = UDim2.new(0, 10, 1, -14), ZIndex = 3, TextSize = 16,
	})
	t20.Minus:AddToTheme({ TextColor3 = "Text" })
	t20.RealSlider:OnHover(function()
		t20.Icon:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 18, 0, 14) })
	end)
	t20.RealSlider:OnHoverLeave(function()
		t20.Icon:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 16, 0, 12) })
	end)
	t19.Get = function()
		return t19.Value
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Slider.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 0, 8) })
			t20.Value:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, -14, 0, 8) })
			t20.RealSlider:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 34, 1, -10) })
			t20.AccentBar:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 4, 0.5, 0) })
		else
			t20.Text.Instance.Position = UDim2.new(0, 74, 0, 8)
			t20.Value.Instance.Position = UDim2.new(1, 44, 0, 8)
			t20.RealSlider.Instance.Position = UDim2.new(0, 94, 1, -10)
			t20.AccentBar.Instance.Position = UDim2.new(0, -20, 0.5, 0)
		end
	end
	t19.Set = function(arg3, arg4)
		local decimals = t19.Decimals
		t19.Value = index3:Round(math.clamp(arg4, t19.Min, t19.Max), decimals)
		index3.Flags[t19.Flag] = t19.Value
		t20.Accent:Tween(TweenInfo.new(index3.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new((t19.Value - t19.Min) / (t19.Max - t19.Min), 0, 1, 0) })
		t20.Value.Instance.Text = string.format("%s%s", t19.Value, t19.Suffix)
		if t19.Value >= t19.Max then
			t20.Icon.Instance.Position = UDim2.new(1, -5, 0.5, 0)
		else
			t20.Icon.Instance.Position = UDim2.new(1, 5, 0.5, 0)
		end
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value)
		end
	end
	t20.Plus:Connect("MouseButton1Down", function()
		t19:Set(t19.Value + t19.Decimals)
	end)
	t20.Minus:Connect("MouseButton1Down", function()
		t19:Set(t19.Value - t19.Decimals)
	end)
	local connection = nil
	t20.RealSlider:Connect("InputBegan", function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			t19.Sliding = true
			t19:Set((t19.Max - t19.Min) * (arg3.Position.X - t20.RealSlider.Instance.AbsolutePosition.X) / t20.RealSlider.Instance.AbsoluteSize.X + t19.Min)
			if connection then
				return
			end
			connection = arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					t19.Sliding = false
					connection:Disconnect()
					connection = nil
				end
			end)
		end
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseMovement or arg3.UserInputType == Enum.UserInputType.Touch then
			if t19.Sliding then
				t19:Set((t19.Max - t19.Min) * (arg3.Position.X - t20.RealSlider.Instance.AbsolutePosition.X) / t20.RealSlider.Instance.AbsoluteSize.X + t19.Min)
			end
		end
	end)
	if t19.Default then
		t19:Set(t19.Default)
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.Dropdown = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Dropdown" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Items = t18.Items or t18.items or { "One", "Two", "Three" }
	t19.Default = t18.Default or t18.default or nil
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Size = t18.Size or t18.size or 150
	t19.OptionHolderSize = t18.OptionHolderSize or t18.optionholder or 200
	t19.Multi = t18.Multi or t18.multi or false
	t19.Searchable = t18.Searchable or t18.searchable or false
	t19.Value = {}
	t19.Options = {}
	t19.OptionsWithIndexes = {}
	t19.IsOpen = false
	local t20 = {
		Dropdown = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 34), ZIndex = 2,
			BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t20.Dropdown:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Dropdown.Instance, CornerRadius = UDim.new(0, 5) })
	t20.AccentBar = index5:Create("Frame", {
		Parent = t20.Dropdown.Instance, Size = UDim2.new(0, 2, 1, -12), Position = UDim2.new(0, 4, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5), ZIndex = 6, BackgroundTransparency = 0.5, BackgroundColor3 = Color3.fromRGB(80, 80, 90),
	})
	index5:Create("UICorner", { Parent = t20.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	t20.AccentBarGradient = index5:Create("UIGradient", { Parent = t20.AccentBar.Instance, Enabled = false, Rotation = 90 })
	t20.AccentBarGradient:AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t20.Text = index5:Create("TextLabel", {
		Parent = t20.Dropdown.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0.5, 0), ZIndex = 6, TextSize = 14,
	})
	t20.Text:AddToTheme({ TextColor3 = "Text" })
	t20.RealDropdown = index5:Create("TextButton", {
		Parent = t20.Dropdown.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
		Size = UDim2.new(0, t19.Size or 125, 0, 24), AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -6, 0.5, 0), ZIndex = 6, TextSize = 14, BackgroundColor3 = Color3.fromRGB(38, 36, 42),
	})
	t20.RealDropdown:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UICorner", { Parent = t20.RealDropdown.Instance, CornerRadius = UDim.new(0, 4) })
	t20.Value = index5:Create("TextLabel", {
		Parent = t20.RealDropdown.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = "-", Size = UDim2.new(1, -30, 0, 15), AnchorPoint = Vector2.new(0, 0.5),
		TextTruncate = Enum.TextTruncate.AtEnd, BackgroundTransparency = 1, Position = UDim2.new(0, 8, 0.5, 0),
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 6, TextSize = 13,
	})
	t20.Value:AddToTheme({ TextColor3 = "Text" })
	t20.ArrowIcon = index5:Create("ImageLabel", {
		Parent = t20.RealDropdown.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 14, 0, 8),
		AnchorPoint = Vector2.new(1, 0.5), Image = "rbxassetid://123317177279443", BackgroundTransparency = 1,
		Position = UDim2.new(1, -6, 0.5, 0), ZIndex = 6,
	})
	t20.Gradient = index5:Create("UIGradient", { Parent = t20.ArrowIcon.Instance, Enabled = false })
	t20.Gradient:AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t20.OptionHolder = index5:Create("TextButton", {
		Parent = index3.UnusedHolder.Instance, Text = "", AutoButtonColor = false, Visible = false, Position = UDim2.new(0, 897, 0, 101),
		Size = UDim2.new(0, 159, 0, 87), BackgroundColor3 = Color3.fromRGB(27, 25, 29),
	})
	t20.OptionHolder:AddToTheme({ BackgroundColor3 = "Background" })
	index5:Create("UIStroke", {
		Parent = t20.OptionHolder.Instance, Color = Color3.fromRGB(35, 33, 38), ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}):AddToTheme({ Color = "Outline" })
	index5:Create("UICorner", { Parent = t20.OptionHolder.Instance, CornerRadius = UDim.new(0, 5) })
	t20.Holder = index5:Create("ScrollingFrame", {
		Parent = t20.OptionHolder.Instance, Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
		Size = UDim2.new(1, -16, 1, -16), BackgroundTransparency = 1, Position = UDim2.new(0, 8, 0, 8), CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	t20.Holder:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	if t19.Searchable then
		t20.Search = index5:Create("TextBox", {
			Parent = t20.OptionHolder.Instance, FontFace = index3.Font, CursorPosition = -1, TextColor3 = Color3.fromRGB(240, 240, 240),
			Text = "", ZIndex = 6, Size = UDim2.new(1, -16, 0, 26), Position = UDim2.new(0, 8, 0, 8),
			PlaceholderColor3 = Color3.fromRGB(185, 185, 185), TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Search..",
			TextSize = 14, BackgroundColor3 = Color3.fromRGB(26, 26, 29),
		})
		t20.Search:AddToTheme({ TextColor3 = "Text", BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = t20.Search.Instance, CornerRadius = UDim.new(0, 4) })
		index5:Create("UIPadding", { Parent = t20.Search.Instance, PaddingLeft = UDim.new(0, 8) })
		t20.Holder.Instance.Position = UDim2.new(0, 8, 0, 40)
		t20.Holder.Instance.Size = UDim2.new(1, -16, 1, -48)
	end
	index5:Create("UIListLayout", {
		Parent = t20.Holder.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	t19.Get = function()
		return t19.Value
	end
	t19.GetValues = function()
		return t19.Items
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Dropdown.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 0.5, 0) })
			t20.RealDropdown:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, -6, 0.5, 0) })
			t20.AccentBar:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 4, 0.5, 0) })
		else
			t20.Text.Instance.Position = UDim2.new(0, 74, 0.5, 0)
			t20.RealDropdown.Instance.Position = UDim2.new(1, 54, 0.5, 0)
			t20.AccentBar.Instance.Position = UDim2.new(0, -20, 0.5, 0)
		end
	end
	t20.RealDropdown:OnHover(function()
		if t19.IsOpen then
			return
		end
		t20.ArrowIcon:Tween(nil, { ImageColor3 = Color3.fromRGB(255, 255, 255) })
		t20.Gradient.Instance.Enabled = true
	end)
	t20.RealDropdown:OnHoverLeave(function()
		if t19.IsOpen then
			return
		end
		t20.ArrowIcon:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
		t20.Gradient.Instance.Enabled = false
	end)
	local connection = nil
	t19.SetOpen = function(arg3, isOpen)
		if Debounce then
			return
		end
		t19.IsOpen = isOpen
		Debounce = true
		if t19.IsOpen then
			t20.OptionHolder.Instance.Visible = true
			t20.OptionHolder.Instance.Parent = index3.Holder.Instance
			t20.ArrowIcon:Tween(nil, { Rotation = 180, ImageColor3 = Color3.fromRGB(255, 255, 255) })
			t20.Gradient.Instance.Enabled = true
			index3:Thread(function()
				for _, v78 in t19.OptionsWithIndexes do
					task.spawn(function()
						v78:RefreshPosition(true)
					end)
					task.wait(1)
				end
			end)
			connection = RunService.RenderStepped:Connect(function()
				t20.OptionHolder.Instance.Position = UDim2.new(0, t20.RealDropdown.Instance.AbsolutePosition.X, 0, t20.RealDropdown.Instance.AbsolutePosition.Y + t20.RealDropdown.Instance.AbsoluteSize.Y + 5)
				t20.OptionHolder.Instance.Size = UDim2.new(0, t20.RealDropdown.Instance.AbsoluteSize.X, 0, t19.OptionHolderSize)
			end)
			for _, v78 in index3.OpenFrames do
				if v78 ~= t19 and not t19.Section.IsSettings then
					v78:SetOpen(false)
				end
			end
			index3.OpenFrames[t19] = t19
		else
			if not t19.IsOpen then
				for _, v78 in t19.OptionsWithIndexes do
					task.spawn(function()
						v78:RefreshPosition(false)
					end)
				end
			end
			if index3.OpenFrames[t19] then
				index3.OpenFrames[t19] = nil
			end
			if connection then
				connection:Disconnect()
				connection = nil
			end
			t20.ArrowIcon:Tween(nil, { Rotation = 0, ImageColor3 = Color3.fromRGB(141, 141, 150) })
			t20.Gradient.Instance.Enabled = false
		end
		local descendants = t20.OptionHolder.Instance:GetDescendants()
		table.insert(descendants, t20.OptionHolder.Instance)
		local v78 = nil
		for _, v79 in descendants do
			local property = index4:GetProperty(v79)
			if property then
				if not v79.ClassName:find("UI") then
					v79.ZIndex = t19.IsOpen and t19.Section.IsSettings and 9 or t19.IsOpen and 6 or 1
				end
				if type(property) == "table" then
					for _, v80 in property do
						v78 = index4:FadeItem(v79, v80, isOpen, index3.FadeSpeed)
					end
				else
					v78 = index4:FadeItem(v79, property, isOpen, index3.FadeSpeed)
				end
			end
		end
		v78.Tween.Completed:Connect(function()
			Debounce = false
			t20.OptionHolder.Instance.Visible = t19.IsOpen
			task.wait(0.2)
			t20.OptionHolder.Instance.Parent = not t19.IsOpen and index3.UnusedHolder.Instance or index3.Holder.Instance
		end)
	end
	local function f27()
		local b15
		if t19.Multi then
			b15 = #t19.Value > 0
		else
			b15 = t19.Value ~= nil and t19.Value ~= ""
		end
		if b15 then
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0 })
			t20.AccentBarGradient.Instance.Enabled = true
		else
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0.5 })
			t20.AccentBarGradient.Instance.Enabled = false
		end
	end
	t19.Set = function(arg3, value)
		if t19.Multi then
			local v78 = "table"
			if type(value) ~= v78 then
				return
			end
			t19.Value = value
			index3.Flags[t19.Flag] = value
			for _, v79 in value do
				local v80 = t19.Options[v79]
				if v80 then
					v80.Selected = true
					v80:Toggle("Active")
				end
			end
			t20.Value.Instance.Text = table.concat(value, ", ")
		else
			if not t19.Options[value] then
				return
			end
			local v78 = t19.Options[value]
			t19.Value = value
			index3.Flags[t19.Flag] = value
			for _, v79 in t19.Options do
				if v79 ~= v78 then
					v79.Selected = false
					v79:Toggle("Inactive")
				else
					v79.Selected = true
					v79:Toggle("Active")
				end
			end
			t20.Value.Instance.Text = value
		end
		f27()
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value)
		end
	end
	t19.Add = function(arg3, arg4)
		local tween = index5:Create("TextButton", {
			Parent = t20.Holder.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
			BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20), TextSize = 14,
		})
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.new(0, 6, 0, 6),
		})
		index5:Create("UIGradient", {
			Parent = tween2.Instance, Enabled = true, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		index5:Create("UICorner", { Parent = tween2.Instance })
		local tween3 = index5:Create("TextLabel", {
			Parent = tween2.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0.30000001192092896, Text = arg4, Size = UDim2.new(0, 0, 0, 15), AnchorPoint = Vector2.new(0, 0.5),
			BackgroundTransparency = 1, Position = UDim2.new(0, 30, 0.5, 0), AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
		})
		tween3:AddToTheme({ TextColor3 = "Text" })
		local t21
		t21 = {
			Button = tween, Name = arg4, OptionText = tween3, OptionAccent = tween2, IsSearching = false, Selected = false,
			Toggle = function(arg5, arg6)
				if arg6 == "Active" then
					tween3:Tween(nil, { TextTransparency = 0, Position = UDim2.new(0, 15, 0.5, 0) })
					tween2:Tween(nil, { BackgroundTransparency = 0 })
				else
					tween3:Tween(nil, { TextTransparency = 0.3, Position = UDim2.new(0, 0, 0.5, 0) })
					tween2:Tween(nil, { BackgroundTransparency = 1 })
				end
			end,
			Search = function(arg5, arg6)
				index3:Thread(function()
					if arg6 then
						t21.IsSearching = true
						tween3:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { TextTransparency = 1 })
						task.wait(0.05)
						tween:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 0) })
						if t21.Selected then
							local t22 = { BackgroundTransparency = 1 }
							tween2:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), t22)
						end
					else
						t21.IsSearching = false
						tween3:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { TextTransparency = t21.Selected and 0 or 0.3 })
						task.wait(0.05)
						tween:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 20) })
						if t21.Selected then
							tween2:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 0 })
						end
					end
				end)
			end,
			RefreshPosition = function(arg5, arg6)
				if arg6 then
					if t21.Selected then
						tween2:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0.5, 0) })
						tween3:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 15, 0.5, 0) })
					else
						tween3:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0.5, 0) })
					end
				elseif t21.Selected then
					tween2.Instance.Position = UDim2.new(0, 30, 0.5, 0)
					tween3.Instance.Position = UDim2.new(0, 45, 0.5, 0)
				else
					tween3.Instance.Position = UDim2.new(0, 30, 0.5, 0)
				end
			end,
			Set = function()
				t21.Selected = not t21.Selected
				if t19.Multi then
					local v78 = table.find(t19.Value, t21.Name)
					if v78 then
						table.remove(t19.Value, v78)
					else
						table.insert(t19.Value, t21.Name)
					end
					t21:Toggle(v78 and "Inactive" or "Active")
					index3.Flags[t19.Flag] = t19.Value
					t20.Value.Instance.Text = #t19.Value > 0 and table.concat(t19.Value, ", ") or "..."
				elseif t21.Selected then
					t19.Value = t21.Name
					index3.Flags[t19.Flag] = t21.Name
					t21.Selected = true
					t21:Toggle("Active")
					for _, v78 in t19.Options do
						if v78 ~= t21 then
							v78.Selected = false
							v78:Toggle("Inactive")
						end
					end
					t20.Value.Instance.Text = t21.Name
				else
					t19.Value = nil
					index3.Flags[t19.Flag] = nil
					t21.Selected = false
					t21:Toggle("Inactive")
					t20.Value.Instance.Text = "..."
				end
				f27()
				if t19.Callback then
					index3:SafeCall(t19.Callback, t19.Value)
				end
			end,
		}
		t21.Button:Connect("MouseButton1Down", function()
			t21:Set()
		end)
		t19.Options[t21.Name] = t21
		t19.OptionsWithIndexes[#t19.OptionsWithIndexes + 1] = t21
		t21:RefreshPosition(false)
		return t21
	end
	t19.Remove = function(arg3, arg4)
		if t19.Options[arg4] then
			t19.Options[arg4].Button:Clean()
			t19.Options[arg4] = nil
		end
	end
	t19.Refresh = function(arg3, arg4)
		for _, v78 in t19.Options do
			t19:Remove(v78.Name)
		end
		for _, v78 in arg4 do
			t19:Add(v78)
		end
	end
	t20.RealDropdown:Connect("MouseButton1Down", function()
		t19:SetOpen(not t19.IsOpen)
	end)
	index3:Connect(UserInputService.InputBegan, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			if t19.IsOpen then
				if index3:IsMouseOverFrame(t20.OptionHolder) then
					return
				end
				t19:SetOpen(false)
			end
		end
	end)
	t20.RealDropdown:Connect("Changed", function(arg3)
		if arg3 == "AbsolutePosition" and t19.IsOpen then
			t19.IsOpen = not index3:IsClipped(t20.OptionHolder.Instance, t19.Section.Items.Section.Instance.Parent)
			t20.OptionHolder.Instance.Visible = t19.IsOpen
		end
	end)
	for _, v78 in t19.Items do
		t19:Add(v78)
	end
	if t19.Default then
		t19:Set(t19.Default)
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	if t19.Searchable and t20.Search then
		index3:Connect(t20.Search.Instance:GetPropertyChangedSignal("Text"), function()
			index3:Thread(function()
				for _, v78 in t19.Options do
					local text = t20.Search.Instance.Text
					if text ~= "" then
						local escapePattern = index3.EscapePattern
						if string.find(string.lower(v78.Name), escapePattern(index3, string.lower(text))) then
							v78.Button.Instance.Visible = true
							v78:Search(false)
						else
							v78:Search(true)
							v78.Button.Instance.Visible = false
						end
					else
						v78:Search(false)
						v78.Button.Instance.Visible = true
					end
				end
			end)
		end)
	end
	return t19
end

index3.Sections.Label = function(arg, arg2)
	local t18 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = arg2 or "Label" }
	local t19 = {
		Label = index5:Create("Frame", {
			Parent = t18.Section.Items.Content.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 28),
			AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t19.Label:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t19.Label.Instance, CornerRadius = UDim.new(0, 5) })
	index5:Create("UIPadding", {
		Parent = t19.Label.Instance, PaddingTop = UDim.new(0, 6), PaddingBottom = UDim.new(0, 6), PaddingLeft = UDim.new(0, 12),
		PaddingRight = UDim.new(0, 12),
	})
	t19.Text = index5:Create("TextLabel", {
		Parent = t19.Label.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = t18.Name, Size = UDim2.new(1, 0, 0, 15), BackgroundTransparency = 1,
		Position = UDim2.new(0, 0, 0, 0), ZIndex = 2, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left, TextWrapped = true,
		RichText = true, AutomaticSize = Enum.AutomaticSize.Y,
	})
	t19.Text:AddToTheme({ TextColor3 = "Text" })
	t18.SetText = function(arg3, arg4)
		t19.Text.Instance.Text = tostring(arg4)
	end
	t18.SetVisibility = function(arg3, visible)
		t19.Label.Instance.Visible = visible
	end
	t18.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t19.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) })
			if t19.SubElements then
				t19.SubElements:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 30) })
				index4:Create(t19.Label.Instance:FindFirstChild("nig"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, -16, 1, -6) }, true)
			end
		else
			t19.Text.Instance.Position = UDim2.new(0, 26, 0, 0)
			if t19.SubElements then
				t19.SubElements:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 30, 0, 30) })
				index4:Create(t19.Label.Instance:FindFirstChild("nig"), TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, 26, 1, -6) }, true)
			end
		end
	end
	t18.Colorpicker = function(arg3, arg4)
		local t20 = arg4 or {}
		local t21 = {
			Window = t18.Window, Page = t18.Page, Section = t18.Section, Flag = t20.Flag or t20.flag or index3:NextFlag(),
			Default = t20.Default or t20.default or Color3.fromRGB(255, 255, 255),
			Callback = t20.Callback or t20.callback or function() end,
			Alpha = t20.Alpha or t20.alpha or false,
		}
		if not t19.SubElements then
			t19.SubElements = index5:Create("Frame", {
				Parent = t19.Label.Instance, Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0, 30), ZIndex = 2,
				BackgroundColor3 = Color3.fromRGB(27, 26, 29),
			})
			t19.SubElements:AddToTheme({ BackgroundColor3 = "Outline" })
			index5:Create("UICorner", { Parent = t19.SubElements.Instance, CornerRadius = UDim.new(0, 5) })
			index5:Create("UIListLayout", {
				Parent = t19.SubElements.Instance, VerticalAlignment = Enum.VerticalAlignment.Center,
				FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder,
			})
			index5:Create("UIPadding", { Parent = t19.SubElements.Instance, PaddingLeft = UDim.new(0, 6) })
		end
		return (index3:CreateColorpicker({
			Parent = t19.SubElements, Page = t21.Page, Section = t21.Section, Flag = t21.Flag, Default = t21.Default,
			Callback = t21.Callback, Parent2 = t19.Label, Alpha = t21.Alpha,
		}))
	end
	t18.Section.Elements[#t18.Section.Elements + 1] = t18
	return t18
end

index3.Sections.Keybind = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Keybind" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Default = t18.Default or t18.default or Enum.KeyCode.RightShift
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Mode = t18.Mode or t18.mode or Enum.KeyCode.RightShift
	t19.Method = t18.Method or t18.method or nil
	t19.Value = ""
	t19.ModeSelected = ""
	t19.Toggled = false
	t19.Picking = false
	if t19.Method ~= nil then
		local str8 = tostring(t19.Method)
		local str9 = string.upper(string.sub(str8, 1, 1)) .. string.lower(string.sub(str8, 2))
		t19.Method = table.find({ "Toggle", "Hold", "Always" }, str9) and str9 or nil
	end
	local t20 = {
		Label = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 66),
			BackgroundColor3 = Color3.fromRGB(26, 26, 29),
		}),
	}
	t20.Label:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Label.Instance, CornerRadius = UDim.new(0, 5) })
	t20.AccentBar = index5:Create("Frame", {
		Parent = t20.Label.Instance, Size = UDim2.new(0, 2, 1, -14), Position = UDim2.new(0, 4, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 3, BackgroundTransparency = 0.5, BackgroundColor3 = Color3.fromRGB(80, 80, 90),
	})
	index5:Create("UICorner", { Parent = t20.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	t20.AccentBarGradient = index5:Create("UIGradient", { Parent = t20.AccentBar.Instance, Enabled = false, Rotation = 90 })
	t20.AccentBarGradient:AddToTheme({ Color = function()
		local v78 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v78, accentGradient) })
	end })
	t20.Text = index5:Create("TextLabel", {
		Parent = t20.Label.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 8), ZIndex = 3, TextSize = 14, TextXAlignment = Enum.TextXAlignment.Left,
	})
	t20.Text:AddToTheme({ TextColor3 = "Text" })
	t20.SubElements = index5:Create("Frame", {
		Parent = t20.Label.Instance, Size = UDim2.new(0, 100, 0, 22), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -8, 0, 6),
		ZIndex = 3, BackgroundColor3 = Color3.fromRGB(38, 36, 42),
	})
	t20.SubElements:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UICorner", { Parent = t20.SubElements.Instance, CornerRadius = UDim.new(0, 4) })
	index5:Create("UIListLayout", {
		Parent = t20.SubElements.Instance, VerticalAlignment = Enum.VerticalAlignment.Center,
		HorizontalAlignment = Enum.HorizontalAlignment.Center, FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 5),
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	t20.KeyButton = index5:Create("TextButton", {
		Parent = t20.SubElements.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.30000001192092896, Text = "None", AutoButtonColor = false, Size = UDim2.new(1, -12, 1, 0),
		BackgroundTransparency = 1, SelectionOrder = 2, ZIndex = 3, TextSize = 13,
	})
	t20.KeyButton:AddToTheme({ TextColor3 = "Text" })
	t20.Modes = index5:Create("Frame", {
		Parent = t20.Label.Instance, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 14, 1, -8), Size = UDim2.new(1, -22, 0, 24),
		ZIndex = 3, BackgroundColor3 = Color3.fromRGB(38, 36, 42),
	})
	t20.Modes:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UICorner", { Parent = t20.Modes.Instance, CornerRadius = UDim.new(0, 5) })
	t20.Background = index5:Create("Frame", {
		Parent = t20.Modes.Instance, Size = UDim2.new(0.35, 0, 1, 0), ZIndex = 3, BackgroundTransparency = 0,
	})
	index5:Create("UICorner", { Parent = t20.Background.Instance, CornerRadius = UDim.new(0, 5) })
	index5:Create("UIGradient", {
		Parent = t20.Background.Instance, Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(166, 166, 166)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t20.Toggle = index5:Create("TextButton", {
		Parent = t20.Modes.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), TextTransparency = 0, Text = "Toggle",
		AutoButtonColor = false, Size = UDim2.new(0.35, 0, 1, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 0), ZIndex = 4,
		TextSize = 13,
	})
	t20.Toggle:AddToTheme({ TextColor3 = function()
		return index3.Theme.Text
	end })
	t20.Hold = index5:Create("TextButton", {
		Parent = t20.Modes.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.20000000298023224, Text = "Hold", AutoButtonColor = false, Size = UDim2.new(0.35, 0, 1, 0),
		BackgroundTransparency = 1, Position = UDim2.new(0.35, 0, 0, 0), ZIndex = 4, TextSize = 13,
	})
	t20.Hold:AddToTheme({ TextColor3 = function()
		return index3.Theme.Text
	end })
	t20.Always = index5:Create("TextButton", {
		Parent = t20.Modes.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.20000000298023224, Text = "Always", AutoButtonColor = false, Size = UDim2.new(0.3, 0, 1, 0),
		BackgroundTransparency = 1, Position = UDim2.new(0.7, 0, 0, 0), ZIndex = 4, TextSize = 13,
	})
	t20.Always:AddToTheme({ TextColor3 = function()
		return index3.Theme.Text
	end })
	if t19.Method then
		t20.Modes.Instance.Visible = false
		t20.Label.Instance.Size = UDim2.new(1, 0, 0, 34)
	end
	local v78 = nil
	if index3.KeyList then
		v78 = index3.KeyList:Add("", "")
	end
	local function f27()
		if v78 then
			v78:Set(t18.Name, t19.Value)
			v78:SetStatus(t19.Toggled)
		end
		if t19.Toggled then
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0 })
			t20.AccentBarGradient.Instance.Enabled = true
		else
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0.5 })
			t20.AccentBarGradient.Instance.Enabled = false
		end
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 0, 8) })
			t20.SubElements:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, -8, 0, 6) })
			t20.Modes:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 1, -8) })
			t20.AccentBar:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 4, 0.5, 0) })
		else
			t20.Text.Instance.Position = UDim2.new(0, 74, 0, 8)
			t20.SubElements.Instance.Position = UDim2.new(1, 52, 0, 6)
			t20.Modes.Instance.Position = UDim2.new(0, 74, 1, -8)
			t20.AccentBar.Instance.Position = UDim2.new(0, -20, 0.5, 0)
		end
	end
	t19.SetMode = function(arg3, arg4)
		if t19.Method then
			arg4 = t19.Method
			t19.ModeSelected = t19.Method
		end
		if arg4 == "Toggle" then
			t20.Background:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(0.35, 0, 1, 0) })
			t20.Toggle:ChangeItemTheme({ TextColor3 = function()
				return Color3.fromRGB(0, 0, 0)
			end })
			t20.Toggle:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0) })
			t20.Hold:ChangeItemTheme({ TextColor3 = function()
				return index3.Theme.Text
			end })
			t20.Hold:Tween(nil, { TextColor3 = index3.Theme.Text })
			t20.Always:ChangeItemTheme({ TextColor3 = function()
				return index3.Theme.Text
			end })
			t20.Always:Tween(nil, { TextColor3 = index3.Theme.Text })
		elseif arg4 == "Hold" then
			t20.Background:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0.35, 0, 0, 0), Size = UDim2.new(0.35, 0, 1, 0) })
			t20.Toggle:ChangeItemTheme({ TextColor3 = function()
				return index3.Theme.Text
			end })
			t20.Toggle:Tween(nil, { TextColor3 = index3.Theme.Text })
			t20.Hold:ChangeItemTheme({ TextColor3 = function()
				return Color3.fromRGB(0, 0, 0)
			end })
			t20.Hold:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0) })
			t20.Always:ChangeItemTheme({ TextColor3 = function()
				return index3.Theme.Text
			end })
			t20.Always:Tween(nil, { TextColor3 = index3.Theme.Text })
		elseif arg4 == "Always" then
			t20.Background:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0.7, 0, 0, 0), Size = UDim2.new(0.3, 0, 1, 0) })
			t20.Toggle:ChangeItemTheme({ TextColor3 = function()
				return index3.Theme.Text
			end })
			t20.Toggle:Tween(nil, { TextColor3 = index3.Theme.Text })
			t20.Hold:ChangeItemTheme({ TextColor3 = function()
				return index3.Theme.Text
			end })
			t20.Hold:Tween(nil, { TextColor3 = index3.Theme.Text })
			t20.Always:ChangeItemTheme({ TextColor3 = function()
				return Color3.fromRGB(0, 0, 0)
			end })
			t20.Always:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0) })
		end
		index3.Flags[t19.Flag] = { Mode = t19.ModeSelected, Key = t19.Key, Toggled = t19.Toggled }
		if t18.Callback then
			index3:SafeCall(t18.Callback, t19.Toggled)
		end
	end
	t19.Press = function(arg3, toggled)
		if t19.ModeSelected == "Toggle" then
			t19.Toggled = not t19.Toggled
		elseif t19.ModeSelected == "Hold" then
			t19.Toggled = toggled
		elseif t19.ModeSelected == "Always" then
			t19.Toggled = true
		end
		index3.Flags[t19.Flag] = { Mode = t19.ModeSelected, Key = t19.Key, Toggled = t19.Toggled }
		if t18.Callback then
			index3:SafeCall(t18.Callback, t19.Toggled)
		end
		f27()
	end
	t19.Get = function()
		return t19.Key, t19.ModeSelected, t19.Toggled
	end
	t19.Set = function(arg3, arg4)
		if string.find(tostring(arg4), "Enum") then
			t19.Key = tostring(arg4)
			local value = string.gsub(string.gsub(keyNames[t19.Key] or string.gsub(arg4.Name == "Backspace" and "None" or arg4.Name, "Enum.", "") or "None", "KeyCode.", ""), "UserInputType.", "") or "None"
			t19.Value = value
			t20.KeyButton.Instance.Text = value
			index3.Flags[t19.Flag] = { Mode = t19.ModeSelected, Key = t19.Key, Toggled = t19.Toggled }
			if t18.Callback then
				index3:SafeCall(t18.Callback, t19.Toggled)
			end
			f27()
		elseif type(arg4) == "table" then
			local key = arg4.Key == "Backspace" and "None" or arg4.Key
			t19.Key = tostring(arg4.Key)
			if t19.Method then
				t19.ModeSelected = t19.Method
				t19:SetMode(t19.Method)
			elseif arg4.ModeSelected then
				t19.ModeSelected = arg4.Mode
				t19:SetMode(arg4.Mode)
			else
				t19.ModeSelected = "Toggle"
				t19:SetMode("Toggle")
			end
			local v79 = keyNames[t19.Key] or string.gsub(tostring(key), "Enum.", "") or key
			if v79 then
				string.gsub(string.gsub(v79, "KeyCode.", ""), "UserInputType.", "")
			end
			local v80 = string.gsub(string.gsub(v79, "KeyCode.", ""), "UserInputType.", "")
			t19.Value = v80
			t20.KeyButton.Instance.Text = v80
			if t18.Callback then
				index3:SafeCall(t18.Callback, t19.Toggled)
			end
			f27()
		elseif table.find({ "Toggle", "Hold", "Always" }, arg4) then
			t19.ModeSelected = t19.Method or arg4
			t19:SetMode(t19.ModeSelected)
			if t18.Callback then
				index3:SafeCall(t18.Callback, t19.Toggled)
			end
			f27()
		end
		t19.Picking = false
	end
	t20.KeyButton:Connect("MouseButton1Click", function()
		t19.Picking = true
		t20.KeyButton.Instance.Text = "."
		index3:Thread(function()
			local n = 1
			while t19.Picking do
				if n == 4 then
					n = 1
				end
				t20.KeyButton.Instance.Text = n == 1 and "." or n == 2 and ".." or n == 3 and "..."
				n += 1
				task.wait(0.35)
			end
		end)
		local connection = nil
		connection = UserInputService.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.Keyboard then
				t19:Set(input.KeyCode)
			else
				t19:Set(input.UserInputType)
			end
			connection:Disconnect()
			connection = nil
		end)
	end)
	index3:Connect(UserInputService.InputBegan, function(arg3)
		if t19.Value == "None" then
			return
		end
		local key = t19.Key
		if tostring(arg3.KeyCode) == key then
			if t19.ModeSelected == "Toggle" then
				t19:Press()
			elseif t19.ModeSelected == "Hold" then
				t19:Press(true)
			elseif t19.ModeSelected == "Always" then
				t19:Press(true)
			end
		else
			local key2 = t19.Key
			if tostring(arg3.UserInputType) == key2 then
				if t19.ModeSelected == "Toggle" then
					t19:Press()
				elseif t19.ModeSelected == "Hold" then
					t19:Press(true)
				elseif t19.ModeSelected == "Always" then
					t19:Press(true)
				end
			end
		end
	end)
	index3:Connect(UserInputService.InputEnded, function(arg3)
		if t19.Value == "None" then
			return
		end
		local key = t19.Key
		if tostring(arg3.KeyCode) == key then
			if t19.ModeSelected == "Hold" then
				t19:Press(false)
			elseif t19.ModeSelected == "Always" then
				t19:Press(true)
			end
		else
			local key2 = t19.Key
			if tostring(arg3.UserInputType) == key2 then
				if t19.ModeSelected == "Hold" then
					t19:Press(false)
				elseif t19.ModeSelected == "Always" then
					t19:Press(true)
				end
			end
		end
	end)
	t20.Toggle:Connect("MouseButton1Down", function()
		if t19.Method then
			return
		end
		t19.ModeSelected = "Toggle"
		t19:SetMode("Toggle")
	end)
	t20.Hold:Connect("MouseButton1Down", function()
		if t19.Method then
			return
		end
		t19.ModeSelected = "Hold"
		t19:SetMode("Hold")
	end)
	t20.Always:Connect("MouseButton1Down", function()
		if t19.Method then
			return
		end
		t19.ModeSelected = "Always"
		t19:SetMode("Always")
	end)
	if t19.Default then
		t19:Set({ Mode = t19.Method or t19.Mode or "Toggle", Key = t19.Default })
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.Textbox = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Default = t18.Default or t18.default or ""
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Placeholder = t18.Placeholder or t18.placeholder or "Placeholder"
	t19.Numeric = t18.Numeric or t18.numeric or false
	t19.Finished = t18.Finished or t18.finished or false
	t19.ClearTextOnFocus = t18.ClearTextOnFocus or false
	t19.Value = ""
	local t20 = {
		Textbox = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, Active = true, BackgroundTransparency = 0, Selectable = true,
			Size = UDim2.new(1, 0, 0, 34), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t20.Textbox:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Textbox.Instance, CornerRadius = UDim.new(0, 5) })
	t20.AccentBar = index5:Create("Frame", {
		Parent = t20.Textbox.Instance, Size = UDim2.new(0, 2, 1, -12), Position = UDim2.new(0, 4, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5), ZIndex = 3, BackgroundTransparency = 0.5, BackgroundColor3 = Color3.fromRGB(80, 80, 90),
	})
	index5:Create("UICorner", { Parent = t20.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	t20.AccentBarGradient = index5:Create("UIGradient", { Parent = t20.AccentBar.Instance, Enabled = false, Rotation = 90 })
	t20.AccentBarGradient:AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t20.Input =index5:Create("TextBox", {
		Parent = t20.Textbox.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "", ZIndex = 3,
		Size = UDim2.new(1, -24, 1, 0), Position = UDim2.new(0, 14, 0, 0), BackgroundTransparency = 1,
		ClearTextOnFocus = t19.ClearTextOnFocus, PlaceholderColor3 = Color3.fromRGB(140, 140, 140),
		TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = t19.Placeholder, TextSize = 14,
	})
	t20.Input:AddToTheme({ TextColor3 = "Text" })
	t19.Get = function()
		return t19.Value
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Textbox.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Input:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 0, 0) })
			t20.AccentBar:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 4, 0.5, 0) })
		else
			t20.Input.Instance.Position = UDim2.new(0, 74, 0, 0)
			t20.AccentBar.Instance.Position = UDim2.new(0, -20, 0.5, 0)
		end
	end
	t19.Set = function(arg3, value)
		if t19.Numeric then
			local b15 = not tonumber(value)
			if b15 then
				local v78 = 0
				b15 = string.len(tostring(value)) > v78
			end
			if b15 then
				value = t19.Value
			end
		end
		t19.Value = value
		t20.Input.Instance.Text = value
		index3.Flags[t19.Flag] = value
		if value and value ~= "" then
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0 })
			t20.AccentBarGradient.Instance.Enabled = true
		else
			t20.AccentBar:Tween(nil, { BackgroundTransparency = 0.5 })
			t20.AccentBarGradient.Instance.Enabled = false
		end
		if t19.Callback then
			index3:SafeCall(t19.Callback, value)
		end
	end
	if t19.Finished then
		t20.Input:Connect("FocusLost", function(arg3)
			if arg3 then
				t19:Set(t20.Input.Instance.Text)
			end
		end)
	else
		index3:Connect(t20.Input.Instance:GetPropertyChangedSignal("Text"), function()
			t19:Set(t20.Input.Instance.Text)
		end)
	end
	if t19.Default then
		t19:Set(t19.Default)
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.Listbox = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Items = t18.Items or t18.items or { "One", "Two", "Three" }
	t19.Default = t18.Default or t18.default or nil
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Size = t18.Size or t18.size or 125
	t19.Multi = t18.Multi or t18.multi or false
	t19.Value = {}
	t19.Options = {}
	t19.IsOpen = false
	local t20 = {
		Listbox = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, t19.Size), ZIndex = 2,
		}),
	}
	t20.Search = index5:Create("TextBox", {
		Parent = t20.Listbox.Instance, FontFace = index3.Font, CursorPosition = -1, TextColor3 = Color3.fromRGB(240, 240, 240), Text = "",
		ZIndex = 2, Size = UDim2.new(1, 0, 0, 30), PlaceholderColor3 = Color3.fromRGB(185, 185, 185),
		TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Search..", TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	t20.Search:AddToTheme({ TextColor3 = "Text", BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Search.Instance, CornerRadius = UDim.new(0, 6) })
	index5:Create("UIPadding", {
		Parent = t20.Search.Instance, PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 8),
	})
	t20.Background = index5:Create("Frame", {
		Parent = t20.Listbox.Instance, Active = true, Size = UDim2.new(1, 0, 1, -30), Position = UDim2.new(0, 0, 0, 30),
		BackgroundColor3 = Color3.fromRGB(27, 26, 29), ZIndex = 2,
	})
	t20.Background:AddToTheme({ BackgroundColor3 = "Element" })
	t20.Holder = index5:Create("ScrollingFrame", {
		Parent = t20.Background.Instance, ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0), Active = true,
		AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2, Size = UDim2.new(1, -4, 1, -8),
		Position = UDim2.new(0, 0, 0, 4), BackgroundColor3 = Color3.fromRGB(27, 26, 29), ZIndex = 2, BackgroundTransparency = 1,
		CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	t20.Holder:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UICorner", { Parent = t20.Background.Instance, CornerRadius = UDim.new(0, 6) })
	index5:Create("UIListLayout", {
		Parent = t20.Holder.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", {
		Parent = t20.Holder.Instance, PaddingTop = UDim.new(0, 8), PaddingBottom = UDim.new(0, 8), PaddingRight = UDim.new(0, 12),
		PaddingLeft = UDim.new(0, 8),
	})
	t20._ = index5:Create("Frame", {
		Parent = t20.Listbox.Instance, Size = UDim2.new(1, 0, 0, 10), Position = UDim2.new(0, 0, 0, 25), ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	t20._:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("Frame", {
		Parent = t20._.Instance, Size = UDim2.new(1, 0, 0, 1), Position = UDim2.new(0, 0, 1, -3), AnchorPoint = Vector2.new(0, 1),
		ZIndex = 2, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	}):AddToTheme({ BackgroundColor3 = "Outline" })
	t19.Get = function()
		return t19.Value
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Listbox.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Background:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 30) })
			t20.Search:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) })
			t20._:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 25) })
		else
			t20.Background.Instance.Position = UDim2.new(0, 30, 0, 26)
			t20.Search.Instance.Position = UDim2.new(0, 30, 0, 0)
			t20._.Instance.Position = UDim2.new(0, 30, 0, 25)
		end
	end
	t19.Set = function(arg3, value)
		if t19.Multi then
			local v78 = "table"
			if type(value) ~= v78 then
				return
			end
			t19.Value = value
			index3.Flags[t19.Flag] = value
			for _, v79 in value do
				local v80 = t19.Options[v79]
				if v80 then
					v80.Selected = true
					v80:Toggle("Active")
				end
			end
		else
			if not t19.Options[value] then
				return
			end
			local v78 = t19.Options[value]
			t19.Value = value
			index3.Flags[t19.Flag] = value
			for _, v79 in t19.Options do
				if v79 ~= v78 then
					v79.Selected = false
					v79:Toggle("Inactive")
				else
					v79.Selected = true
					v79:Toggle("Active")
				end
			end
		end
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value)
		end
	end
	t19.Add = function(arg3, arg4)
		local tween = index5:Create("TextButton", {
			Parent = t20.Holder.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
			BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 20), ZIndex = 2, TextSize = 14,
		})
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, ZIndex = 2,
			Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(0, 6, 0, 6),
		})
		index5:Create("UIGradient", {
			Parent = tween2.Instance, Enabled = true, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		index5:Create("UICorner", { Parent = tween2.Instance })
		local tween3 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(255, 255, 255),
			TextTransparency = 0.30000001192092896, Text = arg4, Size = UDim2.new(0, 0, 0, 15), AnchorPoint = Vector2.new(0, 0.5),
			ZIndex = 2, BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.5, 0), AutomaticSize = Enum.AutomaticSize.X, TextSize = 14,
		})
		tween3:AddToTheme({ TextColor3 = "Text" })
		local t21
		t21 = {
			Button = tween, Name = arg4, OptionText = tween3, IsSearching = false, OptionAccent = tween2, Selected = false,
			Toggle = function(arg5, arg6)
				if arg6 == "Active" then
					tween3:Tween(nil, { TextTransparency = 0, Position = UDim2.new(0, 15, 0.5, 0) })
					tween2:Tween(nil, { BackgroundTransparency = 0 })
				else
					tween3:Tween(nil, { TextTransparency = 0.3, Position = UDim2.new(0, 0, 0.5, 0) })
					tween2:Tween(nil, { BackgroundTransparency = 1 })
				end
			end,
			Search = function(arg5, arg6)
				index3:Thread(function()
					if arg6 then
						t21.IsSearching = true
						local t22 = { TextTransparency = 1 }
						tween3:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), t22)
						task.wait(0.08)
						tween:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 0) })
						if t21.Selected then
							tween2:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
						end
					else
						t21.IsSearching = false
						tween3:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { TextTransparency = t21.Selected and 0 or 0.3 })
						task.wait(0.08)
						tween:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 24) })
						if t21.Selected then
							tween2:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 0 })
						end
					end
				end)
			end,
			Set = function()
				t21.Selected = not t21.Selected
				if t19.Multi then
					local v78 = table.find(t19.Value, t21.Name)
					if v78 then
						table.remove(t19.Value, v78)
					else
						table.insert(t19.Value, t21.Name)
					end
					t21:Toggle(v78 and "Inactive" or "Active")
					index3.Flags[t19.Flag] = t19.Value
				elseif t21.Selected then
					t19.Value = t21.Name
					index3.Flags[t19.Flag] = t21.Name
					t21.Selected = true
					t21:Toggle("Active")
					for _, v78 in t19.Options do
						if v78 ~= t21 and not v78.IsSearching then
							v78.Selected = false
							v78:Toggle("Inactive")
						end
					end
				else
					t19.Value = nil
					index3.Flags[t19.Flag] = nil
					t21.Selected = false
					t21:Toggle("Inactive")
				end
				if t19.Callback then
					index3:SafeCall(t19.Callback, t19.Value)
				end
			end,
		}
		t21.Button:Connect("MouseButton1Down", function()
			t21:Set()
		end)
		t19.Options[t21.Name] = t21
		return t21
	end
	t19.Remove = function(arg3, arg4)
		if t19.Options[arg4] then
			t19.Options[arg4].Button:Clean()
			t19.Options[arg4] = nil
		end
	end
	t19.Refresh = function(arg3, arg4)
		for _, v78 in t19.Options do
			t19:Remove(v78.Name)
		end
		for _, v78 in arg4 do
			t19:Add(v78)
		end
	end
	index3:Connect(t20.Search.Instance:GetPropertyChangedSignal("Text"), function()
		index3:Thread(function()
			for _, v78 in t19.Options do
				local text = t20.Search.Instance.Text
				if text ~= "" then
					local escapePattern = index3.EscapePattern
					if string.find(string.lower(v78.Name), escapePattern(index3, string.lower(text))) then
						v78.Button.Instance.Visible = true
						v78:Search(false)
					else
						v78:Search(true)
						v78.Button.Instance.Visible = false
					end
				else
					v78:Search(false)
					v78.Button.Instance.Visible = true
				end
			end
		end)
	end)
	for _, v78 in t19.Items do
		t19:Add(v78)
	end
	if t19.Default then
		t19:Set(t19.Default)
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.DropdownEx = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Dropdown" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Items = t18.Items or t18.items or {}
	t19.Default = t18.Default or t18.default or nil
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Size = t18.Size or t18.size or 125
	t19.OptionHolderSize = t18.OptionHolderSize or t18.optionholder or 280
	t19.Multi = t18.Multi or t18.multi or false
	t19.Searchable = t18.Searchable ~= false
	t19.DefaultIcon = t18.DefaultIcon or t18.defaulticon or "123944728972740"
	t19.Value = t18.Multi and {} or nil
	t19.Options = {}
	t19.OptionsWithIndexes = {}
	t19.IsOpen = false
	t19.SearchQuery = ""
	local t20 = {
		Dropdown = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, Name = "DropdownEx", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 27),
			ZIndex = 2,
		}),
	}
	t20.Text = index5:Create("TextLabel", {
		Parent = t20.Dropdown.Instance, Name = "01", FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.3, Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15),
		AnchorPoint = Vector2.new(0, 0.5), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.5, 0), ZIndex = 2, TextSize = 14,
	})
	t20.Text:AddToTheme({ TextColor3 = "Text" })
	t20.RealDropdown = index5:Create("TextButton", {
		Parent = t20.Dropdown.Instance, Name = "02", FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "",
		Size = UDim2.new(0, t19.Size or 125, 0, 25), AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.new(1, 0, 0, 0), ZIndex = 2, TextSize = 14, BackgroundColor3 = Color3.fromRGB(26, 26, 29),
	})
	t20.RealDropdown:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.RealDropdown.Instance, CornerRadius = UDim.new(0, 6) })
	t20.Value = index5:Create("TextLabel", {
		Parent = t20.RealDropdown.Instance, Name = "03", FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.3, Text = "-", Size = UDim2.new(1, -40, 0, 15), AnchorPoint = Vector2.new(0, 0.5),
		TextTruncate = Enum.TextTruncate.AtEnd, BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0.5, -1),
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 2, TextSize = 14,
	})
	t20.Value:AddToTheme({ TextColor3 = "Text" })
	t20.Liner = index5:Create("Frame", {
		Parent = t20.RealDropdown.Instance, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -27, 0, 0),
		Size = UDim2.new(0, 2, 1, 0), ZIndex = 2, BackgroundColor3 = Color3.fromRGB(34, 32, 36),
	})
	t20.Liner:AddToTheme({ BackgroundColor3 = "Outline" })
	t20.ArrowIcon = index5:Create("ImageLabel", {
		Parent = t20.RealDropdown.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 16, 0, 8),
		AnchorPoint = Vector2.new(1, 0.5), Image = "rbxassetid://123317177279443", BackgroundTransparency = 1,
		Position = UDim2.new(1, -5, 0.5, 0), ZIndex = 2,
	})
	local v78 = 255
	local v79 = 255
	t20.Gradient = index5:Create("UIGradient", {
		Parent = t20.ArrowIcon.Instance, Enabled = false,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(131, 131, 131)), ColorSequenceKeypoint.new(1, Color3.fromRGB(v78, 255, v79)) }),
	})
	t20.Gradient:AddToTheme({ Color = function()
		local v80 = 1
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v80, accentGradient) })
	end })
	t20.OptionHolder = index5:Create("TextButton", {
		Parent = index3.UnusedHolder.Instance, Text = "", AutoButtonColor = false, Visible = false, Position = UDim2.new(0, 897, 0, 101),
		Size = UDim2.new(0, 280, 0, t19.OptionHolderSize), BackgroundColor3 = Color3.fromRGB(26, 25, 29),
	})
	t20.OptionHolder:AddToTheme({ BackgroundColor3 = "Background" })
	index5:Create("UIStroke", {
		Parent = t20.OptionHolder.Instance, Color = Color3.fromRGB(35, 33, 38), ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}):AddToTheme({ Color = "Outline" })
	index5:Create("UICorner", { Parent = t20.OptionHolder.Instance, CornerRadius = UDim.new(0, 6) })
	if t19.Searchable then
		t20.Search = index5:Create("TextBox", {
			Parent = t20.OptionHolder.Instance, FontFace = index3.Font, CursorPosition = -1, TextColor3 = Color3.fromRGB(240, 240, 240),
			Text = "", ZIndex = 6, Size = UDim2.new(1, -16, 0, 28), Position = UDim2.new(0, 8, 0, 8),
			PlaceholderColor3 = Color3.fromRGB(185, 185, 185), TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Search..",
			TextSize = 13, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		})
		t20.Search:AddToTheme({ TextColor3 = "Text", BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = t20.Search.Instance, CornerRadius = UDim.new(0, 4) })
		index5:Create("UIPadding", { Parent = t20.Search.Instance, PaddingLeft = UDim.new(0, 28) })
		t20.SearchIcon = index5:Create("ImageLabel", {
			Parent = t20.Search.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 14, 0, 14),
			AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(964, 324),
			ImageRectSize = Vector2.new(36, 36), BackgroundTransparency = 1, Position = UDim2.new(0, -20, 0.5, 0), ZIndex = 4,
		})
	end
	t20.Holder = index5:Create("ScrollingFrame", {
		Parent = t20.OptionHolder.Instance, Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
		Size = UDim2.new(1, -16, 1, t19.Searchable and -52 or -16), BackgroundTransparency = 1,
		Position = UDim2.new(0, 8, 0, t19.Searchable and 44 or 8), ZIndex = 6, CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	t20.Holder:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UIListLayout", {
		Parent = t20.Holder.Instance, Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	t20.EmptyText = index5:Create("TextLabel", {
		Parent = t20.OptionHolder.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(141, 141, 150), Text = "No results",
		Size = UDim2.new(1, 0, 0, 30), Position = UDim2.new(0, 0, 0.5, 0), BackgroundTransparency = 1, TextSize = 13, Visible = false,
		ZIndex = 6,
	})
	t20.Text.Instance.Position = UDim2.new(0, 30, 0.5, 0)
	t20.RealDropdown.Instance.Position = UDim2.new(1, 26, 0, 0)
	t19.Get = function()
		return t19.Value
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Dropdown.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0.5, 0) })
			t20.RealDropdown:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, 0, 0, 0) })
		else
			t20.Text.Instance.Position = UDim2.new(0, 30, 0.5, 0)
			t20.RealDropdown.Instance.Position = UDim2.new(1, 30, 0, 0)
		end
	end
	t20.RealDropdown:OnHover(function()
		if t19.IsOpen then
			return
		end
		t20.ArrowIcon:Tween(nil, { ImageColor3 = Color3.fromRGB(255, 255, 255) })
		t20.Gradient.Instance.Enabled = true
	end)
	t20.RealDropdown:OnHoverLeave(function()
		if t19.IsOpen then
			return
		end
		t20.ArrowIcon:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
		t20.Gradient.Instance.Enabled = false
	end)
	t19.RefreshSearch = function()
		local v80 = string.lower(t19.SearchQuery or "")
		local b15 = false
		for _, v81 in t19.Options do
			if v80 == "" then
				v81.Container.Instance.Visible = true
				b15 = true
			else
				local escapePattern = index3.EscapePattern
				local visible = string.find(string.lower(v81.Name), escapePattern(index3, v80)) ~= nil
				if not visible then
					visible = v81.Description
					if visible then
						local escapePattern2 = index3.EscapePattern
						visible = string.find(string.lower(v81.Description), escapePattern2(index3, v80)) ~= nil
					end
				end
				v81.Container.Instance.Visible = visible
				if visible then
					b15 = true
				end
			end
		end
		t20.EmptyText.Instance.Visible = not b15
	end
	local connection = nil
	t19.SetOpen = function(arg3, isOpen)
		if Debounce then
			return
		end
		t19.IsOpen = isOpen
		Debounce = true
		if t19.IsOpen then
			t20.OptionHolder.Instance.Visible = true
			t20.OptionHolder.Instance.Parent = index3.Holder.Instance
			t20.ArrowIcon:Tween(nil, { Rotation = 180, ImageColor3 = Color3.fromRGB(255, 255, 255) })
			t20.Gradient.Instance.Enabled = true
			connection = RunService.RenderStepped:Connect(function()
				t20.OptionHolder.Instance.Position = UDim2.new(0, t20.RealDropdown.Instance.AbsolutePosition.X - 280 - t20.RealDropdown.Instance.AbsoluteSize.X, 0, t20.RealDropdown.Instance.AbsolutePosition.Y + t20.RealDropdown.Instance.AbsoluteSize.Y + 5)
			end)
			for _, v80 in index3.OpenFrames do
				if v80 ~= t19 and not t19.Section.IsSettings then
					v80:SetOpen(false)
				end
			end
			index3.OpenFrames[t19] = t19
		else
			if index3.OpenFrames[t19] then
				index3.OpenFrames[t19] = nil
			end
			if connection then
				connection:Disconnect()
				connection = nil
			end
			t20.ArrowIcon:Tween(nil, { Rotation = 0, ImageColor3 = Color3.fromRGB(141, 141, 150) })
			t20.Gradient.Instance.Enabled = false
			for _, v80 in t19.Options do
				if v80.IsDescriptionOpen then
					v80:ToggleDescription()
				end
			end
		end
		local descendants = t20.OptionHolder.Instance:GetDescendants()
		table.insert(descendants, t20.OptionHolder.Instance)
		local v80 = nil
		for _, v81 in descendants do
			local property = index4:GetProperty(v81)
			if property then
				if not v81.ClassName:find("UI") then
					v81.ZIndex = t19.IsOpen and t19.Section.IsSettings and 9 or t19.IsOpen and 6 or 1
				end
				local v82 = "table"
				if type(property) == v82 then
					for _, v83 in property do
						v80 = index4:FadeItem(v81, v83, isOpen, index3.FadeSpeed)
					end
				else
					v80 = index4:FadeItem(v81, property, isOpen, index3.FadeSpeed)
				end
			end
		end
		if v80 then
			v80.Tween.Completed:Connect(function()
				Debounce = false
				t20.OptionHolder.Instance.Visible = t19.IsOpen
				task.wait(0.2)
				t20.OptionHolder.Instance.Parent = not t19.IsOpen and index3.UnusedHolder.Instance or index3.Holder.Instance
			end)
		else
			Debounce = false
		end
	end
	t19.UpdateValueText = function()
		if t19.Multi then
			local t21 = {}
			for _, v80 in t19.Value do
				table.insert(t21, v80)
			end
			t20.Value.Instance.Text = #t21 > 0 and table.concat(t21, ", ") or "..."
		else
			t20.Value.Instance.Text = t19.Value or "..."
		end
	end
	t19.Set = function(arg3, value)
		if t19.Multi then
			if type(value) ~= "table" then
				return
			end
			t19.Value = value
			index3.Flags[t19.Flag] = value
			for _, v80 in t19.Options do
				local selected = table.find(value, v80.Name) ~= nil
				v80.Selected = selected
				v80:Toggle(selected and "Active" or "Inactive")
			end
		else
			if not t19.Options[value] then
				return
			end
			local v80 = t19.Options[value]
			t19.Value = value
			index3.Flags[t19.Flag] = value
			for _, v81 in t19.Options do
				if v81 ~= v80 then
					v81.Selected = false
					v81:Toggle("Inactive")
				else
					v81.Selected = true
					v81:Toggle("Active")
				end
			end
		end
		t19:UpdateValueText()
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value)
		end
	end
	t19.Add = function(arg3, arg4)
		local description = nil
		local icon = nil
		if type(arg4) == "table" then
			local name = arg4.Name or arg4.name
			description = arg4.Description or arg4.description
			icon = arg4.Icon
			if icon then
				arg4 = name
			else
				icon = arg4.icon
				arg4 = name
			end
		end
		if not arg4 or t19.Options[arg4] then
			return
		end
		local b15 = description and description ~= ""
		local tween = index5:Create("Frame", {
			Parent = t20.Holder.Instance, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 44), ZIndex = 6, ClipsDescendants = true,
		})
		local tween2 = index5:Create("TextButton", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
			BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 44), Position = UDim2.new(0, 0, 0, 0), ZIndex = 6, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(34, 32, 36),
		})
		tween2:AddToTheme({ BackgroundColor3 = "Section Top" })
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(0, 4) })
		local tween3 = index5:Create("Frame", {
			Parent = tween2.Instance, Size = UDim2.new(0, 32, 0, 32), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 6, 0.5, 0),
			ZIndex = 4, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		})
		tween3:AddToTheme({ BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = tween3.Instance, CornerRadius = UDim.new(0, 4) })
		local tween4 = index5:Create("ImageLabel", {
			Parent = tween3.Instance, ImageColor3 = Color3.fromRGB(255, 255, 255), Size = UDim2.new(1, -6, 1, -6),
			AnchorPoint = Vector2.new(0.5, 0.5), Image = "rbxassetid://" .. (icon or t19.DefaultIcon), BackgroundTransparency = 1,
			Position = UDim2.new(0.5, 0, 0.5, 0), ZIndex = 5, ScaleType = Enum.ScaleType.Fit,
		})
		local tween5 = index5:Create("Frame", {
			Parent = tween2.Instance, Size = UDim2.new(0, 4, 0, 4), AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 44, 0.5, 0),
			ZIndex = 4, BackgroundTransparency = 1,
		})
		index5:Create("UICorner", { Parent = tween5.Instance, CornerRadius = UDim.new(1, 0) })
		index5:Create("UIGradient", { Parent = tween5.Instance, Rotation = -115 }):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		local n = b15 and 88 or 60
		local tween6 = index5:Create("TextLabel", {
			Parent = tween2.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.3,
			Text = arg4, Size = UDim2.new(1, -n, 1, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 54, 0, 0), ZIndex = 4,
			TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, TextSize = 14,
		})
		tween6:AddToTheme({ TextColor3 = "Text" })
		local tween7 = nil
		local tween8 = nil
		local tween9 = nil
		if b15 then
			tween7 = index5:Create("ImageButton", {
				Parent = tween2.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 16, 0, 16),
				AnchorPoint = Vector2.new(1, 0.5), Image = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(764, 764),
				ImageRectSize = Vector2.new(36, 36), BackgroundTransparency = 1, Position = UDim2.new(1, -10, 0.5, 0), ZIndex = 5,
				AutoButtonColor = false,
			})
			tween8 = index5:Create("Frame", {
				Parent = tween.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, -8, 0, 0), Position = UDim2.new(0, 4, 0, 46),
				ZIndex = 6, ClipsDescendants = true, BackgroundColor3 = Color3.fromRGB(22, 21, 24),
			})
			tween8:AddToTheme({ BackgroundColor3 = "Background" })
			index5:Create("UICorner", { Parent = tween8.Instance, CornerRadius = UDim.new(0, 4) })
			local tween10 = index5:Create("Frame", {
				Parent = tween8.Instance, Size = UDim2.new(0, 2, 1, -8), Position = UDim2.new(0, 4, 0, 4), ZIndex = 4,
			})
			index5:Create("UICorner", { Parent = tween10.Instance, CornerRadius = UDim.new(1, 0) })
			index5:Create("UIGradient", { Parent = tween10.Instance, Rotation = 90 }):AddToTheme({ Color = function()
				local accentGradient = index3.Theme.AccentGradient
				return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
			end })
			tween9 = index5:Create("TextLabel", {
				Parent = tween8.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(200, 200, 200), TextTransparency = 0.2,
				Text = description, BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 6), Size = UDim2.new(1, -20, 1, -12),
				ZIndex = 4, TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
				TextSize = 12,
			})
			tween9:AddToTheme({ TextColor3 = "Text" })
			tween7:OnHover(function()
				tween7:Tween(nil, { ImageColor3 = index3.Theme.Accent })
			end)
			tween7:OnHoverLeave(function()
				if not OptionData or not OptionData.IsDescriptionOpen then
					tween7:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
				end
			end)
		end
		local t21
		t21 = {
			Container = tween, Button = tween2, Name = arg4, Description = description, HasDescription = b15, Icon = tween4, Text = tween6,
			SelectIndicator = tween5, InfoButton = tween7, DescriptionFrame = tween8, DescriptionText = tween9, Selected = false,
			IsDescriptionOpen = false, TargetHeight = 44,
			Toggle = function(arg5, arg6)
				if arg6 == "Active" then
					tween6:Tween(nil, { TextTransparency = 0 })
					tween5:Tween(nil, { BackgroundTransparency = 0, Size = UDim2.new(0, 4, 0, 22) })
					tween4:Tween(nil, { ImageTransparency = 0 })
				else
					tween6:Tween(nil, { TextTransparency = 0.3 })
					tween5:Tween(nil, { BackgroundTransparency = 1, Size = UDim2.new(0, 4, 0, 4) })
					tween4:Tween(nil, { ImageTransparency = 0.3 })
				end
			end,
			ToggleDescription = function()
				if not b15 then
					return
				end
				t21.IsDescriptionOpen = not t21.IsDescriptionOpen
				if t21.IsDescriptionOpen then
					tween9.Instance.Size = UDim2.new(0, tween.Instance.AbsoluteSize.X - 28, 0, 9999)
					local n32 = tween9.Instance.TextBounds.Y + 12
					tween9.Instance.Size = UDim2.new(1, -20, 1, -12)
					t21.TargetHeight = 44 + n32 + 6
					tween:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, t21.TargetHeight) })
					tween8:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, n32) })
					tween7:Tween(nil, { ImageColor3 = index3.Theme.Accent, Rotation = 180 })
				else
					t21.TargetHeight = 44
					tween:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 44) })
					tween8:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, 0) })
					tween7:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150), Rotation = 0 })
				end
			end,
			Set = function()
				t21.Selected = not t21.Selected
				if t19.Multi then
					local v80 = table.find(t19.Value, t21.Name)
					if v80 then
						table.remove(t19.Value, v80)
					else
						table.insert(t19.Value, t21.Name)
					end
					t21:Toggle(v80 and "Inactive" or "Active")
					index3.Flags[t19.Flag] = t19.Value
				elseif t21.Selected then
					t19.Value = t21.Name
					index3.Flags[t19.Flag] = t21.Name
					t21:Toggle("Active")
					for _, v80 in t19.Options do
						if v80 ~= t21 then
							v80.Selected = false
							v80:Toggle("Inactive")
						end
					end
				else
					t19.Value = nil
					index3.Flags[t19.Flag] = nil
					t21:Toggle("Inactive")
				end
				t19:UpdateValueText()
				if t19.Callback then
					index3:SafeCall(t19.Callback, t19.Value)
				end
			end,
		}
		tween2:Connect("MouseButton1Down", function()
			if tween7 then
				local mouseLocation = UserInputService:GetMouseLocation()
				local absolutePosition = tween7.Instance.AbsolutePosition
				local absoluteSize = tween7.Instance.AbsoluteSize
				if mouseLocation.X >= absolutePosition.X and mouseLocation.X <= absolutePosition.X + absoluteSize.X and mouseLocation.Y >= absolutePosition.Y and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y then
					return
				end
			end
			t21:Set()
		end)
		if tween7 then
			tween7:Connect("MouseButton1Down", function()
				t21:ToggleDescription()
			end)
		end
		tween2:OnHover(function()
			tween2:Tween(nil, { BackgroundTransparency = 0 })
		end)
		tween2:OnHoverLeave(function()
			tween2:Tween(nil, { BackgroundTransparency = 0.3 })
		end)
		tween2.Instance.BackgroundTransparency = 0.3
		t19.Options[arg4] = t21
		table.insert(t19.OptionsWithIndexes, t21)
		return t21
	end
	t19.Remove = function(arg3, arg4)
		if t19.Options[arg4] then
			t19.Options[arg4].Container:Clean()
			t19.Options[arg4] = nil
			for k_, v80 in t19.OptionsWithIndexes do
				if v80.Name == arg4 then
					table.remove(t19.OptionsWithIndexes, k_)
					break
				end
			end
		end
	end
	t19.Refresh = function(arg3, arg4)
		for _, v80 in t19.Options do
			t19:Remove(v80.Name)
		end
		for _, v80 in arg4 do
			t19:Add(v80)
		end
	end
	t20.RealDropdown:Connect("MouseButton1Down", function()
		t19:SetOpen(not t19.IsOpen)
	end)
	if t19.Searchable and t20.Search then
		index3:Connect(t20.Search.Instance:GetPropertyChangedSignal("Text"), function()
			t19.SearchQuery = t20.Search.Instance.Text
			t19:RefreshSearch()
		end)
	end
	index3:Connect(UserInputService.InputBegan, function(arg3)
		if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
			if t19.IsOpen then
				if index3:IsMouseOverFrame(t20.OptionHolder) then
					return
				end
				t19:SetOpen(false)
			end
		end
	end)
	for _, v80 in t19.Items do
		t19:Add(v80)
	end
	if t19.Default then
		t19:Set(t19.Default)
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.Priority = function(arg, arg2)
	local t18 = arg2 or {}
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Priority" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.Items = t18.Items or t18.items or {}
	t19.Size = t18.Size or t18.size or 150
	t19.Default = t18.Default or t18.default or nil
	t19.StartCollapsed = t18.StartCollapsed or t18.startcollapsed or false
	t19.Searchable = t18.Searchable or t18.searchable or false
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.Value = {}
	t19.Options = {}
	t19.Dragging = nil
	t19.DragOffset = 0
	t19.IsCollapsed = false
	t19.SearchQuery = ""
	local n = t19.Searchable and 32 or 0
	local t20 = {
		Priority = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, t19.Size + 28 + n + 4),
			ZIndex = 2, ClipsDescendants = true,
		}),
	}
	t20.Header = index5:Create("TextButton", {
		Parent = t20.Priority.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
		Size = UDim2.new(1, 0, 0, 28), Position = UDim2.new(0, 0, 0, 0), ZIndex = 2, TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	t20.Header:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Header.Instance, CornerRadius = UDim.new(0, 6) })
	t20.ArrowIcon = index5:Create("ImageLabel", {
		Parent = t20.Header.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 14, 0, 8),
		AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://123317177279443", BackgroundTransparency = 1,
		Position = UDim2.new(0, 10, 0.5, 0), ZIndex = 3, Rotation = 180,
	})
	t20.Title = index5:Create("TextLabel", {
		Parent = t20.Header.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.3,
		Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 32, 0.5, 0), ZIndex = 3, TextXAlignment = Enum.TextXAlignment.Left,
		TextSize = 14,
	})
	t20.Title:AddToTheme({ TextColor3 = "Text" })
	t20.Counter = index5:Create("TextLabel", {
		Parent = t20.Header.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(141, 141, 150), TextTransparency = 0.3,
		Text = "0 items", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -12, 0.5, 0), ZIndex = 3, TextXAlignment = Enum.TextXAlignment.Right,
		TextSize = 13,
	})
	t20.Counter:AddToTheme({ TextColor3 = "Text" })
	if t19.Searchable then
		t20.Search = index5:Create("TextBox", {
			Parent = t20.Priority.Instance, FontFace = index3.Font, CursorPosition = -1, TextColor3 = Color3.fromRGB(240, 240, 240),
			Text = "", ZIndex = 3, Size = UDim2.new(1, 0, 0, 28), Position = UDim2.new(0, 0, 0, 32),
			PlaceholderColor3 = Color3.fromRGB(185, 185, 185), TextXAlignment = Enum.TextXAlignment.Left, PlaceholderText = "Search..",
			TextSize = 13, BackgroundColor3 = Color3.fromRGB(26, 26, 29),
		})
		t20.Search:AddToTheme({ TextColor3 = "Text", BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = t20.Search.Instance, CornerRadius = UDim.new(0, 4) })
		index5:Create("UIPadding", { Parent = t20.Search.Instance, PaddingLeft = UDim.new(0, 28) })
		t20.SearchIcon = index5:Create("ImageLabel", {
			Parent = t20.Search.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 14, 0, 14),
			AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(964, 324),
			ImageRectSize = Vector2.new(36, 36), BackgroundTransparency = 1, Position = UDim2.new(0, -20, 0.5, 0), ZIndex = 4,
		})
	end
	t20.Background = index5:Create("Frame", {
		Parent = t20.Priority.Instance, Size = UDim2.new(1, 0, 0, t19.Size), Position = UDim2.new(0, 0, 0, 28 + n + 4), ZIndex = 2,
		BackgroundColor3 = Color3.fromRGB(26, 26, 29),
	})
	t20.Background:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t20.Background.Instance, CornerRadius = UDim.new(0, 6) })
	t20.Holder = index5:Create("ScrollingFrame", {
		Parent = t20.Background.Instance, Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
		Size = UDim2.new(1, -8, 1, -8), Position = UDim2.new(0, 4, 0, 4), BackgroundTransparency = 1, ZIndex = 2,
		CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	t20.Holder:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UIPadding", {
		Parent = t20.Holder.Instance, PaddingTop = UDim.new(0, 4), PaddingLeft = UDim.new(0, 4), PaddingRight = UDim.new(0, 8),
	})
	t19.UpdateCounter = function()
		local n32 = #t19.Value
		t20.Counter.Instance.Text = n32 .. (n32 == 1 and " item" or " items")
	end
	t19.HighlightText = function(arg3, arg4, arg5)
		if not arg5 or arg5 == "" then
			return arg4
		end
		local v78 = string.lower(arg4)
		local v79 = string.lower(arg5)
		local v80 = index3:EscapePattern(v79)
		local accent = index3.Theme.Accent
		local n32 = 1
		local str8 = ""
		while true do
			local v81, v82 = string.find(v78, v80, n32)
			if not v81 then
				break
			else
				str8 = (str8 .. string.sub(arg4, n32, v81 - 1)) .. index3:ToRich(string.sub(arg4, v81, v82), accent)
				n32 = v82 + 1
			end
		end
		return str8 .. string.sub(arg4, n32)
	end
	t19.RefreshHighlights = function()
		for _, v78 in t19.Options do
			if t19.SearchQuery ~= "" then
				v78.Text.Instance.RichText = true
				v78.Text.Instance.Text = t19:HighlightText(v78.Name, t19.SearchQuery)
				local escapePattern = index3.EscapePattern
				local searchQuery = t19.SearchQuery
				if string.find(string.lower(v78.Name), escapePattern(index3, string.lower(searchQuery))) ~= nil then
					v78.Button:Tween(nil, { BackgroundTransparency = 0 })
					v78.DragHandle:Tween(nil, { ImageColor3 = index3.Theme.Accent })
				else
					v78.Button:Tween(nil, { BackgroundTransparency = 0.5 })
					v78.DragHandle:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
				end
			else
				v78.Text.Instance.RichText = false
				v78.Text.Instance.Text = v78.Name
				v78.Button:Tween(nil, { BackgroundTransparency = 0 })
				v78.DragHandle:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
			end
		end
	end
	t19.ScrollToFirstMatch = function()
		if t19.SearchQuery == "" then
			return
		end
		local n32 = 0
		for _, v78 in t19.Value do
			local v79 = t19.Options[v78]
			if v79 then
				local escapePattern = index3.EscapePattern
				local searchQuery = t19.SearchQuery
				if string.find(string.lower(v78), escapePattern(index3, string.lower(searchQuery))) then
					t20.Holder:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { CanvasPosition = Vector2.new(0, math.max(0, n32 - 10)) })
					break
				else
					n32 = n32 + v79.Container.Instance.Size.Y.Offset + 4
				end
			end
		end
	end
	t19.UpdatePositions = function(arg3, arg4)
		local n32 = 0
		for k_, v78 in t19.Value do
			local v79 = t19.Options[v78]
			if v79 then
				local targetHeight = v79.TargetHeight or v79.Container.Instance.Size.Y.Offset
				if not (arg4 and t19.Dragging == v79) then
					v79.Container:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, n32) })
					v79.RankLabel.Instance.Text = tostring(k_)
				end
				n32 = n32 + targetHeight + 4
			end
		end
		t19:UpdateCounter()
	end
	t19.SetCollapsed = function(arg3, isCollapsed)
		t19.IsCollapsed = isCollapsed
		if isCollapsed then
			t20.Priority:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 28) })
			t20.ArrowIcon:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 90 })
			t20.Background:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 0) })
			if t20.Search then
				t20.Search:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, TextTransparency = 1 })
				if t20.SearchIcon then
					t20.SearchIcon:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { ImageTransparency = 1 })
				end
			end
		else
			t20.Priority:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, t19.Size + 28 + n + 4) })
			t20.ArrowIcon:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 })
			t20.Background:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, t19.Size) })
			if t20.Search then
				t20.Search:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 28), BackgroundTransparency = 0, TextTransparency = 0 })
				if t20.SearchIcon then
					local t21 = { ImageTransparency = 0 }
					t20.SearchIcon:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), t21)
				end
			end
		end
	end
	t19.Toggle = function()
		t19:SetCollapsed(not t19.IsCollapsed)
	end
	t19.Get = function()
		return t19.Value
	end
	t19.Set = function(arg3, arg4)
		local value = t19.Value
		t19.Value = {}
		for _, v78 in arg4 do
			if t19.Options[v78] and not table.find(t19.Value, v78) then
				table.insert(t19.Value, v78)
			end
		end
		for _, v78 in value do
			if not table.find(t19.Value, v78) then
				table.insert(t19.Value, v78)
			end
		end
		index3.Flags[t19.Flag] = t19.Value
		t19:UpdatePositions()
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value)
		end
	end
	t19.SetVisibility = function(arg3, visible)
		t20.Priority.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t20.Header:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 0) })
			t20.Background:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 28 + n + 4) })
			if t20.Search then
				t20.Search:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 0, 0, 32) })
			end
		else
			t20.Header.Instance.Position = UDim2.new(0, 30, 0, 0)
			t20.Background.Instance.Position = UDim2.new(0, 26, 0, 28 + n + 4)
			if t20.Search then
				t20.Search.Instance.Position = UDim2.new(0, 30, 0, 32)
			end
		end
	end
	t19.Add = function(arg3, arg4, arg5)
		if type(arg4) == "table" then
			local name = arg4.Name or arg4.name
			arg5 = arg4.Description or arg4.description or arg4.Desc
			if arg5 then
				arg4 = name
			else
				arg5 = arg4.desc
				arg4 = name
			end
		end
		if t19.Options[arg4] then
			return
		end
		local b15 = arg5 and arg5 ~= ""
		local tween = index5:Create("Frame", {
			Parent = t20.Holder.Instance, BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 28), Position = UDim2.new(0, 0, 0, 0),
			ZIndex = 3, ClipsDescendants = true,
		})
		local tween2 = index5:Create("TextButton", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(0, 0, 0), Text = "", AutoButtonColor = false,
			Size = UDim2.new(1, 0, 0, 28), Position = UDim2.new(0, 0, 0, 0), ZIndex = 3, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(34, 32, 36),
		})
		tween2:AddToTheme({ BackgroundColor3 = "Section Top" })
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(0, 4) })
		local tween3 = index5:Create("ImageLabel", {
			Parent = tween2.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 14, 0, 14),
			AnchorPoint = Vector2.new(0, 0.5), Image = "rbxassetid://3994271045", BackgroundTransparency = 1,
			Position = UDim2.new(0, 8, 0.5, 0), ZIndex = 4,
		})
		local tween4 = index5:Create("TextLabel", {
			Parent = tween2.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.5,
			Text = "1", Size = UDim2.new(0, 24, 1, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 26, 0, 0), ZIndex = 4,
			TextXAlignment = Enum.TextXAlignment.Center, TextSize = 13,
		})
		tween4:AddToTheme({ TextColor3 = "Text" })
		local tween5 = index5:Create("TextLabel", {
			Parent = tween2.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0, Text = arg4,
			RichText = false, Size = UDim2.new(1, b15 and -84 or -60, 1, 0), BackgroundTransparency = 1, Position = UDim2.new(0, 54, 0, 0),
			ZIndex = 4, TextXAlignment = Enum.TextXAlignment.Left, TextSize = 14,
		})
		tween5:AddToTheme({ TextColor3 = "Text" })
		local tween6 = nil
		local tween7 = nil
		local tween8 = nil
		if b15 then
			tween6 = index5:Create("ImageButton", {
				Parent = tween2.Instance, ImageColor3 = Color3.fromRGB(141, 141, 150), Size = UDim2.new(0, 16, 0, 16),
				AnchorPoint = Vector2.new(1, 0.5), Image = "rbxassetid://3926305904", ImageRectOffset = Vector2.new(764, 764),
				ImageRectSize = Vector2.new(36, 36), BackgroundTransparency = 1, Position = UDim2.new(1, -10, 0.5, 0), ZIndex = 5,
				AutoButtonColor = false,
			})
			tween7 = index5:Create("Frame", {
				Parent = tween.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, -8, 0, 0), Position = UDim2.new(0, 4, 0, 30),
				ZIndex = 3, ClipsDescendants = true, BackgroundColor3 = Color3.fromRGB(22, 21, 24),
			})
			tween7:AddToTheme({ BackgroundColor3 = "Background" })
			index5:Create("UICorner", { Parent = tween7.Instance, CornerRadius = UDim.new(0, 4) })
			local tween9 = index5:Create("Frame", {
				Parent = tween7.Instance, Size = UDim2.new(0, 2, 1, -8), Position = UDim2.new(0, 4, 0, 4), ZIndex = 4,
			})
			index5:Create("UICorner", { Parent = tween9.Instance, CornerRadius = UDim.new(1, 0) })
			local v78 = index5
			local create = v78.Create
			local v79 = 1
			create(v78, "UIGradient", {
				Parent = tween9.Instance, Name = "\0", Rotation = 90,
				Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(v79, Color3.fromRGB(143, 143, 143)) }),
			}):AddToTheme({ Color = function()
				local v80 = 1
				local accentGradient = index3.Theme.AccentGradient
				return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v80, accentGradient) })
			end })
			tween8 = index5:Create("TextLabel", {
				Parent = tween7.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(200, 200, 200), TextTransparency = 0.2,
				Text = arg5, BackgroundTransparency = 1, Position = UDim2.new(0, 14, 0, 6), Size = UDim2.new(1, -20, 1, -12), ZIndex = 4,
				TextWrapped = true, TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextSize = 12,
			})
			tween8:AddToTheme({ TextColor3 = "Text" })
			tween6:OnHover(function()
				tween6:Tween(nil, { ImageColor3 = index3.Theme.Accent })
			end)
			tween6:OnHoverLeave(function()
				tween6:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
			end)
		end
		local dragging
		dragging = {
			Container = tween, Button = tween2, Name = arg4, Description = arg5, HasDescription = b15, DragHandle = tween3,
			RankLabel = tween4, Text = tween5, InfoButton = tween6, DescriptionFrame = tween7, DescriptionText = tween8,
			IsDescriptionOpen = false, TargetHeight = 28,
			ToggleDescription = function()
				if not b15 then
					return
				end
				dragging.IsDescriptionOpen = not dragging.IsDescriptionOpen
				if dragging.IsDescriptionOpen then
					tween8.Instance.Size = UDim2.new(0, tween.Instance.AbsoluteSize.X - 28, 0, 9999)
					local n32 = tween8.Instance.TextBounds.Y + 12
					tween8.Instance.Size = UDim2.new(1, -24, 1, -12)
					local targetHeight = 28 + n32 + 6
					dragging.TargetHeight = targetHeight
					tween:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, targetHeight) })
					tween7:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, n32) })
					tween6:Tween(nil, { ImageColor3 = index3.Theme.Accent, Rotation = 180 })
				else
					dragging.TargetHeight = 28
					tween:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 0, 28) })
					tween7:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, -8, 0, 0) })
					tween6:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150), Rotation = 0 })
				end
				t19:UpdatePositions()
			end,
		}
		if tween6 then
			tween6:Connect("MouseButton1Down", function()
				dragging:ToggleDescription()
			end)
		end
		local connection = nil
		tween2:Connect("InputBegan", function(arg6)
			if t19.IsCollapsed then
				return
			end
			if tween6 then
				local mouseLocation = UserInputService:GetMouseLocation()
				local absolutePosition = tween6.Instance.AbsolutePosition
				local absoluteSize = tween6.Instance.AbsoluteSize
				if mouseLocation.X >= absolutePosition.X and mouseLocation.X <= absolutePosition.X + absoluteSize.X and mouseLocation.Y >= absolutePosition.Y and mouseLocation.Y <= absolutePosition.Y + absoluteSize.Y then
					return
				end
			end
			if arg6.UserInputType == Enum.UserInputType.MouseButton1 or arg6.UserInputType == Enum.UserInputType.Touch then
				t19.Dragging = dragging
				local y = tween.Instance.AbsolutePosition.Y
				t19.DragOffset = UserInputService:GetMouseLocation().Y - y
				tween.Instance.ZIndex = 10
				for _, v78 in tween.Instance:GetDescendants() do
					if v78:IsA("GuiObject") then
						v78.ZIndex = v78.ZIndex + 7
					end
				end
				tween3.Instance.ImageColor3 = index3.Theme.Accent
				tween2:Tween(nil, { BackgroundTransparency = 0.2 })
				if connection then
					return
				end
				connection = arg6.Changed:Connect(function()
					if arg6.UserInputState == Enum.UserInputState.End then
						t19.Dragging = nil
						tween.Instance.ZIndex = 3
						for _, v78 in tween.Instance:GetDescendants() do
							if v78:IsA("GuiObject") then
								v78.ZIndex = v78.ZIndex - 7
							end
						end
						tween3.Instance.ImageColor3 = Color3.fromRGB(141, 141, 150)
						tween2:Tween(nil, { BackgroundTransparency = 0 })
						t19:UpdatePositions()
						t19:RefreshHighlights()
						index3.Flags[t19.Flag] = t19.Value
						if t19.Callback then
							index3:SafeCall(t19.Callback, t19.Value)
						end
						connection:Disconnect()
						connection = nil
					end
				end)
			end
		end)
		t19.Options[arg4] = dragging
		table.insert(t19.Value, arg4)
		index3.Flags[t19.Flag] = t19.Value
		t19:UpdatePositions()
		return dragging
	end
	t19.Remove = function(arg3, arg4)
		if t19.Options[arg4] then
			t19.Options[arg4].Container:Clean()
			t19.Options[arg4] = nil
			local v78 = table.find(t19.Value, arg4)
			if v78 then
				table.remove(t19.Value, v78)
			end
			t19:UpdatePositions()
		end
	end
	t19.Refresh = function(arg3, arg4)
		for _, v78 in t19.Options do
			t19:Remove(v78.Name)
		end
		for _, v78 in arg4 do
			t19:Add(v78)
		end
	end
	t20.Header:Connect("MouseButton1Down", function()
		t19:Toggle()
	end)
	t20.Header:OnHover(function()
		t20.ArrowIcon:Tween(nil, { ImageColor3 = index3.Theme.Accent })
	end)
	t20.Header:OnHoverLeave(function()
		t20.ArrowIcon:Tween(nil, { ImageColor3 = Color3.fromRGB(141, 141, 150) })
	end)
	if t19.Searchable and t20.Search then
		index3:Connect(t20.Search.Instance:GetPropertyChangedSignal("Text"), function()
			t19.SearchQuery = t20.Search.Instance.Text
			t19:RefreshHighlights()
			t19:ScrollToFirstMatch()
		end)
	end
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if arg3.UserInputType ~= Enum.UserInputType.MouseMovement and arg3.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		if not t19.Dragging then
			return
		end
		local dragging = t19.Dragging
		local y = t20.Holder.Instance.AbsolutePosition.Y
		local y2 = UserInputService:GetMouseLocation().Y
		local uiScale = t19.Window and t19.Window.Items and t19.Window.Items.UIScale
		local n32 = dragging.Container.Instance.Position.Y.Offset + (y2 - t19.DragOffset - dragging.Container.Instance.AbsolutePosition.Y) / (uiScale and uiScale.Instance.Scale or 1)
		dragging.Container.Instance.Position = UDim2.new(0, 0, 0, n32)
		local y3 = t20.Holder.Instance.AbsoluteSize.Y
		local n33 = y2 - y
		if n33 < 20 then
			if not b3 then
				return
			end
			t20.Holder.Instance.CanvasPosition = Vector2.new(0, math.max(0, t20.Holder.Instance.CanvasPosition.Y - 8))
		elseif y3 - 20 < n33 then
			t20.Holder.Instance.CanvasPosition = Vector2.new(0, math.min(t20.Holder.Instance.AbsoluteCanvasSize.Y - y3, t20.Holder.Instance.CanvasPosition.Y + 8))
		end
		local v78 = 1
		local n34 = 0
		for k_, v79 in t19.Value do
			local v80 = t19.Options[v79]
			if not v80 then
				continue
			else
				local offset = v80.Container.Instance.Size.Y.Offset
				if n34 < n32 + 14 then
					n34 = n34 + offset + 4
					v78 = k_
					continue
				end
			end
			break
		end
		local v79 = math.clamp(v78, 1, #t19.Value)
		local v80 = table.find(t19.Value, dragging.Name)
		if v80 and v80 ~= v79 then
			table.remove(t19.Value, v80)
			table.insert(t19.Value, v79, dragging.Name)
			t19:UpdatePositions(true)
		end
	end)
	for _, v78 in t19.Items do
		t19:Add(v78)
	end
	if t19.Default then
		t19:Set(t19.Default)
	end
	if t19.StartCollapsed then
		t19:SetCollapsed(true)
	end
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.Sections.MapPicker = function(arg, arg2)
	local t18 = arg2 or {}
	local colors = t18.Colors or t18.colors
	local v78
	if colors then
		v78 = colors
	else
		local t19 = {}
		local v79 = Color3.fromRGB(255, 70, 70)
		local v80 = Color3.fromRGB(90, 225, 100)
		local v81 = Color3.fromRGB(70, 230, 230)
		local v82 = Color3.fromRGB(80, 145, 255)
		local v83 = Color3.fromRGB(245, 225, 70)
		local v84 = Color3.fromRGB(200, 95, 255)
		local v85 = Color3.fromRGB(255, 150, 60)
		local v86 = 255
		t19[1] = v79
		t19[2] = v80
		t19[3] = v81
		t19[4] = v82
		t19[5] = v83
		t19[6] = v84
		t19[7] = v85
		local values = table.pack(Color3.fromRGB(v86, 120, 200))
		table.move(values, 1, values.n, 8, t19)
		v78 = t19
	end
	local function f27(arg3)
		if typeof(arg3) == "Vector2" then
			return arg3
		end
		if typeof(arg3) == "Vector3" then
			return Vector2.new(arg3.X, arg3.Z)
		end
		if type(arg3) == "table" then
			return Vector2.new(tonumber(arg3.X or arg3.x or arg3[1]) or 0, tonumber(arg3.Z or arg3.z or arg3[2]) or 0)
		end
		return Vector2.new(0, 0)
	end
	local function f28(arg3)
		return math.floor(arg3 + 0.5)
	end
	local t19 = { Window = arg.Window, Page = arg.Page, Section = arg, Name = t18.Name or t18.name or "Tower Placement" }
	t19.Flag = t18.Flag or t18.flag or index3:NextFlag()
	t19.ButtonText = t18.ButtonText or t18.buttontext or "Set"
	t19.Title = t18.Title or t18.title or "Hologram"
	t19.SlotCount = t18.Slots or t18.slots or 6
	t19.MapImage = t18.MapImage or t18.mapimage or ""
	t19.MapAspect = t18.MapAspect or t18.mapaspect or 1
	t19.Height = t18.Height or t18.height or 0
	t19.Live = t18.Live or t18.live or false
	t19.Callback = t18.Callback or t18.callback or function() end
	t19.MaxZoom = t18.MaxZoom or t18.maxzoom or 6
	t19.AreaRadius = t18.AreaRadius or t18.arearadius or 5
	t19.WorldPreview = t18.WorldPreview ~= false
	t19.RaycastGround = t18.RaycastGround ~= false
	t19.AreaBeam = t18.AreaBeam ~= false
	t19.KeepWorldPreview = t18.KeepWorldPreview or t18.keepworldpreview or false
	t19.Corners = {}
	t19.Value = {}
	t19.Markers = {}
	t19.Rows = {}
	t19.Selected = 1
	t19.Dragging = nil
	t19.IsOpen = false
	t19.Calibrating = false
	t19.Zoom = 1
	t19.PanU = 0
	t19.PanV = 0
	t19.Panning = nil
	t19.PinchActive = false
	t19.PinchStart = nil
	local t20 = { "TopLeft", "TopRight", "BottomLeft", "BottomRight" }
	local corners = t18.Corners or t18.corners or {
		TopLeft = Vector2.new(-300, 0), TopRight = Vector2.new(0, 0), BottomLeft = Vector2.new(-300, 300),
		BottomRight = Vector2.new(0, 300),
	}
	for _, v79 in t20 do
		t19.Corners[v79] = f27(corners[v79] or corners[string.lower(v79)])
	end
	for i = 1, t19.SlotCount do
		t19.Value[i] = { X = 0, Z = 0, Locked = false }
	end
	local function f29(arg3, arg4, arg5)
		local n = arg3.TopLeft + (arg3.TopRight - arg3.TopLeft) * arg4
		return n + (arg3.BottomLeft + (arg3.BottomRight - arg3.BottomLeft) * arg4 - n) * arg5
	end
	t19.UVToWorld = function(arg3, arg4, arg5)
		local v79 = f29(t19.Corners, arg4, arg5)
		return v79.X, v79.Y
	end
	t19.WorldToUV = function(arg3, arg4, arg5)
		local corners2 = t19.Corners
		local v79 = Vector2.new(arg4, arg5)
		local n = 0.5
		local n32 = 0.5
		for i = 1, 16 do
			local n33 = f29(corners2, n, n32) - v79
			if not (n33.Magnitude < 0.0001) then
				local n34 = (corners2.TopRight - corners2.TopLeft) * (1 - n32) + (corners2.BottomRight - corners2.BottomLeft) * n32
				local n35 = (corners2.BottomLeft - corners2.TopLeft) * (1 - n) + (corners2.BottomRight - corners2.TopRight) * n
				local n36 = n34.X * n35.Y - n35.X * n34.Y
				if not (math.abs(n36) < 1e-09) then
					n -= (n33.X * n35.Y - n35.X * n33.Y) / n36
					n32 -= (n34.X * n33.Y - n33.X * n34.Y) / n36
					continue
				end
			end
			break
		end
		local v80 = 1
		return math.clamp(n, 0, 1), math.clamp(n32, 0, v80)
	end
	t19.SetCorners = function(arg3, arg4)
		if type(arg4) ~= "table" then
			return
		end
		for _, v79 in t20 do
			if arg4[v79] then
				t19.Corners[v79] = f27(arg4[v79])
			end
		end
		t19:RefreshFromWorld()
	end
	t19.CalibrateFromTwoPoints = function(arg3, arg4, arg5, arg6, arg7, arg8, arg9)
		local v79 = f27(arg6)
		local v80 = f27(arg9)
		local n = arg7 - arg4
		local n32 = arg8 - arg5
		if math.abs(n) < 0.02 or math.abs(n32) < 0.02 then
			return false, "จุด A กับ B ใกล้กันเกินไป (ต้องห่างกันทั้งแนวนอนและแนวตั้ง)"
		end
		local n33 = (v80.X - v79.X) / n
		local n34 = (v80.Y - v79.Y) / n32
		local n35 = v79.X - n33 * arg4
		local n36 = v79.Y - n34 * arg5
		t19:SetCorners({
			TopLeft = Vector2.new(n35, n36), TopRight = Vector2.new(n35 + n33, n36), BottomLeft = Vector2.new(n35, n36 + n34),
			BottomRight = Vector2.new(n35 + n33, n36 + n34),
		})
		return true
	end
	local t21 = {
		Block = index5:Create("Frame", {
			Parent = t19.Section.Items.Content.Instance, BackgroundTransparency = 0, Size = UDim2.new(1, 0, 0, 34), ZIndex = 2,
			BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		}),
	}
	t21.Block:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t21.Block.Instance, CornerRadius = UDim.new(0, 5) })
	t21.AccentBar = index5:Create("Frame", {
		Parent = t21.Block.Instance, Size = UDim2.new(0, 2, 1, -12), Position = UDim2.new(0, 4, 0.5, 0), AnchorPoint = Vector2.new(0, 0.5),
		ZIndex = 3, BackgroundTransparency = 0,
	})
	index5:Create("UICorner", { Parent = t21.AccentBar.Instance, CornerRadius = UDim.new(1, 0) })
	local v79 = index5
	local create = v79.Create
	local v80 = 1
	create(v79, "UIGradient", {
		Parent = t21.AccentBar.Instance, Name = "\0", Rotation = 90,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(v80, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t21.Text = index5:Create("TextLabel", {
		Parent = t21.Block.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.3,
		Text = t19.Name, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 15), AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 14, 0.5, 0), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 3,
		TextSize = 14,
	})
	t21.Text:AddToTheme({ TextColor3 = "Text" })
	t21.OpenButton = index5:Create("TextButton", {
		Parent = t21.Block.Instance, FontFace = index3.Font, Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5),
		Position = UDim2.new(1, -6, 0.5, 0), Size = UDim2.new(0, 74, 0, 24), ZIndex = 3, TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(38, 36, 42),
	})
	t21.OpenButton:AddToTheme({ BackgroundColor3 = "Outline" })
	index5:Create("UICorner", { Parent = t21.OpenButton.Instance, CornerRadius = UDim.new(0, 4) })
	t21.OpenAccent = index5:Create("Frame", {
		Parent = t21.OpenButton.Instance, Size = UDim2.new(0, 0, 0, 0), AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0), BackgroundTransparency = 1, ZIndex = 3,
	})
	index5:Create("UICorner", { Parent = t21.OpenAccent.Instance, CornerRadius = UDim.new(0, 4) })
	local v81 = index5
	local create2 = v81.Create
	local v82 = 1
	create2(v81, "UIGradient", {
		Parent = t21.OpenAccent.Instance, Name = "\0", Rotation = -115,
		Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(v82, Color3.fromRGB(143, 143, 143)) }),
	}):AddToTheme({ Color = function()
		local accentGradient = index3.Theme.AccentGradient
		return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
	end })
	t21.OpenText = index5:Create("TextLabel", {
		Parent = t21.OpenButton.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.15,
		Text = t19.ButtonText, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 4, TextSize = 13,
	})
	t21.OpenText:AddToTheme({ TextColor3 = "Text" })
	t21.OpenButton:OnHover(function()
		t21.OpenAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
		t21.OpenText:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0) })
	end)
	t21.OpenButton:OnHoverLeave(function()
		t21.OpenAccent:Tween(TweenInfo.new(index3.Tween.Time + 0.15, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
		t21.OpenText:Tween(nil, { TextColor3 = index3.Theme.Text })
	end)
	local t22 = {
		Overlay = index5:Create("TextButton", {
			Parent = index3.UnusedHolder.Instance, Text = "", AutoButtonColor = false, Active = true, Visible = false,
			Position = UDim2.new(0, -203, 0, 0), Size = UDim2.new(1, 203, 1, 0), BackgroundTransparency = 1, ZIndex = 60,
			BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		}),
	}
	t22.Panel = index5:Create("Frame", {
		Parent = t22.Overlay.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -20, 1, -24), ZIndex = 61, BackgroundColor3 = Color3.fromRGB(12, 12, 14),
	})
	t22.Panel:AddToTheme({ BackgroundColor3 = "Background" })
	index5:Create("UICorner", { Parent = t22.Panel.Instance, CornerRadius = UDim.new(0, 8) })
	index5:Create("UIStroke", {
		Parent = t22.Panel.Instance, Color = Color3.fromRGB(35, 33, 38), Thickness = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	}):AddToTheme({ Color = "Outline" })
	t22.Title = index5:Create("TextLabel", {
		Parent = t22.Panel.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = t19.Title,
		AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 18), Position = UDim2.new(0, 14, 0, 12), BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 62, TextSize = 17,
	})
	t22.Title:AddToTheme({ TextColor3 = "Text" })
	t22.SubTitle = index5:Create("TextLabel", {
		Parent = t22.Panel.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.55,
		Text = "ลากหมุดไปยังจุดที่ต้องการวางยูนิต", AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 14),
		Position = UDim2.new(0, 15, 0, 31), BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 62,
		TextSize = 13,
	})
	t22.SubTitle:AddToTheme({ TextColor3 = "Text" })
	t22.Close = index5:Create("TextButton", {
		Parent = t22.Panel.Instance, FontFace = index3.Font, Text = "✕", TextColor3 = Color3.fromRGB(240, 240, 240),
		TextTransparency = 0.25, AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, 10),
		Size = UDim2.new(0, 26, 0, 26), ZIndex = 62, TextSize = 16, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	t22.Close:AddToTheme({ BackgroundColor3 = "Element", TextColor3 = "Text" })
	index5:Create("UICorner", { Parent = t22.Close.Instance, CornerRadius = UDim.new(0, 6) })
	t22.SlotList = index5:Create("ScrollingFrame", {
		Parent = t22.Panel.Instance, Active = true, AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 2,
		Position = UDim2.new(0, 10, 0, 52), Size = UDim2.new(0, 206, 1, -100), BackgroundTransparency = 1, ZIndex = 62,
		CanvasSize = UDim2.new(0, 0, 0, 0),
	})
	t22.SlotList:AddToTheme({ ScrollBarImageColor3 = "Accent" })
	index5:Create("UIListLayout", {
		Parent = t22.SlotList.Instance, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	index5:Create("UIPadding", { Parent = t22.SlotList.Instance, PaddingRight = UDim.new(0, 6) })
	t22.MapFrame = index5:Create("Frame", {
		Parent = t22.Panel.Instance, Position = UDim2.new(0, 200, 0, 52), Size = UDim2.new(1, -234, 1, -100), BackgroundTransparency = 0.5,
		ZIndex = 62, BackgroundColor3 = Color3.fromRGB(8, 8, 10),
	})
	t22.MapFrame:AddToTheme({ BackgroundColor3 = "Background" })
	index5:Create("UICorner", { Parent = t22.MapFrame.Instance, CornerRadius = UDim.new(0, 6) })
	t22.Viewport = index5:Create("Frame", {
		Parent = t22.MapFrame.Instance, Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1,
		ClipsDescendants = true, ZIndex = 62,
	})
	index5:Create("UICorner", { Parent = t22.Viewport.Instance, CornerRadius = UDim.new(0, 6) })
	t22.MapCanvas = index5:Create("Frame", {
		Parent = t22.Viewport.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 63,
	})
	t22.Aspect = index5:Create("UIAspectRatioConstraint", {
		Parent = t22.MapCanvas.Instance, AspectRatio = t19.MapAspect, AspectType = Enum.AspectType.FitWithinMaxSize,
		DominantAxis = Enum.DominantAxis.Width,
	})
	t22.MapImage = index5:Create("ImageButton", {
		Parent = t22.MapCanvas.Instance, AutoButtonColor = false, Image = t19.MapImage, ScaleType = Enum.ScaleType.Stretch,
		Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0.85, ZIndex = 63, BackgroundColor3 = Color3.fromRGB(24, 24, 24),
	})
	index5:Create("UICorner", { Parent = t22.MapImage.Instance, CornerRadius = UDim.new(0, 6) })
	t22.ZoomBar = index5:Create("Frame", {
		Parent = t22.MapFrame.Instance, AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -10, 1, -10),
		Size = UDim2.new(0, 30, 0, 122), BackgroundTransparency = 1, ZIndex = 72,
	})
	index5:Create("UIListLayout", {
		Parent = t22.ZoomBar.Instance, Padding = UDim.new(0, 4), HorizontalAlignment = Enum.HorizontalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
	})
	t22.ZoomLabel = index5:Create("TextLabel", {
		Parent = t22.ZoomBar.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.25,
		Text = "100%", LayoutOrder = 0, Size = UDim2.new(1, 0, 0, 16), BackgroundTransparency = 1, TextStrokeTransparency = 0.6,
		TextStrokeColor3 = Color3.fromRGB(0, 0, 0), ZIndex = 73, TextSize = 12,
	})
	t22.ZoomLabel:AddToTheme({ TextColor3 = "Text" })
	local function f30(arg3, arg4, arg5)
		local tween = index5:Create("TextButton", {
			Parent = t22.ZoomBar.Instance, FontFace = index3.Font, Text = "", AutoButtonColor = false, LayoutOrder = arg4,
			Size = UDim2.new(0, 26, 0, 30), BackgroundTransparency = 0.15, ZIndex = 73, TextSize = 14,
			BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		})
		tween:AddToTheme({ BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = tween.Instance, CornerRadius = UDim.new(0, 6) })
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, ZIndex = 73,
		})
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(0, 6) })
		index5:Create("UIGradient", {
			Parent = tween2.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local v83 = 1
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(v83, accentGradient) })
		end })
		local tween3 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.15,
			Text = arg3, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 74, TextSize = arg5 or 18,
		})
		tween3:AddToTheme({ TextColor3 = "Text" })
		tween:OnHover(function()
			tween2:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
			tween3:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0), TextTransparency = 0 })
		end)
		tween:OnHoverLeave(function()
			tween2:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
			tween3:Tween(nil, { TextColor3 = index3.Theme.Text, TextTransparency = 0.15 })
		end)
		return tween
	end
	t22.ZoomIn = f30("+", 1, 24)
	t22.ZoomOut = f30("-", 2, 24)
	t22.ZoomReset = f30("1:1", 3, 12)
	t22.Footer = index5:Create("Frame", {
		Parent = t22.Panel.Instance, AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 10, 1, -10), Size = UDim2.new(1, -20, 0, 32),
		BackgroundTransparency = 0, ZIndex = 62, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
	})
	t22.Footer:AddToTheme({ BackgroundColor3 = "Element" })
	index5:Create("UICorner", { Parent = t22.Footer.Instance, CornerRadius = UDim.new(0, 6) })
	t22.Readout = index5:Create("TextLabel", {
		Parent = t22.Footer.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.15,
		RichText = true, Text = "", Size = UDim2.new(1, -400, 1, 0), Position = UDim2.new(0, 12, 0, 0), BackgroundTransparency = 1,
		TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 63, TextSize = 13,
	})
	t22.Readout:AddToTheme({ TextColor3 = "Text" })
	t22.Actions = index5:Create("Frame", {
		Parent = t22.Footer.Instance, AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, -8, 0.5, 0),
		Size = UDim2.new(0, 380, 0, 22), BackgroundTransparency = 1, ZIndex = 63,
	})
	index5:Create("UIListLayout", {
		Parent = t22.Actions.Instance, FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right,
		VerticalAlignment = Enum.VerticalAlignment.Center, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder,
	})
	local function f31(arg3)
		local n = math.min(arg3.X, arg3.Y * t19.MapAspect)
		return Vector2.new(n, n / t19.MapAspect)
	end
	local function f32()
		local instance = t22.Viewport.Instance
		local absoluteSize = instance.AbsoluteSize
		if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
			return nil
		end
		local v83 = f31(absoluteSize)
		local n = v83.X * t19.Zoom
		local n32 = v83.Y * t19.Zoom
		return instance.AbsolutePosition.X + absoluteSize.X * (0.5 + t19.PanU) - n / 2, instance.AbsolutePosition.Y + absoluteSize.Y * (0.5 + t19.PanV) - n32 / 2, n, n32
	end
	t19.ApplyView = function(arg3, arg4)
		local absoluteSize = t22.Viewport.Instance.AbsoluteSize
		if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
			return
		end
		local v83 = f31(absoluteSize)
		local n = math.max(0, v83.X * t19.Zoom / 2 * absoluteSize.X - 0.5)
		local n32 = math.max(0, v83.Y * t19.Zoom / 2 * absoluteSize.Y - 0.5)
		t19.PanU = math.clamp(t19.PanU, -n, n)
		t19.PanV = math.clamp(t19.PanV, -n32, n32)
		local v84 = UDim2.new(t19.Zoom, 0, t19.Zoom, 0)
		local v85 = UDim2.new(0.5 + t19.PanU, 0, 0.5 + t19.PanV, 0)
		if arg4 then
			t22.MapCanvas.Instance.Size = v84
			t22.MapCanvas.Instance.Position = v85
		else
			t22.MapCanvas:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = v84, Position = v85 })
		end
		t22.ZoomLabel.Instance.Text = string.format("%d%%", f28(t19.Zoom * 100))
	end
	t19.ZoomAt = function(arg3, arg4, arg5, arg6)
		local v83 = math.clamp(arg4, 1, t19.MaxZoom)
		if math.abs(v83 - t19.Zoom) < 0.0005 then
			return
		end
		local instance = t22.Viewport.Instance
		local absoluteSize = instance.AbsoluteSize
		if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
			return
		end
		local v84, v85, v86, v87 = f32()
		if not v84 or v86 <= 0 or v87 <= 0 then
			return
		end
		local n = (arg5.X - v84) / v86
		local n32 = (arg5.Y - v85) / v87
		local n33 = v83 / t19.Zoom
		local n34 = v86 * n33
		local n35 = v87 * n33
		local n36 = arg5.X - n * n34 + n34 / 2
		local n37 = arg5.Y - n32 * n35 + n35 / 2
		t19.Zoom = v83
		t19.PanU = (n36 - instance.AbsolutePosition.X) / absoluteSize.X - 0.5
		t19.PanV = (n37 - instance.AbsolutePosition.Y) / absoluteSize.Y - 0.5
		t19:ApplyView(arg6)
	end
	t19.ZoomBy = function(arg3, arg4)
		local instance = t22.Viewport.Instance
		local v83 = Vector2.new(instance.AbsolutePosition.X + instance.AbsoluteSize.X / 2, instance.AbsolutePosition.Y + instance.AbsoluteSize.Y / 2)
		t19:ZoomAt(t19.Zoom * arg4, v83)
	end
	t19.ResetView = function()
		t19.Zoom = 1
		t19.PanU = 0
		t19.PanV = 0
		t19:ApplyView()
	end
	local Folder = nil
	local t23 = {}
	local raycastParams = RaycastParams.new()
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.IgnoreWater = true
	local function f33()
		if Folder then
			return Folder
		end
		Folder = Instance.new("Folder")
		Folder.Name = "\0"
		Folder.Parent = currentCamera
		return Folder
	end
	t19.GroundY = function(arg3, arg4, arg5)
		if not t19.RaycastGround then
			return t19.Height
		end
		local filterDescendantsInstances = {}
		if Folder then
			table.insert(filterDescendantsInstances, Folder)
		end
		if localPlayer.Character then
			table.insert(filterDescendantsInstances, localPlayer.Character)
		end
		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		local hit = workspace:Raycast(Vector3.new(arg4, t19.Height + 25, arg5), Vector3.new(0, -1500, 0), raycastParams)
		if hit then
			return hit.Position.Y
		end
		return t19.Height
	end
	local function f34(arg3, backgroundColor3)
		local v83 = f33()
		local n = t19.AreaRadius * 2
		local Part = Instance.new("Part")
		Part.Name = "\0"
		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.CastShadow = false
		Part.Locked = true
		Part.Transparency = 1
		Part.Size = Vector3.new(n, 0.2, n)
		Part.Parent = v83
		local SurfaceGui = Instance.new("SurfaceGui")
		SurfaceGui.Name = "\0"
		SurfaceGui.Face = Enum.NormalId.Top
		SurfaceGui.AlwaysOnTop = true
		SurfaceGui.LightInfluence = 0
		SurfaceGui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
		SurfaceGui.PixelsPerStud = 32
		SurfaceGui.Adornee = Part
		SurfaceGui.Parent = Part
		local Frame = Instance.new("Frame")
		Frame.Name = "\0"
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.BackgroundColor3 = backgroundColor3
		Frame.BackgroundTransparency = 0.86
		Frame.BorderSizePixel = 0
		Frame.Parent = SurfaceGui
		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(1, 0)
		UICorner.Parent = Frame
		local UIStroke = Instance.new("UIStroke")
		UIStroke.Color = backgroundColor3
		UIStroke.Thickness = 6
		UIStroke.Transparency = 0.05
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke.Parent = Frame
		local Frame2 = Instance.new("Frame")
		Frame2.Name = "\0"
		Frame2.AnchorPoint = Vector2.new(0.5, 0.5)
		Frame2.Position = UDim2.new(0.5, 0, 0.5, 0)
		Frame2.Size = UDim2.new(0.62, 0, 0.62, 0)
		Frame2.BackgroundTransparency = 1
		Frame2.BorderSizePixel = 0
		Frame2.Parent = Frame
		local UICorner2 = Instance.new("UICorner")
		UICorner2.CornerRadius = UDim.new(1, 0)
		UICorner2.Parent = Frame2
		local UIStroke2 = Instance.new("UIStroke")
		UIStroke2.Color = backgroundColor3
		UIStroke2.Thickness = 3
		UIStroke2.Transparency = 0.5
		UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		UIStroke2.Parent = Frame2
		local t24 = {}
		local t25 = {}
		local t26 = {
			Anchor = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.new(0.035, 0, 0.13, 0),
		}
		local t27 = {
			Anchor = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.new(0.035, 0, 0.13, 0),
		}
		local t28 = {
			Anchor = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(0.13, 0, 0.035, 0),
		}
		local t29 = { Anchor = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0.13, 0, 0.035, 0) }
		t25[1] = t26
		t25[2] = t27
		t25[3] = t28
		t25[4] = t29
		for _, v84 in t25 do
			local Frame3 = Instance.new("Frame")
			Frame3.Name = "\0"
			Frame3.AnchorPoint = v84.Anchor
			Frame3.Position = v84.Position
			Frame3.Size = v84.Size
			Frame3.BackgroundColor3 = backgroundColor3
			Frame3.BackgroundTransparency = 0.1
			Frame3.BorderSizePixel = 0
			Frame3.Parent = Frame
			local UICorner3 = Instance.new("UICorner")
			UICorner3.CornerRadius = UDim.new(1, 0)
			UICorner3.Parent = Frame3
			table.insert(t24, Frame3)
		end
		local TextLabel = Instance.new("TextLabel")
		TextLabel.Name = "\0"
		TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
		TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextLabel.Size = UDim2.new(0.45, 0, 0.45, 0)
		TextLabel.BackgroundTransparency = 1
		TextLabel.BorderSizePixel = 0
		TextLabel.Text = tostring(arg3)
		TextLabel.TextColor3 = backgroundColor3
		TextLabel.TextScaled = true
		TextLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.TextStrokeTransparency = 0.35
		TextLabel.FontFace = index3.Font
		TextLabel.Parent = Frame
		local Part2 = nil
		if t19.AreaBeam then
			Part2 = Instance.new("Part")
			Part2.Name = "\0"
			Part2.Anchored = true
			Part2.CanCollide = false
			Part2.CanQuery = false
			Part2.CanTouch = false
			Part2.CastShadow = false
			Part2.Locked = true
			Part2.Material = Enum.Material.Neon
			Part2.Color = backgroundColor3
			Part2.Transparency = 0.78
			Part2.Size = Vector3.new(0.6, 100, 0.6)
			Part2.Parent = v83
			Instance.new("CylinderMesh").Parent = Part2
		end
		return {
			Part = Part, Ring = Frame, RingStroke = UIStroke, InnerStroke = UIStroke2, Ticks = t24, Number = TextLabel, Beam = Part2,
			Color = backgroundColor3,
		}
	end
	t19.RefreshWorldRing = function(arg3, arg4)
		local v83 = t23[arg4]
		local v84 = t19.Value[arg4]
		if not v83 or not v84 then
			return
		end
		local v85 = t19:GroundY(v84.X, v84.Z)
		v83.Part.CFrame = CFrame.new(v84.X, v85 + 0.12, v84.Z)
		if v83.Beam then
			v83.Beam.CFrame = CFrame.new(v84.X, v85 + v83.Beam.Size.Y / 2, v84.Z)
		end
		local locked = v84.Locked
		v83.RingStroke.Transparency = locked and 0.55 or 0.05
		v83.InnerStroke.Transparency = locked and 0.8 or 0.5
		v83.Ring.BackgroundTransparency = locked and 0.94 or 0.86
		v83.Number.TextTransparency = locked and 0.5 or 0
		if v83.Beam then
			v83.Beam.Transparency = locked and 0.92 or 0.78
		end
		for _, v86 in v83.Ticks do
			v86.BackgroundTransparency = locked and 0.6 or 0.1
		end
	end
	t19.ShouldShowWorld = function()
		return t19.WorldPreview and (t19.IsOpen or t19.KeepWorldPreview)
	end
	t19.ApplyWorldVisibility = function()
		if t19:ShouldShowWorld() then
			f33().Parent = currentCamera
			for i = 1, t19.SlotCount do
				t19:RefreshWorldRing(i)
			end
		elseif Folder then
			Folder.Parent = nil
		end
	end
	t19.SetWorldPreview = function(arg3, arg4)
		t19.WorldPreview = arg4 and true or false
		t19:ApplyWorldVisibility()
	end
	t19.SetAreaRadius = function(arg3, arg4)
		t19.AreaRadius = math.max(0.5, arg4 or 5)
		local n = t19.AreaRadius * 2
		for i = 1, t19.SlotCount do
			local v83 = t23[i]
			if v83 then
				v83.Part.Size = Vector3.new(n, 0.2, n)
				t19:RefreshWorldRing(i)
			end
		end
	end
	index3:Connect(index3.Holder.Instance.Destroying, function()
		if Folder then
			Folder:Destroy()
			Folder = nil
		end
	end)
	local function f35(arg3, arg4, arg5)
		local tween = index5:Create("TextButton", {
			Parent = t22.Actions.Instance, FontFace = index3.Font, Text = "", AutoButtonColor = false, LayoutOrder = arg5,
			Size = UDim2.new(0, arg4, 1, 0), ZIndex = 63, TextSize = 13, BackgroundColor3 = Color3.fromRGB(38, 36, 42),
		})
		tween:AddToTheme({ BackgroundColor3 = "Outline" })
		index5:Create("UICorner", { Parent = tween.Instance, CornerRadius = UDim.new(0, 4) })
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1, ZIndex = 63,
		})
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(0, 4) })
		index5:Create("UIGradient", {
			Parent = tween2.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(143, 143, 143)) }),
		}):AddToTheme({ Color = function()
			local accentGradient = index3.Theme.AccentGradient
			return ColorSequence.new({ ColorSequenceKeypoint.new(0, index3.Theme.Accent), ColorSequenceKeypoint.new(1, accentGradient) })
		end })
		local tween3 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.2,
			Text = arg3, Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 64, TextSize = 13,
		})
		tween3:AddToTheme({ TextColor3 = "Text" })
		tween:OnHover(function()
			tween2:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 0 })
			tween3:Tween(nil, { TextColor3 = Color3.fromRGB(0, 0, 0), TextTransparency = 0 })
		end)
		tween:OnHoverLeave(function()
			tween2:Tween(TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1 })
			tween3:Tween(nil, { TextColor3 = index3.Theme.Text, TextTransparency = 0.2 })
		end)
		return tween, tween3
	end
	local function f36(arg3, arg4)
		local tween = index5:Create("TextButton", {
			Parent = t22.MapCanvas.Instance, Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 38, 0, 38), BackgroundTransparency = 1, ZIndex = 66,
		})
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, 12, 1, 12), BackgroundTransparency = 0.9, ZIndex = 64, BackgroundColor3 = arg4,
		})
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(1, 0) })
		local tween3 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, -16, 1, -16), BackgroundTransparency = 1, ZIndex = 65,
		})
		index5:Create("UICorner", { Parent = tween3.Instance, CornerRadius = UDim.new(1, 0) })
		local tween4 = index5:Create("UIStroke", {
			Parent = tween3.Instance, Color = arg4, Thickness = 2, Transparency = 1, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		})
		local t24 = {}
		local t25 = {}
		local t26 = {
			Anchor = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.new(0, 2, 0, 5),
		}
		local t27 = { Anchor = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, 0), Size = UDim2.new(0, 2, 0, 5) }
		local t28 = { Anchor = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0.5, 0), Size = UDim2.new(0, 5, 0, 2) }
		local t29 = {
			Anchor = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, 5, 0, 2),
		}
		t25[1] = t26
		t25[2] = t27
		t25[3] = t28
		t25[4] = t29
		for _, v83 in t25 do
			local tween5 = index5:Create("Frame", {
				Parent = tween.Instance, AnchorPoint = v83.Anchor, Position = v83.Position, Size = v83.Size, BackgroundTransparency = 0.15,
				ZIndex = 67, BackgroundColor3 = arg4,
			})
			index5:Create("UICorner", { Parent = tween5.Instance, CornerRadius = UDim.new(1, 0) })
			table.insert(t24, tween5)
		end
		local tween5 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(1, -16, 1, -16), BackgroundTransparency = 0.2, ZIndex = 67, BackgroundColor3 = Color3.fromRGB(12, 12, 14),
		})
		tween5:AddToTheme({ BackgroundColor3 = "Background" })
		index5:Create("UICorner", { Parent = tween5.Instance, CornerRadius = UDim.new(1, 0) })
		local tween6 = index5:Create("UIStroke", {
			Parent = tween5.Instance, Color = arg4, Thickness = 2, Transparency = 0, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		})
		local v83 = 1
		index5:Create("UIGradient", {
			Parent = tween5.Instance, Rotation = -115,
			Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 150, 150)) }),
			Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.35), NumberSequenceKeypoint.new(v83, 0) }),
		})
		return {
			Marker = tween, Halo = tween2, Ping = tween3, PingStroke = tween4, Ticks = t24, Ring = tween5, Stroke = tween6,
			Number = index5:Create("TextLabel", {
				Parent = tween5.Instance, FontFace = index3.Font, TextColor3 = arg4, Text = tostring(arg3), Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1, TextStrokeTransparency = 0.55, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), ZIndex = 68,
				TextSize = 14,
			}),
			Color = arg4,
		}
	end
	local function f37(arg3, arg4)
		local tween = index5:Create("TextButton", {
			Parent = t22.SlotList.Instance, FontFace = index3.Font, Text = "", AutoButtonColor = false, LayoutOrder = arg3,
			Size = UDim2.new(1, 0, 0, 58), ZIndex = 63, TextSize = 14, BackgroundColor3 = Color3.fromRGB(27, 26, 29),
		})
		tween:AddToTheme({ BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = tween.Instance, CornerRadius = UDim.new(0, 6) })
		local tween2 = index5:Create("Frame", {
			Parent = tween.Instance, AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(0, 2, 1, -16),
			BackgroundTransparency = 1, ZIndex = 64, BackgroundColor3 = arg4,
		})
		index5:Create("UICorner", { Parent = tween2.Instance, CornerRadius = UDim.new(1, 0) })
		local tween3 = index5:Create("Frame", {
			Parent = tween.Instance, Position = UDim2.new(0, 12, 0, 8), Size = UDim2.new(0, 28, 0, 28), ZIndex = 64,
			BackgroundColor3 = Color3.fromRGB(38, 36, 42),
		})
		tween3:AddToTheme({ BackgroundColor3 = "Outline" })
		index5:Create("UICorner", { Parent = tween3.Instance, CornerRadius = UDim.new(0, 6) })
		index5:Create("TextLabel", {
			Parent = tween3.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), Text = tostring(arg3),
			Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, ZIndex = 65, TextSize = 15,
		}):AddToTheme({ TextColor3 = "Text" })
		local tween4 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), TextTransparency = 0.1,
			Text = "Slot " .. arg3, AutomaticSize = Enum.AutomaticSize.X, Size = UDim2.new(0, 0, 0, 16), Position = UDim2.new(0, 48, 0, 10),
			BackgroundTransparency = 1, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 64, TextSize = 15,
		})
		tween4:AddToTheme({ TextColor3 = "Text" })
		local tween5 = index5:Create("TextLabel", {
			Parent = tween.Instance, FontFace = index3.Font, TextColor3 = Color3.fromRGB(240, 240, 240), RichText = true, Text = "",
			Size = UDim2.new(1, -60, 0, 15), Position = UDim2.new(0, 48, 0, 32), BackgroundTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 64, TextSize = 14,
		})
		local tween6 = index5:Create("TextButton", {
			Parent = tween.Instance, Text = "", AutoButtonColor = false, AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -12, 0.5, -1), Size = UDim2.new(0, 28, 0, 28), BackgroundTransparency = 1, ZIndex = 65,
			BackgroundColor3 = Color3.fromRGB(38, 36, 42),
		})
		tween6:AddToTheme({ BackgroundColor3 = "Outline" })
		index5:Create("UICorner", { Parent = tween6.Instance, CornerRadius = UDim.new(0, 7) })
		local tween7 = index5:Create("Frame", {
			Parent = tween6.Instance, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -14),
			Size = UDim2.new(0, 17, 0, 10.5), BackgroundTransparency = 1, ClipsDescendants = true, ZIndex = 66,
		})
		local tween8 = index5:Create("Frame", {
			Parent = tween7.Instance, Position = UDim2.new(0, 2, 0, 2), Size = UDim2.new(0, 13, 0, 13), BackgroundTransparency = 1,
			ZIndex = 66,
		})
		index5:Create("UICorner", { Parent = tween8.Instance, CornerRadius = UDim.new(1, 0) })
		local tween9 = index5:Create("UIStroke", {
			Parent = tween8.Instance, Thickness = 2, Color = arg4, ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		})
		local tween10 = index5:Create("Frame", {
			Parent = tween6.Instance, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -4),
			Size = UDim2.new(0, 15, 0, 11), ZIndex = 67, BackgroundColor3 = arg4,
		})
		index5:Create("UICorner", { Parent = tween10.Instance, CornerRadius = UDim.new(0, 3) })
		local tween11 = index5:Create("Frame", {
			Parent = tween10.Instance, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
			Size = UDim2.new(0, 3, 0, 5), ZIndex = 68, BackgroundColor3 = Color3.fromRGB(26, 26, 29),
		})
		tween11:AddToTheme({ BackgroundColor3 = "Element" })
		index5:Create("UICorner", { Parent = tween11.Instance, CornerRadius = UDim.new(1, 0) })
		tween6:OnHover(function()
			tween6:Tween(nil, { BackgroundTransparency = 0.3 })
		end)
		tween6:OnHoverLeave(function()
			tween6:Tween(nil, { BackgroundTransparency = 1 })
		end)
		return {
			Row = tween, SelectBar = tween2, Badge = tween3, Title = tween4, Coords = tween5, LockButton = tween6, LockBody = tween10,
			LockHole = tween11, ShackleClip = tween7, ShackleStroke = tween9, Color = arg4,
		}
	end
	local v83 = Color3.fromRGB(100, 165, 255)
	local v84 = Color3.fromRGB(255, 95, 95)
	t19.RefreshRow = function(arg3, arg4)
		local v85 = t19.Rows[arg4]
		local v86 = t19.Value[arg4]
		if not v85 or not v86 then
			return
		end
		v85.Coords.Instance.Text = string.format("%s %s, %s %s", index3:ToRich("X", v83), index3:ToRich(tostring(f28(v86.X)), v83), index3:ToRich("Z", v84), index3:ToRich(tostring(f28(v86.Z)), v84))
		local tweenInfo = TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		if v86.Locked then
			v85.ShackleClip:Tween(tweenInfo, { Position = UDim2.new(0.5, 0, 1, -14) })
			v85.LockBody:Tween(nil, { BackgroundTransparency = 0 })
			v85.LockHole:Tween(nil, { BackgroundTransparency = 0 })
			v85.ShackleStroke:Tween(nil, { Transparency = 0 })
		else
			v85.ShackleClip:Tween(tweenInfo, { Position = UDim2.new(0.5, 5, 1, -14) })
			v85.LockBody:Tween(nil, { BackgroundTransparency = 0.5 })
			v85.LockHole:Tween(nil, { BackgroundTransparency = 0.5 })
			v85.ShackleStroke:Tween(nil, { Transparency = 0.5 })
		end
		if t19.ShouldShowWorld and t19:ShouldShowWorld() then
			t19:RefreshWorldRing(arg4)
		end
		local v87 = t19.Markers[arg4]
		if v87 then
			for _, v88 in v87.Ticks do
				v88:Tween(nil, { BackgroundTransparency = v86.Locked and 0.7 or 0.15 })
			end
			v87.Stroke:Tween(nil, { Transparency = v86.Locked and 0.5 or 0 })
			v87.Ring:Tween(nil, { BackgroundTransparency = v86.Locked and 0.55 or 0.2 })
			v87.Number:Tween(nil, { TextTransparency = v86.Locked and 0.5 or 0 })
		end
	end
	t19.RefreshReadout = function()
		local v85 = t19.Value[t19.Selected]
		if not v85 then
			return
		end
		t22.Readout.Instance.Text = string.format("%s  •  %s %s   %s %s%s", index3:ToRich("Slot " .. t19.Selected, v78[(t19.Selected - 1) % #v78 + 1]), index3:ToRich("X", v83), tostring(f28(v85.X)), index3:ToRich("Z", v84), tostring(f28(v85.Z)), v85.Locked and "   (locked)" or "")
	end
	t19.PingMarker = function(arg3, arg4)
		local v85 = t19.Markers[arg4]
		if not v85 then
			if not b2 then
				return
			end
			return
		end
		v85.Ping.Instance.Size = UDim2.new(1, -16, 1, -16)
		v85.PingStroke.Instance.Transparency = 0.1
		v85.Ping:Tween(TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(1, 24, 1, 24) })
		v85.PingStroke:Tween(TweenInfo.new(0.55, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Transparency = 1 })
	end
	t19.Select = function(arg3, selected)
		if not t19.Value[selected] then
			return
		end
		t19.Selected = selected
		for k_, v85 in t19.Rows do
			local b15 = k_ == selected
			v85.SelectBar:Tween(nil, { BackgroundTransparency = b15 and 0 or 1 })
			v85.Row:Tween(nil, { BackgroundTransparency = b15 and 0 or 0.35 })
			local v86 = t19.Markers[k_]
			if v86 then
				local n = b15 and 44 or 38
				v86.Halo:Tween(nil, { BackgroundTransparency = b15 and 0.72 or 0.9 })
				v86.Stroke:Tween(nil, { Thickness = b15 and 2.6 or 2 })
				v86.Marker:Tween(TweenInfo.new(0.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Size = UDim2.new(0, n, 0, n) })
				v86.Marker.Instance.ZIndex = b15 and 70 or 66
				if b15 then
					t19:PingMarker(k_)
				end
			end
		end
		t19:RefreshReadout()
	end
	t19.PushFlag = function()
		index3.Flags[t19.Flag] = t19.Value
	end
	t19.Fire = function(arg3, arg4)
		t19:PushFlag()
		if t19.Callback then
			index3:SafeCall(t19.Callback, t19.Value, arg4)
		end
	end
	t19.SetSlotUV = function(arg3, arg4, arg5, arg6, arg7)
		local v85 = t19.Value[arg4]
		if not v85 then
			return
		end
		local v86 = math.clamp(arg5, 0, 1)
		local v87 = math.clamp(arg6, 0, 1)
		local v88, v89 = t19:UVToWorld(v86, v87)
		v85.X = f28(v88)
		v85.Z = f28(v89)
		local v90 = t19.Markers[arg4]
		if v90 then
			v90.Marker.Instance.Position = UDim2.new(v86, 0, v87, 0)
		end
		t19:RefreshRow(arg4)
		if arg4 == t19.Selected then
			t19:RefreshReadout()
		end
		t19:PushFlag()
		if not arg7 then
			t19:Fire(arg4)
		end
	end
	t19.SetSlotWorld = function(arg3, arg4, arg5, arg6, arg7)
		local v85 = t19.Value[arg4]
		if not v85 then
			return
		end
		v85.X = f28(arg5)
		v85.Z = f28(arg6)
		local v86, v87 = t19:WorldToUV(v85.X, v85.Z)
		local v88 = t19.Markers[arg4]
		if v88 then
			v88.Marker.Instance.Position = UDim2.new(v86, 0, v87, 0)
		end
		t19:RefreshRow(arg4)
		if arg4 == t19.Selected then
			t19:RefreshReadout()
		end
		t19:PushFlag()
		if not arg7 then
			t19:Fire(arg4)
		end
	end
	t19.PlaceFromScreen = function(arg3, arg4, arg5)
		local instance = t22.MapCanvas.Instance
		local absoluteSize = instance.AbsoluteSize
		if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
			return
		end
		t19:SetSlotUV(arg4, (arg5.X - instance.AbsolutePosition.X) / absoluteSize.X, (arg5.Y - instance.AbsolutePosition.Y) / absoluteSize.Y, true)
	end
	t19.RefreshFromWorld = function()
		for k_, v85 in t19.Value do
			local v86, v87 = t19:WorldToUV(v85.X, v85.Z)
			local v88 = t19.Markers[k_]
			if v88 then
				v88.Marker.Instance.Position = UDim2.new(v86, 0, v87, 0)
			end
			t19:RefreshRow(k_)
		end
		t19:RefreshReadout()
	end
	t19.Get = function()
		return t19.Value
	end
	t19.GetSlot = function(arg3, arg4)
		local v85 = t19.Value[arg4]
		if not v85 then
			return nil
		end
		return Vector3.new(v85.X, t19.Height, v85.Z)
	end
	t19.GetAll = function()
		local t24 = {}
		for i = 1, t19.SlotCount do
			t24[i] = t19:GetSlot(i)
		end
		return t24
	end
	t19.Set = function(arg3, arg4)
		local v85 = "table"
		if type(arg4) ~= v85 then
			return
		end
		for i = 1, t19.SlotCount do
			local v86 = arg4[i] or arg4[tostring(i)]
			if type(v86) == "table" then
				local num = tonumber(v86.X or v86.x)
				local num2 = tonumber(v86.Z or v86.z)
				if num and num2 then
					t19.Value[i].Locked = v86.Locked and true or false
					t19:SetSlotWorld(i, num, num2, true)
				end
			end
		end
		t19:RefreshReadout()
		t19:Fire(nil)
	end
	t19.SetLocked = function(arg3, arg4, arg5)
		local v85 = t19.Value[arg4]
		if not v85 then
			return
		end
		v85.Locked = arg5 and true or false
		t19:RefreshRow(arg4)
		t19:RefreshReadout()
		t19:PushFlag()
	end
	t19.SetMap = function(arg3, mapImage, arg4, mapAspect)
		if mapImage then
			t19.MapImage = mapImage
			t22.MapImage.Instance.Image = mapImage
		end
		if mapAspect then
			t19.MapAspect = mapAspect
			t22.Aspect.Instance.AspectRatio = mapAspect
		end
		if arg4 then
			t19:SetCorners(arg4)
		end
		t19:ResetView()
	end
	t19.SetVisibility = function(arg3, visible)
		t21.Block.Instance.Visible = visible
	end
	t19.RefreshPosition = function(arg3, arg4)
		if arg4 then
			t21.Text:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 14, 0.5, 0) })
			t21.OpenButton:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(1, -6, 0.5, 0) })
			t21.AccentBar:Tween(TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.new(0, 4, 0.5, 0) })
		else
			t21.Text.Instance.Position = UDim2.new(0, 74, 0.5, 0)
			t21.OpenButton.Instance.Position = UDim2.new(1, 54, 0.5, 0)
			t21.AccentBar.Instance.Position = UDim2.new(0, -20, 0.5, 0)
		end
	end
	t19.Open = function()
		if t19.IsOpen then
			return
		end
		t19.IsOpen = true
		t22.Overlay.Instance.Parent = t19.Window.Items.MainFrame.Instance
		t22.Overlay.Instance.Visible = true
		t22.Overlay.Instance.BackgroundTransparency = 1
		t22.Overlay:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 0.25 })
		t22.Panel.Instance.Position = UDim2.new(0.5, 0, 0.5, 18)
		t22.Panel:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, 0, 0.5, 0) })
		t19:ApplyView(true)
		t19:RefreshFromWorld()
		t19:Select(t19.Selected)
		t19:ApplyWorldVisibility()
	end
	t19.Close = function()
		if not t19.IsOpen then
			return
		end
		t19.IsOpen = false
		t19.Dragging = nil
		t19.Panning = nil
		t19.PinchActive = false
		t22.Overlay:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
		t22.Panel:Tween(TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = UDim2.new(0.5, 0, 0.5, 18) })
		task.delay(0.22, function()
			if not t19.IsOpen then
				t22.Overlay.Instance.Visible = false
				t22.Overlay.Instance.Parent = index3.UnusedHolder.Instance
			end
		end)
		t19:Fire(nil)
		t19:ApplyWorldVisibility()
	end
	t19.Toggle = function()
		if t19.IsOpen then
			t19:Close()
		else
			t19:Open()
		end
	end
	for i = 1, t19.SlotCount do
		local v85 = v78[(i - 1) % #v78 + 1]
		t19.Markers[i] = f36(i, v85)
		t19.Rows[i] = f37(i, v85)
		t23[i] = f34(i, v85)
		local v86 = t19.Markers[i]
		local v87 = t19.Rows[i]
		local n = i / t19.SlotCount * 3.1415926535897931 * 2
		t19:SetSlotUV(i, 0.5 + math.cos(n) * 0.06, 0.5 + math.sin(n) * 0.06, true)
		local connection = nil
		v86.Marker:Connect("InputBegan", function(arg3)
			if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 and arg3.UserInputType ~= Enum.UserInputType.Touch then
				return
			end
			t19:Select(i)
			if t19.Value[i].Locked then
				return
			end
			t19.Dragging = i
			v86.Halo:Tween(nil, { BackgroundTransparency = 0.58 })
			if connection then
				return
			end
			connection = arg3.Changed:Connect(function()
				if arg3.UserInputState == Enum.UserInputState.End then
					t19.Dragging = nil
					v86.Halo:Tween(nil, { BackgroundTransparency = 0.72 })
					t19:Fire(i)
					connection:Disconnect()
					connection = nil
				end
			end)
		end)
		v87.Row:Connect("InputBegan", function(arg3)
			if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
				if index3:IsMouseOverFrame(v87.LockButton) then
					return
				end
				t19:Select(i)
			end
		end)
		v87.LockButton:Connect("InputBegan", function(arg3)
			if arg3.UserInputType == Enum.UserInputType.MouseButton1 or arg3.UserInputType == Enum.UserInputType.Touch then
				t19:SetLocked(i, not t19.Value[i].Locked)
			end
		end)
		v87.Row:OnHover(function()
			if t19.Selected ~= i then
				v87.Row:Tween(nil, { BackgroundTransparency = 0.12 })
			end
		end)
		v87.Row:OnHoverLeave(function()
			if t19.Selected ~= i then
				v87.Row:Tween(nil, { BackgroundTransparency = 0.35 })
			end
		end)
	end
	local Area, v85 = f35("Area", 66, 0)
	local Done_ = f35("Done", 56, 4)
	local function f38()
		v85.Instance.Text = t19.WorldPreview and "Area on" or "Area off"
		v85:Tween(nil, { TextTransparency = t19.WorldPreview and 0 or 0.5 })
	end
	Area:Connect("MouseButton1Down", function()
		t19:SetWorldPreview(not t19.WorldPreview)
		f38()
	end)
	f38()
	Done_:Connect("MouseButton1Down", function()
		t19:Close()
	end)
	t21.OpenButton:Connect("MouseButton1Down", function()
		t19:Toggle()
	end)
	t22.Close:Connect("MouseButton1Down", function()
		t19:Close()
	end)
	t22.MapImage:Connect("InputBegan", function(arg3)
		if arg3.UserInputType ~= Enum.UserInputType.MouseButton1 and arg3.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		if t19.PinchActive then
			return
		end
		local panning = {
			StartX = arg3.Position.X, StartY = arg3.Position.Y, StartPanU = t19.PanU, StartPanV = t19.PanV, Moved = false,
		}
		t19.Panning = panning
		local connection = nil
		connection = arg3.Changed:Connect(function()
			if arg3.UserInputState ~= Enum.UserInputState.End then
				return
			end
			if not panning.Moved then
				local v86 = t19.Value[t19.Selected]
				if v86 and not v86.Locked then
					t19:PlaceFromScreen(t19.Selected, arg3.Position)
					t19:Fire(t19.Selected)
				end
			end
			if t19.Panning == panning then
				t19.Panning = nil
			end
			connection:Disconnect()
			connection = nil
		end)
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if not t19.IsOpen then
			return
		end
		if arg3.UserInputType ~= Enum.UserInputType.MouseWheel then
			return
		end
		if not index3:IsMouseOverFrame(t22.Viewport) then
			return
		end
		local z = arg3.Position.Z
		if z == 0 then
			return
		end
		t19:ZoomAt(t19.Zoom * (z > 0 and 1.2 or 0.83333333333333337), Vector2.new(mouse.X, mouse.Y))
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		local panning = t19.Panning
		if not panning or t19.PinchActive then
			return
		end
		if arg3.UserInputType ~= Enum.UserInputType.MouseMovement and arg3.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local absoluteSize = t22.Viewport.Instance.AbsoluteSize
		if absoluteSize.X <= 0 or absoluteSize.Y <= 0 then
			return
		end
		local n = arg3.Position.X - panning.StartX
		local n32 = arg3.Position.Y - panning.StartY
		local b15 = not panning.Moved
		local b16
		if b15 then
			b16 = math.abs(n) > 5 or math.abs(n32) > 5
		else
			b16 = b15
		end
		if b16 then
			panning.Moved = true
		end
		if not panning.Moved then
			return
		end
		t19.PanU = panning.StartPanU + n / absoluteSize.X
		t19.PanV = panning.StartPanV + n32 / absoluteSize.Y
		t19:ApplyView(true)
	end)
	index3:Connect(UserInputService.TouchPinch, function(arg3, arg4, arg5, arg6)
		if not t19.IsOpen then
			return
		end
		if arg6 == Enum.UserInputState.Begin then
			t19.PinchActive = true
			t19.PinchStart = t19.Zoom
			t19.Panning = nil
			return
		end
		if arg6 == Enum.UserInputState.End or arg6 == Enum.UserInputState.Cancel then
			t19.PinchActive = false
			t19.PinchStart = nil
			return
		end
		if not t19.PinchStart then
			return
		end
		local n = arg3[1]
		if arg3[2] then
			n = (arg3[1] + arg3[2]) / 2
		end
		if n then
			t19:ZoomAt(t19.PinchStart * arg4, n, true)
			return
		end
	end)
	t22.ZoomIn:Connect("MouseButton1Down", function()
		t19:ZoomBy(1.44)
	end)
	t22.ZoomOut:Connect("MouseButton1Down", function()
		t19:ZoomBy(0.69444444444444442)
	end)
	t22.ZoomReset:Connect("MouseButton1Down", function()
		t19:ResetView()
	end)
	index3:Connect(UserInputService.InputChanged, function(arg3)
		if not t19.Dragging then
			return
		end
		if arg3.UserInputType ~= Enum.UserInputType.MouseMovement and arg3.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		t19:PlaceFromScreen(t19.Dragging, arg3.Position)
	end)
	index3:Connect(UserInputService.InputBegan, function(arg3, arg4)
		if arg4 then
			return
		end
		if t19.IsOpen and arg3.KeyCode == Enum.KeyCode.Escape then
			t19:Close()
		end
	end)
	if t18.Default or t18.default then
		t19:Set(t18.Default or t18.default)
	end
	t19:Select(1)
	t19:PushFlag()
	t19:ApplyWorldVisibility()
	index3.SetFlags[t19.Flag] = function(arg3)
		t19:Set(arg3)
	end
	t19.Section.Elements[#t19.Section.Elements + 1] = t19
	return t19
end

index3.GetFlag = function(arg, arg2)
	return arg.Flags[arg2]
end

index3.CreateSettingsPage = function(arg, arg2)
	local v78 = arg2:Page({ Name = "Settings", Icon = "122669828593160" })
	local v79 = v78:Section({
		Name = "Configs", Side = 1, Icon = "10723433935", Description = "Configuration management system.",
	})
	local v80 = nil
	local v81 = nil
	local v82 = v79:Listbox({
		Flag = "ConfigsList", Items = {}, Multi = false,
		Callback = function(arg3)
			v81 = arg3
		end,
	})
	v79:Textbox({
		Flag = "ConfigsName", Placeholder = "Input Name.", Numeric = false, Finished = true,
		Callback = function(arg3)
			v80 = arg3
		end,
	})
	v79:Button({
		Name = "Create",
		Callback = function()
			if v80 and v80 ~= "" then
				if not isfile(index3.Folders.Configs .. "/" .. v80 .. ".json") then
					writefile(index3.Folders.Configs .. "/" .. v80 .. ".json", index3:GetConfig())
					index3:RefreshConfigsList(v82)
				end
			end
		end,
	})
	v79:Button({
		Name = "Delete",
		Callback = function()
			if v81 then
				index3:DeleteConfig(v81)
				index3:RefreshConfigsList(v82)
			end
		end,
	})
	v79:Button({
		Name = "Load",
		Callback = function()
			if v81 then
				index3:LoadConfig(readfile(index3.Folders.Configs .. "/" .. v81), v81)
			end
		end,
	})
	v79:Button({
		Name = "Save",
		Callback = function()
			if v81 then
				writefile(index3.Folders.Configs .. "/" .. v81, index3:GetConfig(v81))
			end
		end,
	})
	v79:Button({
		Name = "Refresh",
		Callback = function()
			index3:RefreshConfigsList(v82)
		end,
	})
	index3:RefreshConfigsList(v82)
	return v78
end

if not isfile(index3.Folders.Configs .. "/" .. configFileName) then
	writefile(index3.Folders.Configs .. "/" .. configFileName, index3:GetConfig())
end

return index3

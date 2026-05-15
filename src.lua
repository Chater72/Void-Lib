
---

## 📦 src.lua (Библиотека)

```lua
-- ⬡ Void UI Library v5.0
-- GitHub: https://github.com/tolikzdev/void-ui

local Library = {}
Library.Theme = {
	Background = Color3.fromRGB(8, 8, 12),
	Surface = Color3.fromRGB(12, 12, 18),
	Surface2 = Color3.fromRGB(16, 16, 24),
	Text = Color3.fromRGB(240, 240, 250),
	SubText = Color3.fromRGB(160, 160, 180),
	Accent = Color3.fromRGB(240, 240, 250),
	Inactive = Color3.fromRGB(30, 30, 40),
	ButtonAccent = Color3.fromRGB(140, 110, 255),
}

local LOGO_ID = "rbxassetid://72732106697412"
local isStudio = game:GetService("RunService"):IsStudio()

-- ============================================
-- CREATE
-- ============================================
function Library:Create()
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local TweenService = game:GetService("TweenService")
	local StarterGui = game:GetService("StarterGui")
	local CoreGui = game:GetService("CoreGui")

	local LocalPlayer = Players.LocalPlayer
	if not LocalPlayer then
		repeat LocalPlayer = Players.LocalPlayer; task.wait(0.1) until LocalPlayer
	end

	local gui = {}
	gui.Settings = {
		Keybind = Enum.KeyCode.Insert,
		Draggable = true,
		DragSmoothness = 3,
	}

	local guiParent = isStudio and LocalPlayer:WaitForChild("PlayerGui") or CoreGui

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "VoidLib"
	ScreenGui.Parent = guiParent
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	-- ============================================
	-- NOTIFICATIONS
	-- ============================================
	local NotificationHolder = Instance.new("Frame")
	NotificationHolder.Name = "Notifications"
	NotificationHolder.Parent = ScreenGui
	NotificationHolder.BackgroundTransparency = 1
	NotificationHolder.Size = UDim2.new(0, 300, 0, 200)
	NotificationHolder.Position = UDim2.new(1, -310, 1, -50)
	NotificationHolder.AnchorPoint = Vector2.new(0, 1)
	NotificationHolder.ZIndex = 999

	local NotifList = Instance.new("UIListLayout", NotificationHolder)
	NotifList.Padding = UDim.new(0, 6)
	NotifList.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotifList.HorizontalAlignment = Enum.HorizontalAlignment.Right
	NotifList.SortOrder = Enum.SortOrder.LayoutOrder

	local function notify(title, text, duration)
		duration = duration or 4
		local n = Instance.new("Frame", NotificationHolder)
		n.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
		n.BackgroundTransparency = 0.2
		n.Size = UDim2.new(1, 0, 0, 50)
		n.ZIndex = 999
		Instance.new("UICorner", n).CornerRadius = UDim.new(0, 8)

		local s = Instance.new("UIStroke", n)
		s.Color = Library.Theme.ButtonAccent
		s.Thickness = 0.6
		s.Transparency = 0.4

		local tl = Instance.new("TextLabel", n)
		tl.BackgroundTransparency = 1
		tl.Size = UDim2.new(1, -20, 0, 18)
		tl.Position = UDim2.new(0, 10, 0, 8)
		tl.Font = Enum.Font.GothamBold
		tl.Text = title
		tl.TextColor3 = Color3.fromRGB(240, 240, 250)
		tl.TextSize = 12
		tl.TextXAlignment = Enum.TextXAlignment.Left
		tl.ZIndex = 999

		local txt = Instance.new("TextLabel", n)
		txt.BackgroundTransparency = 1
		txt.Size = UDim2.new(1, -20, 0, 16)
		txt.Position = UDim2.new(0, 10, 0, 27)
		txt.Font = Enum.Font.Gotham
		txt.Text = text
		txt.TextColor3 = Color3.fromRGB(160, 160, 180)
		txt.TextSize = 10
		txt.TextXAlignment = Enum.TextXAlignment.Left
		txt.ZIndex = 999

		spawn(function()
			task.wait(duration)
			TweenService:Create(n, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
			TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 1}):Play()
			TweenService:Create(tl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
			TweenService:Create(txt, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
			task.wait(0.3)
			n:Destroy()
		end)
	end

	-- ============================================
	-- MAIN CONTAINER
	-- ============================================
	local MainContainer = Instance.new("Frame")
	MainContainer.Name = "MainContainer"
	MainContainer.Parent = ScreenGui
	MainContainer.BackgroundTransparency = 1
	MainContainer.Size = UDim2.new(1, 0, 1, 0)
	MainContainer.ZIndex = 1

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = MainContainer
	Main.BackgroundColor3 = Library.Theme.Background
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(isStudio and 0.5 or 1, isStudio and -230 or -500, 0.5, -230)
	Main.Size = UDim2.new(0, 460, 0, 460)
	Main.ClipsDescendants = true
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

	local MainStroke = Instance.new("UIStroke", Main)
	MainStroke.Color = Color3.fromRGB(255, 255, 255)
	MainStroke.Thickness = 0.8
	MainStroke.Transparency = 0.82

	local Glow = Instance.new("Frame")
	Glow.Name = "Glow"
	Glow.Parent = MainContainer
	Glow.BackgroundColor3 = Library.Theme.Accent
	Glow.BackgroundTransparency = 0.94
	Glow.BorderSizePixel = 0
	Glow.Size = UDim2.new(0, 472, 0, 472)
	Glow.Position = UDim2.new(isStudio and 0.5 or 1, isStudio and -236 or -506, 0.5, -236)
	Glow.ZIndex = 0
	Instance.new("UICorner", Glow).CornerRadius = UDim.new(0, 12)

	-- ============================================
	-- TOP BAR
	-- ============================================
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = Main
	TopBar.BackgroundColor3 = Library.Theme.Surface
	TopBar.BorderSizePixel = 0
	TopBar.Size = UDim2.new(1, 0, 0, 44)
	Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 10)

	local Title = Instance.new("TextLabel", TopBar)
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0, 100, 1, 0)
	Title.Position = UDim2.new(0, 14, 0, 0)
	Title.Font = Enum.Font.GothamBold
	Title.Text = "Void UI"
	Title.TextColor3 = Library.Theme.Text
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.TextTransparency = 0.08

	local CloseBtn = Instance.new("TextButton", TopBar)
	CloseBtn.BackgroundTransparency = 1
	CloseBtn.Size = UDim2.new(0, 28, 0, 28)
	CloseBtn.Position = UDim2.new(1, -32, 0.5, -14)
	CloseBtn.Font = Enum.Font.GothamBold
	CloseBtn.Text = "×"
	CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
	CloseBtn.TextSize = 20
	CloseBtn.TextTransparency = 0.2

	CloseBtn.MouseButton1Click:Connect(function()
		MainContainer.Visible = false
		notify("Void UI Hidden", "Press " .. gui.Settings.Keybind.Name .. " to open", 5)
		if not isStudio then
			StarterGui:SetCore("SendNotification", {
				Title = "Void UI",
				Text = "Hidden. Press " .. gui.Settings.Keybind.Name .. " to open",
				Duration = 5
			})
		end
	end)

	local Separator = Instance.new("Frame", Main)
	Separator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Separator.BackgroundTransparency = 0.85
	Separator.BorderSizePixel = 0
	Separator.Size = UDim2.new(1, 0, 0, 1)
	Separator.Position = UDim2.new(0, 0, 0, 44)

	-- ============================================
	-- TABS
	-- ============================================
	local TabContainer = Instance.new("Frame")
	TabContainer.Parent = Main
	TabContainer.BackgroundColor3 = Library.Theme.Surface
	TabContainer.BorderSizePixel = 0
	TabContainer.Size = UDim2.new(1, 0, 0, 35)
	TabContainer.Position = UDim2.new(0, 0, 0, 45)

	local ContentArea = Instance.new("Frame")
	ContentArea.Parent = Main
	ContentArea.BackgroundTransparency = 1
	ContentArea.Size = UDim2.new(1, 0, 1, -80)
	ContentArea.Position = UDim2.new(0, 0, 0, 80)

	local tabs = {}
	local tabButtons = {}
	local currentTab = nil

	local function selectTab(index)
		for _, btn in ipairs(tabButtons) do
			TweenService:Create(btn, TweenInfo.new(0.2), {TextTransparency = 0.45, TextColor3 = Library.Theme.SubText}):Play()
		end
		TweenService:Create(tabButtons[index], TweenInfo.new(0.2), {TextTransparency = 0.05, TextColor3 = Library.Theme.Text}):Play()
		for _, t in ipairs(tabs) do t.page.Visible = false end
		tabs[index].page.Visible = true
		currentTab = tabs[index]
	end

	-- ============================================
	-- LIVE STATS
	-- ============================================
	local StatsFrame = Instance.new("Frame")
	StatsFrame.Name = "LiveStats"
	StatsFrame.Parent = ScreenGui
	StatsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	StatsFrame.BackgroundTransparency = 0.5
	StatsFrame.BorderSizePixel = 0
	StatsFrame.Size = UDim2.new(0, 160, 0, 36)
	StatsFrame.Position = UDim2.new(0, 10, 0, 10)
	StatsFrame.ZIndex = 10
	Instance.new("UICorner", StatsFrame).CornerRadius = UDim.new(0, 6)

	local FPSLabel = Instance.new("TextLabel", StatsFrame)
	FPSLabel.BackgroundTransparency = 1
	FPSLabel.Size = UDim2.new(0, 50, 1, 0)
	FPSLabel.Position = UDim2.new(0, 8, 0, 0)
	FPSLabel.Font = Enum.Font.GothamBold
	FPSLabel.Text = "60 FPS"
	FPSLabel.TextColor3 = Color3.fromRGB(80, 255, 120)
	FPSLabel.TextSize = 11
	FPSLabel.TextXAlignment = Enum.TextXAlignment.Left

	local PingLabel = Instance.new("TextLabel", StatsFrame)
	PingLabel.BackgroundTransparency = 1
	PingLabel.Size = UDim2.new(0, 50, 1, 0)
	PingLabel.Position = UDim2.new(0, 60, 0, 0)
	PingLabel.Font = Enum.Font.GothamBold
	PingLabel.Text = "0 ms"
	PingLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
	PingLabel.TextSize = 11
	PingLabel.TextXAlignment = Enum.TextXAlignment.Left

	spawn(function()
		while ScreenGui and ScreenGui.Parent do
			local fps = math.floor(1 / RunService.RenderStepped:Wait())
			FPSLabel.Text = fps .. " FPS"
			FPSLabel.TextColor3 = fps >= 60 and Color3.fromRGB(80, 255, 120) or (fps >= 30 and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(255, 80, 80))
			local ping = math.floor(LocalPlayer:GetNetworkPing() * 1000)
			PingLabel.Text = ping .. " ms"
			PingLabel.TextColor3 = ping <= 50 and Color3.fromRGB(100, 255, 150) or (ping <= 100 and Color3.fromRGB(255, 200, 50) or Color3.fromRGB(255, 100, 100))
		end
	end)

	-- Drag stats
	local statsDragging, statsDragStart, statsStartPos = false, nil, nil
	StatsFrame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			statsDragging = true; statsDragStart = input.Position; statsStartPos = StatsFrame.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if statsDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - statsDragStart
			StatsFrame.Position = UDim2.new(statsStartPos.X.Scale, statsStartPos.X.Offset + delta.X, statsStartPos.Y.Scale, statsStartPos.Y.Offset + delta.Y)
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.TouchEnded then
			statsDragging = false
		end
	end)

	-- ============================================
	-- GUI:TAB()
	-- ============================================
	function gui:Tab(name)
		local index = #tabs + 1

		local btn = Instance.new("TextButton")
		btn.Parent = TabContainer
		btn.BackgroundTransparency = 1
		btn.Size = UDim2.new(0, 72, 1, 0)
		btn.Position = UDim2.new(0, 6 + (index-1)*73, 0, 0)
		btn.Font = Enum.Font.GothamSemibold
		btn.Text = name
		btn.TextColor3 = Library.Theme.SubText
		btn.TextSize = 10
		btn.TextTransparency = 0.45

		local page = Instance.new("ScrollingFrame")
		page.Parent = ContentArea
		page.BackgroundTransparency = 1
		page.Size = UDim2.new(1, -10, 1, 0)
		page.Position = UDim2.new(0, 5, 0, 0)
		page.ScrollBarThickness = 3
		page.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 80)
		page.Visible = false
		page.AutomaticCanvasSize = Enum.AutomaticSize.Y
		page.ScrollingDirection = Enum.ScrollingDirection.Y

		local layout = Instance.new("UIListLayout", page)
		layout.Padding = UDim.new(0, 6)
		layout.SortOrder = Enum.SortOrder.LayoutOrder

		local tab = { page = page, btn = btn }
		table.insert(tabs, tab)
		table.insert(tabButtons, btn)

		btn.MouseButton1Click:Connect(function() selectTab(index) end)

		if index == 1 then selectTab(1) end

		-- ============================================
		-- TAB:TOGGLE()
		-- ============================================
		function tab:Toggle(options)
			options = options or {}
			local name = options.Name or "Toggle"
			local default = options.Default or false
			local callback = options.Callback or function() end

			local Toggle = Instance.new("Frame")
			Toggle.Parent = page
			Toggle.BackgroundColor3 = Library.Theme.Surface2
			Toggle.BackgroundTransparency = 0.4
			Toggle.BorderSizePixel = 0
			Toggle.Size = UDim2.new(1, -4, 0, 40)
			Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 6)

			local Label = Instance.new("TextLabel", Toggle)
			Label.BackgroundTransparency = 1
			Label.Size = UDim2.new(0.7, 0, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.Font = Enum.Font.GothamMedium
			Label.Text = name
			Label.TextColor3 = Library.Theme.Text
			Label.TextTransparency = 0.15
			Label.TextSize = 13
			Label.TextXAlignment = Enum.TextXAlignment.Left

			local SwitchBg = Instance.new("Frame", Toggle)
			SwitchBg.BackgroundColor3 = default and Library.Theme.ButtonAccent or Library.Theme.Inactive
			SwitchBg.BorderSizePixel = 0
			SwitchBg.Size = UDim2.new(0, 38, 0, 21)
			SwitchBg.Position = UDim2.new(1, -48, 0.5, -10.5)
			Instance.new("UICorner", SwitchBg).CornerRadius = UDim.new(0, 10.5)

			local Dot = Instance.new("Frame", SwitchBg)
			Dot.BackgroundColor3 = Library.Theme.Background
			Dot.BorderSizePixel = 0
			Dot.Size = UDim2.new(0, 15, 0, 15)
			Dot.Position = default and UDim2.new(1, -18, 0.5, -7.5) or UDim2.new(0, 3, 0.5, -7.5)
			Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

			local enabled = default
			local function updateVisual()
				if enabled then
					TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.ButtonAccent}):Play()
					TweenService:Create(Dot, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -7.5)}):Play()
				else
					TweenService:Create(SwitchBg, TweenInfo.new(0.2), {BackgroundColor3 = Library.Theme.Inactive}):Play()
					TweenService:Create(Dot, TweenInfo.new(0.2), {Position = UDim2.new(0, 3, 0.5, -7.5)}):Play()
				end
			end

			Toggle.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					enabled = not enabled
					updateVisual()
					callback(enabled)
				end
			end)

			return { SetValue = function(v) enabled = v; updateVisual() end, GetValue = function() return enabled end }
		end

		-- ============================================
		-- TAB:SLIDER()
		-- ============================================
		function tab:Slider(options)
			options = options or {}
			local name = options.Name or "Slider"
			local min = options.Min or 0
			local max = options.Max or 100
			local default = options.Default or 50
			local callback = options.Callback or function() end

			local Slider = Instance.new("Frame")
			Slider.Parent = page
			Slider.BackgroundColor3 = Library.Theme.Surface2
			Slider.BackgroundTransparency = 0.4
			Slider.BorderSizePixel = 0
			Slider.Size = UDim2.new(1, -4, 0, 52)
			Instance.new("UICorner", Slider).CornerRadius = UDim.new(0, 6)

			local Label = Instance.new("TextLabel", Slider)
			Label.BackgroundTransparency = 1
			Label.Size = UDim2.new(0.6, 0, 0, 18)
			Label.Position = UDim2.new(0, 12, 0, 6)
			Label.Font = Enum.Font.GothamMedium
			Label.Text = name
			Label.TextColor3 = Library.Theme.Text
			Label.TextTransparency = 0.15
			Label.TextSize = 12
			Label.TextXAlignment = Enum.TextXAlignment.Left

			local ValueLabel = Instance.new("TextLabel", Slider)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.Size = UDim2.new(0, 50, 0, 18)
			ValueLabel.Position = UDim2.new(1, -55, 0, 6)
			ValueLabel.Font = Enum.Font.GothamBold
			ValueLabel.Text = tostring(default)
			ValueLabel.TextColor3 = Library.Theme.Text
			ValueLabel.TextTransparency = 0.1
			ValueLabel.TextSize = 12
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

			local Track = Instance.new("Frame", Slider)
			Track.BackgroundColor3 = Library.Theme.Inactive
			Track.BorderSizePixel = 0
			Track.Size = UDim2.new(1, -40, 0, 4)
			Track.Position = UDim2.new(0, 20, 0, 32)
			Instance.new("UICorner", Track).CornerRadius = UDim.new(0, 2)

			local Fill = Instance.new("Frame", Track)
			Fill.BackgroundColor3 = Library.Theme.ButtonAccent
			Fill.BorderSizePixel = 0
			Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
			Instance.new("UICorner", Fill).CornerRadius = UDim.new(0, 2)

			local Dot = Instance.new("Frame", Track)
			Dot.BackgroundColor3 = Library.Theme.Text
			Dot.BackgroundTransparency = 0.1
			Dot.BorderSizePixel = 0
			Dot.Size = UDim2.new(0, 14, 0, 14)
			Dot.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
			Dot.ZIndex = 3
			Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

			local dragging = false
			local connection

			local function setValue(input)
				local mousePos = Vector2.new(input.Position.X, input.Position.Y)
				local trackPos = Track.AbsolutePosition
				local trackSize = Track.AbsoluteSize
				local relativeX = math.clamp((mousePos.X - trackPos.X) / trackSize.X, 0, 1)
				local value = math.clamp(math.floor(min + (max - min) * relativeX + 0.5), min, max)
				TweenService:Create(Fill, TweenInfo.new(0.05), {Size = UDim2.new(relativeX, 0, 1, 0)}):Play()
				TweenService:Create(Dot, TweenInfo.new(0.05), {Position = UDim2.new(relativeX, -7, 0.5, -7)}):Play()
				ValueLabel.Text = tostring(value)
				callback(value)
			end

			Dot.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					connection = UserInputService.InputChanged:Connect(function(change)
						if dragging and (change.UserInputType == Enum.UserInputType.MouseMovement or change.UserInputType == Enum.UserInputType.Touch) then
							setValue(change)
						end
					end)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.TouchEnded then
					dragging = false
					if connection then connection:Disconnect(); connection = nil end
				end
			end)

			Track.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					setValue(input)
				end
			end)
		end

		-- ============================================
		-- TAB:BUTTON()
		-- ============================================
		function tab:Button(options)
			options = options or {}
			local name = options.Name or "Button"
			local callback = options.Callback or function() end

			local Button = Instance.new("TextButton")
			Button.Parent = page
			Button.BackgroundColor3 = Library.Theme.Surface2
			Button.BackgroundTransparency = 0.4
			Button.BorderSizePixel = 0
			Button.Size = UDim2.new(1, -4, 0, 38)
			Button.Font = Enum.Font.GothamSemibold
			Button.Text = name
			Button.TextColor3 = Library.Theme.Text
			Button.TextTransparency = 0.15
			Button.TextSize = 13
			Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)

			local BtnStroke = Instance.new("UIStroke", Button)
			BtnStroke.Color = Library.Theme.ButtonAccent
			BtnStroke.Thickness = 0.5
			BtnStroke.Transparency = 0.8

			Button.MouseButton1Click:Connect(function()
				TweenService:Create(Button, TweenInfo.new(0.1), {Size = UDim2.new(1, -8, 0, 36), BackgroundTransparency = 0.2}):Play()
				task.wait(0.1)
				TweenService:Create(Button, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(1, -4, 0, 38), BackgroundTransparency = 0.4}):Play()
				callback()
			end)
		end

		-- ============================================
		-- TAB:DROPDOWN()
		-- ============================================
		function tab:Dropdown(options)
			options = options or {}
			local name = options.Name or "Dropdown"
			local items = options.Items or {}
			local callback = options.Callback or function() end

			local Dropdown = Instance.new("Frame")
			Dropdown.Parent = page
			Dropdown.BackgroundColor3 = Library.Theme.Surface2
			Dropdown.BackgroundTransparency = 0.4
			Dropdown.BorderSizePixel = 0
			Dropdown.Size = UDim2.new(1, -4, 0, 40)
			Dropdown.ClipsDescendants = true
			Instance.new("UICorner", Dropdown).CornerRadius = UDim.new(0, 6)

			local Label = Instance.new("TextLabel", Dropdown)
			Label.BackgroundTransparency = 1
			Label.Size = UDim2.new(0.5, 0, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.Font = Enum.Font.GothamMedium
			Label.Text = name
			Label.TextColor3 = Library.Theme.Text
			Label.TextTransparency = 0.15
			Label.TextSize = 13
			Label.TextXAlignment = Enum.TextXAlignment.Left

			local Selected = Instance.new("TextLabel", Dropdown)
			Selected.BackgroundTransparency = 1
			Selected.Size = UDim2.new(0, 120, 1, 0)
			Selected.Position = UDim2.new(1, -130, 0, 0)
			Selected.Font = Enum.Font.Gotham
			Selected.Text = items[1] or "..."
			Selected.TextColor3 = Library.Theme.SubText
			Selected.TextSize = 11
			Selected.TextXAlignment = Enum.TextXAlignment.Right

			local open = false
			local itemContainer = Instance.new("Frame")
			itemContainer.Parent = Dropdown
			itemContainer.BackgroundTransparency = 1
			itemContainer.Size = UDim2.new(1, -8, 0, 0)
			itemContainer.Position = UDim2.new(0, 4, 0, 44)

			local itemLayout = Instance.new("UIListLayout", itemContainer)
			itemLayout.Padding = UDim.new(0, 3)

			for _, item in ipairs(items) do
				local itemBtn = Instance.new("TextButton")
				itemBtn.Parent = itemContainer
				itemBtn.BackgroundColor3 = Library.Theme.Surface
				itemBtn.BackgroundTransparency = 0.5
				itemBtn.Size = UDim2.new(1, 0, 0, 28)
				itemBtn.Font = Enum.Font.Gotham
				itemBtn.Text = type(item) == "table" and item[1] or item
				itemBtn.TextColor3 = Library.Theme.Text
				itemBtn.TextSize = 11
				Instance.new("UICorner", itemBtn).CornerRadius = UDim.new(0, 4)

				itemBtn.MouseButton1Click:Connect(function()
					local val = type(item) == "table" and item[2] or item
					Selected.Text = type(item) == "table" and item[1] or item
					callback(val)
					open = false
					TweenService:Create(Dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 40)}):Play()
					TweenService:Create(itemContainer, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, 0)}):Play()
				end)
			end

			Dropdown.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					open = not open
					if open then
						local h = math.min(#items * 31 + 8, 120)
						TweenService:Create(Dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 40 + h)}):Play()
						TweenService:Create(itemContainer, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, h)}):Play()
					else
						TweenService:Create(Dropdown, TweenInfo.new(0.2), {Size = UDim2.new(1, -4, 0, 40)}):Play()
						TweenService:Create(itemContainer, TweenInfo.new(0.2), {Size = UDim2.new(1, -8, 0, 0)}):Play()
					end
				end
			end)
		end

		-- ============================================
		-- TAB:KEYBIND()
		-- ============================================
		function tab:Keybind(options)
			options = options or {}
			local callback = options.Callback or function() end
			local currentKey = options.Default or gui.Settings.Keybind

			local Keybind = Instance.new("Frame")
			Keybind.Parent = page
			Keybind.BackgroundColor3 = Library.Theme.Surface2
			Keybind.BackgroundTransparency = 0.4
			Keybind.BorderSizePixel = 0
				Keybind.Size = UDim2.new(1, -4, 0, 40)
			Instance.new("UICorner", Keybind).CornerRadius = UDim.new(0, 6)

			local Label = Instance.new("TextLabel", Keybind)
			Label.BackgroundTransparency = 1
			Label.Size = UDim2.new(0.5, 0, 1, 0)
			Label.Position = UDim2.new(0, 12, 0, 0)
			Label.Font = Enum.Font.GothamMedium
			Label.Text = "Keybind"
			Label.TextColor3 = Library.Theme.Text
			Label.TextTransparency = 0.15
			Label.TextSize = 13
			Label.TextXAlignment = Enum.TextXAlignment.Left

			local KeyText = Instance.new("TextLabel", Keybind)
			KeyText.BackgroundTransparency = 1
			KeyText.Size = UDim2.new(0, 100, 1, 0)
			KeyText.Position = UDim2.new(1, -110, 0, 0)
			KeyText.Font = Enum.Font.GothamBold
			KeyText.Text = currentKey.Name
			KeyText.TextColor3 = Library.Theme.ButtonAccent
			KeyText.TextSize = 11
			KeyText.TextXAlignment = Enum.TextXAlignment.Right

			local listening = false
			local conn

			local function startListening()
				if conn then conn:Disconnect() end
				listening = true
				KeyText.Text = "..."
				conn = UserInputService.InputBegan:Connect(function(input, gp)
					if not gp and input.UserInputType == Enum.UserInputType.Keyboard then
						currentKey = input.KeyCode
						KeyText.Text = currentKey.Name
						listening = false
						conn:Disconnect()
						conn = nil
						callback(currentKey)
						notify("Keybind Set", currentKey.Name, 3)
					end
				end)
			end

			Keybind.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					startListening()
				end
			end)
		end

		-- ============================================
		-- TAB:COLORPICKER()
		-- ============================================
		function tab:ColorPicker(options)
			options = options or {}
			local name = options.Name or "Color Picker"
			local callback = options.Callback or function() end

			local PickerFrame = Instance.new("Frame")
			PickerFrame.Parent = page
			PickerFrame.BackgroundColor3 = Library.Theme.Surface2
			PickerFrame.BackgroundTransparency = 0.4
			PickerFrame.BorderSizePixel = 0
			PickerFrame.Size = UDim2.new(1, -4, 0, 200)
			Instance.new("UICorner", PickerFrame).CornerRadius = UDim.new(0, 6)

			local PickerLabel = Instance.new("TextLabel", PickerFrame)
			PickerLabel.BackgroundTransparency = 1
			PickerLabel.Size = UDim2.new(1, 0, 0, 18)
			PickerLabel.Position = UDim2.new(0, 12, 0, 5)
			PickerLabel.Font = Enum.Font.GothamMedium
			PickerLabel.Text = name
			PickerLabel.TextColor3 = Library.Theme.Text
			PickerLabel.TextTransparency = 0.15
			PickerLabel.TextSize = 12
			PickerLabel.TextXAlignment = Enum.TextXAlignment.Left

			local HueBar = Instance.new("Frame")
			HueBar.Parent = PickerFrame
			HueBar.Size = UDim2.new(0, 16, 1, -60)
			HueBar.Position = UDim2.new(1, -22, 0, 28)
			HueBar.BorderSizePixel = 0
			Instance.new("UICorner", HueBar).CornerRadius = UDim.new(0, 3)

			local hueGradient = Instance.new("UIGradient", HueBar)
			hueGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
				ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
				ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
				ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
				ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
			})
			hueGradient.Rotation = 90

			local HueDot = Instance.new("Frame", HueBar)
			HueDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueDot.BorderSizePixel = 0
			HueDot.Size = UDim2.new(0, 20, 0, 6)
			HueDot.Position = UDim2.new(-0.125, 0, 0, -3)
			HueDot.ZIndex = 5
			Instance.new("UICorner", HueDot).CornerRadius = UDim.new(0, 2)
			Instance.new("UIStroke", HueDot).Color = Color3.fromRGB(0, 0, 0)
			HueDot.UIStroke.Thickness = 0.5

			local ColorCanvas = Instance.new("Frame")
			ColorCanvas.Parent = PickerFrame
			ColorCanvas.Size = UDim2.new(1, -48, 1, -60)
			ColorCanvas.Position = UDim2.new(0, 12, 0, 28)
			ColorCanvas.BorderSizePixel = 0
			Instance.new("UICorner", ColorCanvas).CornerRadius = UDim.new(0, 3)

			local SatGradient = Instance.new("UIGradient", ColorCanvas)
			SatGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
			})

			local ValGradient = Instance.new("UIGradient", ColorCanvas)
			ValGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
			})
			ValGradient.Rotation = 90
			ValGradient.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 1),
			})

			local CanvasDot = Instance.new("Frame", ColorCanvas)
			CanvasDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CanvasDot.BorderSizePixel = 0
			CanvasDot.Size = UDim2.new(0, 8, 0, 8)
			CanvasDot.Position = UDim2.new(1, -4, 0, -4)
			CanvasDot.ZIndex = 5
			CanvasDot.AnchorPoint = Vector2.new(0.5, 0.5)
			Instance.new("UICorner", CanvasDot).CornerRadius = UDim.new(1, 0)
			Instance.new("UIStroke", CanvasDot).Color = Color3.fromRGB(0, 0, 0)
			CanvasDot.UIStroke.Thickness = 0.5

			local RInput = Instance.new("TextBox", PickerFrame)
			RInput.BackgroundColor3 = Library.Theme.Surface
			RInput.BorderSizePixel = 0
			RInput.Size = UDim2.new(0, 40, 0, 20)
			RInput.Position = UDim2.new(0, 12, 1, -28)
			RInput.Font = Enum.Font.Gotham
			RInput.Text = "255"
			RInput.TextColor3 = Color3.fromRGB(255, 100, 100)
			RInput.TextSize = 11
			Instance.new("UICorner", RInput).CornerRadius = UDim.new(0, 3)

			local GInput = Instance.new("TextBox", PickerFrame)
			GInput.BackgroundColor3 = Library.Theme.Surface
			GInput.BorderSizePixel = 0
			GInput.Size = UDim2.new(0, 40, 0, 20)
			GInput.Position = UDim2.new(0, 56, 1, -28)
			GInput.Font = Enum.Font.Gotham
			GInput.Text = "0"
			GInput.TextColor3 = Color3.fromRGB(80, 255, 120)
			GInput.TextSize = 11
			Instance.new("UICorner", GInput).CornerRadius = UDim.new(0, 3)

			local BInput = Instance.new("TextBox", PickerFrame)
			BInput.BackgroundColor3 = Library.Theme.Surface
			BInput.BorderSizePixel = 0
			BInput.Size = UDim2.new(0, 40, 0, 20)
			BInput.Position = UDim2.new(0, 100, 1, -28)
			BInput.Font = Enum.Font.Gotham
			BInput.Text = "0"
			BInput.TextColor3 = Color3.fromRGB(100, 150, 255)
			BInput.TextSize = 11
			Instance.new("UICorner", BInput).CornerRadius = UDim.new(0, 3)

			local Preview = Instance.new("Frame", PickerFrame)
			Preview.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			Preview.BorderSizePixel = 0
			Preview.Size = UDim2.new(0, 20, 0, 20)
			Preview.Position = UDim2.new(1, -42, 1, -28)
			Instance.new("UICorner", Preview).CornerRadius = UDim.new(1, 0)

			local hue, sat, val = 1, 1, 1

			local function updateFromHSV()
				local color = Color3.fromHSV(hue, sat, val)
				RInput.Text = tostring(math.floor(color.R*255+0.5))
				GInput.Text = tostring(math.floor(color.G*255+0.5))
				BInput.Text = tostring(math.floor(color.B*255+0.5))
				Preview.BackgroundColor3 = color
				SatGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromHSV(hue,1,1))})
				callback(color)
			end

			local function updateFromRGB()
				local r = math.clamp(tonumber(RInput.Text) or 255, 0, 255)
				local g = math.clamp(tonumber(GInput.Text) or 0, 0, 255)
				local b = math.clamp(tonumber(BInput.Text) or 0, 0, 255)
				local color = Color3.fromRGB(r, g, b)
				hue, sat, val = Color3.toHSV(color)
				Preview.BackgroundColor3 = color
				CanvasDot.Position = UDim2.new(sat, 0, 1-val, 0)
				HueDot.Position = UDim2.new(-0.125, 0, hue, -3)
				SatGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromHSV(hue,1,1))})
				callback(color)
			end

			local hueDragging = false
			HueBar.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					hueDragging = true
					local conn = UserInputService.InputChanged:Connect(function(change)
						if hueDragging and (change.UserInputType == Enum.UserInputType.MouseMovement or change.UserInputType == Enum.UserInputType.Touch) then
							hue = math.clamp((change.Position.Y - HueBar.AbsolutePosition.Y) / HueBar.AbsoluteSize.Y, 0, 1)
							HueDot.Position = UDim2.new(-0.125, 0, hue, -3)
							updateFromHSV()
						end
					end)
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.TouchEnded then
							hueDragging = false; conn:Disconnect()
						end
					end)
				end
			end)

			local canvasDragging = false
			ColorCanvas.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					canvasDragging = true
					local conn = UserInputService.InputChanged:Connect(function(change)
						if canvasDragging and (change.UserInputType == Enum.UserInputType.MouseMovement or change.UserInputType == Enum.UserInputType.Touch) then
							sat = math.clamp((change.Position.X - ColorCanvas.AbsolutePosition.X) / ColorCanvas.AbsoluteSize.X, 0, 1)
							val = 1 - math.clamp((change.Position.Y - ColorCanvas.AbsolutePosition.Y) / ColorCanvas.AbsoluteSize.Y, 0, 1)
							CanvasDot.Position = UDim2.new(sat, 0, 1-val, 0)
							updateFromHSV()
						end
					end)
					UserInputService.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.TouchEnded then
							canvasDragging = false; conn:Disconnect()
						end
					end)
				end
			end)

			RInput.FocusLost:Connect(function(ep) if ep then updateFromRGB() end end)
			GInput.FocusLost:Connect(function(ep) if ep then updateFromRGB() end end)
			BInput.FocusLost:Connect(function(ep) if ep then updateFromRGB() end end)
		end

		-- ============================================
		-- TAB:SECTION()
		-- ============================================
		function tab:Section(title)
			local Section = Instance.new("Frame")
			Section.Parent = page
			Section.BackgroundTransparency = 1
			Section.Size = UDim2.new(1, -4, 0, 22)

			local Label = Instance.new("TextLabel", Section)
			Label.BackgroundTransparency = 1
			Label.Size = UDim2.new(1, 0, 1, 0)
			Label.Position = UDim2.new(0, 6, 0, 0)
			Label.Font = Enum.Font.GothamBold
			Label.Text = title
			Label.TextColor3 = Library.Theme.SubText
			Label.TextTransparency = 0.5
			Label.TextSize = 10
			Label.TextXAlignment = Enum.TextXAlignment.Left
		end

		return tab
	end

	-- ============================================
	-- KEYBIND TOGGLE
	-- ============================================
	UserInputService.InputBegan:Connect(function(input, gp)
		if not gp and input.KeyCode == gui.Settings.Keybind then
			MainContainer.Visible = not MainContainer.Visible
		end
	end)

	-- ============================================
	-- DRAG
	-- ============================================
	local guiDragging, guiDragStart, guiStartPos = false, nil, nil
	TopBar.InputBegan:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and gui.Settings.Draggable then
			guiDragging, guiDragStart, guiStartPos = true, input.Position, Main.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(input)
		if guiDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - guiDragStart
			local smooth = gui.Settings.DragSmoothness / 6
			TweenService:Create(Main, TweenInfo.new(smooth), {Position = UDim2.new(guiStartPos.X.Scale, guiStartPos.X.Offset + delta.X, guiStartPos.Y.Scale, guiStartPos.Y.Offset + delta.Y)}):Play()
			TweenService:Create(Glow, TweenInfo.new(smooth), {Position = UDim2.new(guiStartPos.X.Scale, guiStartPos.X.Offset + delta.X - 6, guiStartPos.Y.Scale, guiStartPos.Y.Offset + delta.Y - 6)}):Play()
		end
	end)
	UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.TouchEnded then
			guiDragging = false
		end
	end)

	-- ============================================
	-- ENTRY
	-- ============================================
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(isStudio and 0.5 or 1, isStudio and -230 or -460, 0.5, -280)
	Glow.BackgroundTransparency = 1
	TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0, Position = UDim2.new(isStudio and 0.5 or 1, isStudio and -230 or -500, 0.5, -230)}):Play()
	TweenService:Create(Glow, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.94, Position = UDim2.new(isStudio and 0.5 or 1, isStudio and -236 or -506, 0.5, -236)}):Play()

	return gui
end

return Library

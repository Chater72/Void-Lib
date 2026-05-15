-- ⬡ Void UI Library v5.0 - Test Code
-- Пример использования всех элементов

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Chater72/Void-Lib/main/src.lua"))()

local gui = Library:Create()

-- ============================================
-- TAB: Main
-- ============================================
local mainTab = gui:Tab("⌂ Main")

mainTab:Section("Combat")
mainTab:Toggle({
    Name = "🎯 Aimbot",
    Default = true,
    Callback = function(v)
        print("Aimbot:", v)
    end
})

mainTab:Toggle({
    Name = "🔇 Silent Aim",
    Default = false,
    Callback = function(v)
        print("Silent Aim:", v)
    end
})

mainTab:Slider({
    Name = "FOV Circle",
    Min = 30,
    Max = 300,
    Default = 90,
    Callback = function(v)
        print("FOV:", v)
    end
})

mainTab:Slider({
    Name = "Smoothness",
    Min = 1,
    Max = 20,
    Default = 8,
    Callback = function(v)
        print("Smoothness:", v)
    end
})

mainTab:Section("Hitbox")
mainTab:Toggle({
    Name = "📦 Hitbox Extender",
    Default = true
})

mainTab:Slider({
    Name = "Hitbox Size",
    Min = 1,
    Max = 25,
    Default = 12
})

-- ============================================
-- TAB: Visuals
-- ============================================
local visualsTab = gui:Tab("◉ Visuals")

visualsTab:Section("Player ESP")
visualsTab:Toggle({
    Name = "📦 Box ESP",
    Default = true
})

visualsTab:Toggle({
    Name = "💚 Health ESP",
    Default = true
})

visualsTab:Toggle({
    Name = "📛 Name ESP",
    Default = true
})

visualsTab:Toggle({
    Name = "📏 Distance ESP",
    Default = false
})

visualsTab:Section("World")
visualsTab:Toggle({
    Name = "👁 Chams",
    Default = false
})

visualsTab:Toggle({
    Name = "✨ Tracers",
    Default = true
})

-- ============================================
-- TAB: Movement
-- ============================================
local moveTab = gui:Tab("🏃 Movement")

moveTab:Section("Speed")
moveTab:Toggle({
    Name = "🏃 Speed Hack",
    Default = false
})

moveTab:Slider({
    Name = "Speed Value",
    Min = 16,
    Max = 100,
    Default = 32
})

moveTab:Section("Flight")
moveTab:Toggle({
    Name = "🕊 Fly",
    Default = false
})

moveTab:Toggle({
    Name = "👻 NoClip",
    Default = false
})

-- ============================================
-- TAB: Misc
-- ============================================
local miscTab = gui:Tab("🔧 Misc")

miscTab:Section("Utility")
miscTab:Toggle({
    Name = "🛡 Anti-AFK",
    Default = true
})

miscTab:Section("Player")
miscTab:Toggle({
    Name = "👤 Invisible",
    Default = false
})

miscTab:Toggle({
    Name = "📸 Freecam",
    Default = false
})

miscTab:Slider({
    Name = "FOV Changer",
    Min = 30,
    Max = 120,
    Default = 70
})

-- ============================================
-- TAB: Settings
-- ============================================
local settingsTab = gui:Tab("⚙ Settings")

settingsTab:Section("Keybind")
settingsTab:Keybind({
    Callback = function(key)
        print("Keybind set to:", key.Name)
    end
})

settingsTab:Section("Appearance")
settingsTab:ColorPicker({
    Name = "Accent Color",
    Callback = function(color)
        print("Selected color:", color)
    end
})

settingsTab:Slider({
    Name = "Drag Smoothness",
    Min = 1,
    Max = 6,
    Default = 3,
    Callback = function(v)
        gui.Settings.DragSmoothness = v
    end
})

settingsTab:Toggle({
    Name = "📌 Pin GUI",
    Default = false,
    Callback = function(v)
        gui.Settings.Draggable = not v
    end
})

settingsTab:Section("Dropdown Example")
settingsTab:Dropdown({
    Name = "Select Target",
    Items = {"Head", "Torso", "Legs", "Random"},
    Callback = function(item)
        print("Selected:", item)
    end
})

settingsTab:Dropdown({
    Name = "Select Priority",
    Items = {
        {"High", 1},
        {"Medium", 2},
        {"Low", 3}
    },
    Callback = function(value)
        print("Priority value:", value)
    end
})

settingsTab:Section("Danger Zone")
settingsTab:Button({
    Name = "💀 Destroy GUI",
    Callback = function()
        print("GUI Destroyed!")
    end
})

settingsTab:Button({
    Name = "🔗 Discord",
    Callback = function()
        print("Discord: @code_killer_editor")
    end
})

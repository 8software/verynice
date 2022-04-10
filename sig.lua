local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()
lib.new("success", "bloxENGINE", "carregado com sucesso!")

local water = Instance.new("ScreenGui")
local mark = Instance.new("TextLabel")

water.Name = "water"
water.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
water.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
water.ResetOnSpawn = false

mark.Name = "mark"
mark.Parent = water
mark.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
mark.BackgroundTransparency = 0.800
mark.BorderColor3 = Color3.fromRGB(0, 0, 0)
mark.BorderSizePixel = 2
mark.Position = UDim2.new(0.00638588052, 0, 0.95, 0)
mark.Size = UDim2.new(0, 116, 0, 20)
mark.Font = Enum.Font.Roboto
mark.Text = " bloxENGINE v0.1.12"
mark.TextColor3 = Color3.fromRGB(255, 255, 255)
mark.TextSize = 14.000
mark.TextWrapped = true
mark.TextXAlignment = Enum.TextXAlignment.Left

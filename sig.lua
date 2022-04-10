local ScreenGui = Instance.new("ScreenGui")
local ImageLabel = Instance.new("ImageLabel")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

TextLabel.Parent = ScreenGui
TextLabel.AnchorPoint = Vector2.new(1, 1)
TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1.000
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.99000001, 0, 1, 0)
TextLabel.Size = UDim2.new(0, 131, 0, 24)
TextLabel.Font = Enum.Font.SourceSans
TextLabel.Text = "bloxENGINE v0.1.12"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextSize = 16.000

--new
local water = Instance.new("ScreenGui")
local mark = Instance.new("TextLabel")
--Properties:
water.Name = "water"
water.Parent = game.Workspace
water.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

mark.Name = "mark"
mark.Parent = water
mark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mark.BackgroundTransparency = 1.000
mark.BorderColor3 = Color3.fromRGB(0, 0, 0)
mark.Position = UDim2.new(0.0185070951, 0, 0, 0)
mark.Size = UDim2.new(0, 162, 0, 63)
mark.Font = Enum.Font.Roboto
mark.Text = "bloxENGINE v0.1.12"
mark.TextColor3 = Color3.fromRGB(255, 255, 255)
mark.TextSize = 14.000
mark.TextWrapped = true
mark.TextXAlignment = Enum.TextXAlignment.Left
